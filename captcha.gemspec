
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "captcha/version"

Gem::Specification.new do |spec|
  spec.name          = "captcha"
  spec.version       = Captcha::VERSION
  spec.authors       = ["ColinDao"]
  spec.email         = ["quyetdc.uet@gmail.com"]

  spec.summary       = %q{Quyet Dao Captcha gem}
  spec.description   = %q{Captcha description}
  spec.homepage      = "http://quyetdc.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://quyetdc.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rtesseract", "~> 2.2"
  
  spec.add_development_dependency "rmagick", "~> 2.15"
  spec.add_development_dependency "two_captcha"

  spec.add_development_dependency "antigate"
  spec.add_development_dependency "multipart-post"  
  spec.add_development_dependency "antigate_api"
  

end
