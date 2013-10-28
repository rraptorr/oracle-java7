#!/bin/sh

export LC_ALL=C
export LANG=C

dir=`dirname "$0"`

version=`dpkg-parsechangelog -l"$dir"/debian/changelog | sed -ne '/Version:/ s,Version: \(.*\),\1,p' | tr '.-' ' '`
major=`echo $version | cut -d" " -f 1`
minor=`echo $version | cut -d" " -f 2`
debian=`echo $version | cut -d" " -f 3`

while [ $# -gt 0 ] ; do
    case "$1" in
        *UnlimitedJCEPolicyJDK7.zip)
            rm -rf "$dir"/UnlimitedJCEPolicy
            unzip -q "$1" -d "$dir"
            tar -czf "$dir"/../oracle-java${major}_${major}.${minor}.orig-UnlimitedJCEPolicy.tar.gz -C "$dir" UnlimitedJCEPolicy
            rm -f "$1"
            ;;
        *jdk-${major}u${minor}-linux-i586.tar.gz)
            rm -rf "$dir"/i586 "$dir"/jdk1.${major}.0_${minor}
            tar xf "$1" -C "$dir"
            mv "$dir"/jdk1.${major}.0_${minor} "$dir"/i586
            mv "$1" "$dir"/../oracle-java${major}_${major}.${minor}.orig-i586.tar.gz
            ;;
        *jdk-${major}u${minor}-linux-x64.tar.gz)
            rm -rf "$dir"/x64 "$dir"/jdk1.${major}.0_${minor}
            tar xf "$1" -C "$dir"
            mv "$dir"/jdk1.${major}.0_${minor} "$dir"/x64
            mv "$1" "$dir"/../oracle-java${major}_${major}.${minor}.orig-x64.tar.gz
            ;;
        *)
            echo unknown file: \"$1\"
            ;;
    esac
    shift
done

git --git-dir="$dir"/.git archive -o "$dir"/../oracle-java${major}_${major}.${minor}.orig.tar.gz --prefix=oracle_java${major}-${major}.${minor}/ HEAD README.md
