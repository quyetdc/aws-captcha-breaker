require 'captcha/antigate'

task :antigate do
  files = Dir['images/*']
  files.each do |file_name|    
    unless File.directory? file_name      
      captcha_answer = Captcha::Antigate.new(file_name).break[:captcha_answer]
      
      puts "#{file_name.split('/').last.split('.')[0]}: #{captcha_answer}"
    end
  end
end
