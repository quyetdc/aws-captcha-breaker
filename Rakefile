require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'captcha'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :bypass do
  files = Dir['images/*']
  files.each do |file_name|    
    unless File.directory? file_name
      decoded_text = Captcha::Solver.new({lang: :eng,
					                      options: :captcha,
					                      psm: 7,
					                      image_path: file_name}).solve
      puts "#{file_name.split('/').last.split('.')[0]}: #{decoded_text}"
    end
  end
end

task :antigate do
  files = Dir['images/*']
  files.each do |file_name|    
    unless File.directory? file_name      
      captcha_answer = Captcha::Antigate.new(file_name).break[:captcha_answer]
      
      puts "#{file_name.split('/').last.split('.')[0]}: #{captcha_answer}"
    end
  end
end
