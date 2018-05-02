## Amazon Captcha decoder

### Introduction
Sometimes, you will see Amazon require user to enter a captcha to continue. This project aims to automatically bypass those captchas. 

If you want to automatically login to amazon as a bot, this project will be useful

- The project has two separated methods. 

- The first method is to decode captcha manually using `rtesseract` and `rmagick`

- The second one is to use a third party paid api called `antigate`

- The source files are placed in `lib` folder.

- Tested images in `images` folder

- Gem dependencies are defined in `captcha.gemspec`

### Installation

- Instal rmagick dependency
	+ on macos
	```
		brew install imagemagick@6
		brew link --force imagemagick@6
		echo 'export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"' >> ~/.bash_profile
	```

- Install Tesseract OCR
	```
	  brew install tesseract --all-languages
	```

### Usage

Change your key in lib/captcha/antigate then run

```
rake antigate
```

Or try free version

```
rake bypass
```
