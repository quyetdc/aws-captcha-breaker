require 'captcha/solver'

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
