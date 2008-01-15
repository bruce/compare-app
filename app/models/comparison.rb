require 'open4'

class Comparison < ActiveRecord::Base
  
  VERSIONS = {
    '1.8' => '/usr/bin/ruby',
    '1.9' => '/usr/local/bin/ruby1.9'
  }
  
  has_many :results, :order => 'version asc'
  
  validates_presence_of :name
  validates_presence_of :code
  
  after_save :execute
  
  attr_reader :file
  def file=(io)
    if !io.blank? && !@read_file
      write_attribute(:code, io.read)
      @read_file = true
    end
  end
  
  def same?(field=nil)
    if field
      results.map { |r| r.__send__(field) }.uniq.size == 1
    else
      results.each do |r1|
        results.each do |r2|
          return false unless r1 == r2
        end
      end
      true
    end
  end
  
  #######
  private
  #######

  def execute
    results.destroy_all
    VERSIONS.each do |number, executable|
      results.create(result_for(executable).merge(:version => number))
    end
  end
  
  def result_for(executable)
    record = {}
    status = Open4::popen4(executable, '-w') do |pid, stdin, stdout, stderr|
      benchmark = Benchmark.measure do
        stdin.puts code
        stdin.close
      end
      %w(stdout stderr).each do |channel|
        output = eval "#{channel}.read.strip"
        case output
        when /[^[:print:]]/
          record.update("binary_#{channel}" => true)
        else
          record.update(channel => output)
        end
      end
      record.update(:benchmark => benchmark)
    end
    record.merge(:exit_code => status.exitstatus.to_i)
  end
  
  def binary?(string)
    string =~ /[^[:print:]]/
  end
  
end
