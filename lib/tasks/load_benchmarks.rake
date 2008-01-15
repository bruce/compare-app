namespace :benchmarks do
  
  task :load => :environment do
    files = Dir[File.dirname(__FILE__) << "/benchmark/*.rb"]
    files.each do |file|
      puts "Running `#{File.basename(file)}'..."
      Comparison.create(
        :name => File.basename(file),
        :code => File.read(file)
      )
    end
  end
  
end