namespace :benchmarks do
  
  task :load => :environment do
    files = Dir[File.dirname(__FILE__) << "/benchmark/*.rb"]
    files.each_with_index do |file, offset|
      puts "Running `#{File.basename(file)}' (#{offset + 1}/#{files.size})..."
      item = nil
      begin
        item = Comparison.create(
          :name => File.basename(file),
          :code => File.read(file),
          :description => "Benchmark from the Ruby 1.9 repository"
        )
      rescue => e
        item.destroy unless item.new_record?
        puts "... could not execute (#{e})"
      end
    end
  end
  
end