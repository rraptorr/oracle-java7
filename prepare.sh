#!/bin/sh

export LC_ALL=C
export LANG=C

dir=`dirname "$0"`

version=`dpkg-parsechangelog -l"$dir"/debian/changelog | sed -ne '/Version:/ s,Version: \(.*\),\1,p' | tr '.-' ' '`
major=`echo $version | cut -d" " -f 1`
minor=`echo $version | cut -d" " -f 2`
debian=`echo $version | cut -d" " -f 3`

make -f "$dir"/debian/rules -C "$dir" get-orig-source

rm -rf "$dir"/UnlimitedJCEPolicy
unzip -q "$dir"/UnlimitedJCEPolicyJDK7.zip -d "$dir"
tar -czf "$dir"/../oracle-java${major}_${major}.${minor}.orig-UnlimitedJCEPolicy.tar.gz -C "$dir" UnlimitedJCEPolicy
rm -f "$dir"/UnlimitedJCEPolicyJDK7.zip

rm -rf "$dir"/i586 "$dir"/jdk1.${major}.0_${minor}
tar xf "$dir"/jdk-${major}u${minor}-linux-i586.tar.gz -C "$dir"
mv "$dir"/jdk1.${major}.0_${minor} "$dir"/i586
mv "$dir"/jdk-${major}u${minor}-linux-i586.tar.gz "$dir"/../oracle-java${major}_${major}.${minor}.orig-i586.tar.gz

rm -rf "$dir"/x64 "$dir"/jdk1.${major}.0_${minor}
tar xf "$dir"/jdk-${major}u${minor}-linux-x64.tar.gz -C "$dir"
mv "$dir"/jdk1.${major}.0_${minor} "$dir"/x64
mv "$dir"/jdk-${major}u${minor}-linux-x64.tar.gz "$dir"/../oracle-java${major}_${major}.${minor}.orig-x64.tar.gz

git --git-dir="$dir"/.git archive --format=tar --prefix=oracle_java${major}-${major}.${minor}/ HEAD README.md prepare.sh | gzip > "$dir"/../oracle-java${major}_${major}.${minor}.orig.tar.gz
