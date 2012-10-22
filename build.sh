#!/bin/tcsh -f

rm -rf compiled/*

./configure \
--cc=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc \
--as='/usr/local/bin/gas-preprocessor.pl /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc' \
--sysroot=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk \
--target-os=darwin \
--arch=arm \
--cpu=cortex-a8 \
--extra-cflags='-arch armv7' \
--extra-ldflags='-arch armv7 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk' \
--prefix=compiled/armv7 \
--enable-cross-compile \
--enable-nonfree \
--enable-decoders \
--enable-encoders \
--enable-muxers \
--enable-muxer=mpegts \
--enable-bsf=h264_mp4toannexb \
--enable-protocols \
--enable-static \
--enable-decoder=h264 \
--enable-decoder=svq3 \
--enable-gpl \
--enable-decoder=rawvideo \
--disable-armv5te \
--disable-swscale-alpha \
--disable-doc \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-asm \
#--disable-bzlib \
#--disable-shared \
#--disable-mmx \
#--disable-neon \
#--disable-demuxers \
#--disable-parsers \
#--disable-filters \
#--disable-bsfs \
#--disable-postproc 
#--disable-debug 

