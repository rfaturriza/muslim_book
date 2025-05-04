#!/bin/bash
# Script to generate Firebase configuration files for different environments/flavors
# Feel free to reuse and adapt this script for your own projects

if [[ $# -eq 0 ]]; then
  echo "Error: No environment specified. Use 'dev', 'stg', or 'prod'."
  exit 1
fi

case $1 in
  debug)
    flutterfire config \
      --project=kajianhub-debug \
      --out=lib/firebase_options_debug.dart \
      --ios-bundle-id=com.kajianhub.debug \
      --ios-out=ios/Runner/Firebase/Debug/GoogleService-Info.plist \
      --android-package-name=com.rizz.quranku.debug \
      --android-out=android/app/src/debug/google-services.json \
      --android-out=android/app/src/profile/google-services.json
    ;;
  release)
    flutterfire config \
      --project=play-integrity-obnkqdhsjgwbto9 \
      --out=lib/firebase_options.dart \
      --ios-bundle-id=com.kajianhub \
      --ios-out=ios/Runner/Firebase/Release/GoogleService-Info.plist \
      --android-package-name=com.kajianhub \
      --android-out=android/app/src/main/google-services.json
    ;;
  *)
    echo "Error: Invalid environment specified. Use 'debug', 'release'."
    exit 1
    ;;
esac