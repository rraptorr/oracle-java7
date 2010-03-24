#!/bin/bash
# make debian/copyright file for sun-java5

program=`basename $0`
jdkdir=${jdkdir:-.}
jdkdistrosdir=${jdkdistrosdir:-.}
pkgdir=${pkgdir:-.}
sep="  - - - - -  "

pkg_preamble=$jdkdistrosdir/PKG_PREAMBLE
pkg_notice=$jdkdistrosdir/PKG_NOTICE
pkg_license=$jdkdistrosdir/MIT_LICENSE
upstream_notice=$jdkdir/COPYRIGHT
upstream_license=$jdkdir/LICENSE
third_license=$jdkdir/THIRDPARTYLICENSEREADME.txt
copyright=$pkgdir/copyright

checkfiles() {
  for i in $*; do
    if [ ! -f $i ]; then
      echo "${program}: cannot find file: $i"
      exit 1
    fi
  done
}

savefile() {
  # save previous version
  if [ -f $1 ]; then
    mv $1 $1.1
  fi
}

generate() {
  cat $pkg_preamble >> $copyright
  echo " " >> $copyright

  echo "$sep copyright notice and license for Debian packaging $sep" >> $copyright
  echo " " >> $copyright
  cat $pkg_notice >> $copyright
  echo " " >> $copyright
  cat $pkg_license >> $copyright
  echo " " >> $copyright

  echo "$sep copyright notice and license for upstream $sep" >> $copyright
  echo " " >> $copyright
  cat $upstream_notice >> $copyright
  echo " " >> $copyright
  cat $upstream_license >> $copyright
  echo " " >> $copyright

  if [ -f $third_license ]; then
    echo "$sep third party copyright notice(s) and license(s) $sep" >> $copyright
    echo " " >> $copyright
    cat $third_license >> $copyright
  fi
}

checkfiles $pkg_preamble $pkg_notice $pkg_license $upstream_notice $upstream_license
savefile $copyright
generate



