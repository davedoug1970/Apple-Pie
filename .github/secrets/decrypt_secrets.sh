#!/bin/sh
set -eo pipefail

gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/Team_iOS_Development.mobileprovision ./.github/secrets/Team_iOS_Development.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/AppleDevelopmentCert.p12 ./.github/secrets/AppleDevelopmentCert.p12.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

cp ./.github/secrets/Team_iOS_Development.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/Team_iOS_Development.mobileprovision


security create-keychain -p "" build.keychain
security import ./.github/secrets/AppleDevelopmentCert.p12 -t agg -k ~/Library/Keychains/build.keychain -P "oHXF4VE6dQbw" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain
