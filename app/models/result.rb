class Result < ActiveRecord::Base
  
  include Comparable
  
  validates_presence_of :version
  validates_presence_of :exit_code
  
  def <=>(other)
    fields = %w(exit_code stdout stderr)
    if fields.all? { |f| self.__send__(f) == other.__send__(f) }
      0
    else
      1
    end
  end
    
end
