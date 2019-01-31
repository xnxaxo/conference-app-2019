#!/usr/bin/env bash

set -eu

source "$(dirname $0)/bash.source"

use_release_keystore
 ./gradlew bundleRelease --offline
create_universal_apk_from_aab.bash $(find frontend/android/build/outputs -name "*.aab" | head -1)

curl -sL "https://raw.githubusercontent.com/jmatsu/dpg/master/install.bash" | bash

./dpg apps upload --android \
  --app-owner droidkaigi
  --app "$UNIVERSAL_APK_PATH"
  --message "Release build at $(date)"
