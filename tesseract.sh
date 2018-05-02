cd /opt

yum -y update 
yum -y install libstdc++ autoconf automake libtool autoconf-archive pkg-config gcc gcc-c++ make libjpeg-devel libpng-devel libtiff-devel zlib-devel

#Install AutoConf-Archive
wget ftp://mirror.switch.ch/pool/4/mirror/epel/7/ppc64/a/autoconf-archive-2016.09.16-1.el7.noarch.rpm
rpm -i autoconf-archive-2016.09.16-1.el7.noarch.rpm

#Install Leptonica from Source
wget http://www.leptonica.com/source/leptonica-1.75.3.tar.gz
tar -zxvf leptonica-1.75.3.tar.gz
cd leptonica-1.75.3
./autobuild
./configure
make
make install
cd ..

#Install Tesseract from Source
wget https://github.com/tesseract-ocr/tesseract/archive/3.05.01.tar.gz
tar -zxvf 3.05.01.tar.gz
cd tesseract-3.05.01
./autogen.sh
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig LIBLEPT_HEADERSDIR=/usr/local/include ./configure --with-extra-includes=/usr/local/include --with-extra-libraries=/usr/local/lib
LDFLAGS="-L/usr/local/lib" CFLAGS="-I/usr/local/include" make
make install
ldconfig
cd ..

#Download and install tesseract language files
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/eng.traineddata
mv *.traineddata /usr/local/share/tessdata


ln -s /opt/tesseract-3.05.01 /opt/tesseract-latest
