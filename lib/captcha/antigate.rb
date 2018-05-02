require 'net/http/post/multipart'
require 'antigate_api'

module Captcha
  class Antigate
    def initialize(image_string)
      @image_string = image_string
    end

    def break
      options = {
        recognition_time: 5, # First waiting time
        sleep_time: 1, # Sleep time for every check interval
        timeout: 60, # Max time out for decoding captcha
        debug: false # Verborse or not
      }

      client = AntigateApi::Client.new('ANTIGATE_KEY', options)
      captcha_id, captcha_answer = client.decode(@image_string)

      { capcha_id: captcha_id, captcha_answer: captcha_answer }
    end
  end
end
