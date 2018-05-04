require 'rtesseract'
require 'rmagick'

# Transform and solve captchas
module Captcha

  class Solver
    def initialize(args = {})
      @psm = args[:psm]
      @options = args[:options]
      @lang = args[:lang]
      @image_path = args[:image_path]
      @solved_path = "solved_images/#{@image_path.split('/').last.split('.')[0]}.jpeg"
    end

    def solve
      # read image from disk
      img = Magick::Image.read(@image_path).first
      
      # process image to reduce noise and improve text quality
      img = process_image(img)

      # save the image in disk
      img.write(@solved_path)

      # extract result
      extracted_text = extract_characters
      return extracted_text if extracted_text.match(/\A[a-zA-Z0-9]{6}\z/)

    
      img = enhance(img)
      img.write(@solved_path)
      extracted_text = extract_characters
      
      printf "CANNOT BYPASS CAPTCHA --- " unless extracted_text.match(/\A[a-zA-Z0-9]{6}\z/) 
      extracted_text
    end

    def process_image(img)
      # reduce size
      # img.scale! 0.75
      
      # crop image, remove bottom part
      img_width = img.columns
      img_height = img.rows
      # args X, Y, width, height
      img = img.crop 0, 5, img_width - 5, img_height - 20
      
      # transform image into gray scale colors
      img = img.quantize(128, Magick::GRAYColorspace)

      # convert into white everything below the threshold
      img = img.white_threshold(180 * 256)

      # transform image into binary colors
      img = img.quantize(2, Magick::GRAYColorspace)

      # Add border to avoid noise there
      # img.border!(5, 5, 'white')
    end

    def enhance(img)
      # clean extra noise
      clean_image img, 4
      # fill blank spots
      fill(img, 2)

      # remove_stripes img
    end
  
    def remove_stripes(img, range = 20)
      color = 'black'
      img.each_pixel do |pixel, c, r|
        next if border?(c, range, img.columns) || border?(r, range, img.rows)
        
        to_change = true
        
        range.times do |i|
          to_change = false if (!pixel.to_color.eql? color) || (!img.pixel_color(c+i, r+i).to_color.eql? color)
        end
        
        if to_change
           range.times do |i|
             img.pixel_color(c+i, r+i, 'white')
           end
        end
      end
    end

    # Fill white spots with black pixels
    def fill(img, range, color = 'black')
      process img, color, range
    end

    # Clean noise
    def clean_image(img, range, color = 'white')
      process img, color, range
    end

    # trim image
    def trim(img)
      img.fuzz = 1
      img.trim!
    end

    # replace colors in a range
    def process(img, color, range)
      img.each_pixel do |_pixel, c, r|
        next if border?(c, range, img.columns) || border?(r, range, img.rows)
        # get the pixel amount for each color
        # in a range * range block around the current pixel
        pixels = img.get_pixels(c, r, range, range).map do |e|
          e if e.to_color.eql? color
        end
        # if the pixel amount it's bigger than ratio,
        # then they're dots that have to be painted
        img.pixel_color(c, r, color) if pixels.compact.size >= range
      end
    end

    # check if current pixel belong from image's border
    def border?(pixel, range, max)
      pixel < range || pixel > (max - range)
    end

    def extract_characters
      text = RTesseract.new(@solved_path,
                            lang: @lang,
                            options: @options,
                            psm: @psm)
      extracted_text = text.to_s_without_spaces
      extracted_text.gsub!(/[^0-9A-Za-z]/, '')
      extracted_text
      
    end
  end
end