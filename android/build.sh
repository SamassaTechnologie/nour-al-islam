#!/usr/bin/env bash
# Compile et signe l'application Android. Le mot de passe de la clé n'est jamais affiché.
# Usage : bash build.sh <versionCode> <versionName>
set -euo pipefail
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
export ANDROID_HOME=/opt/android ANDROID_SDK_ROOT=/opt/android
BT=/opt/android/build-tools/35.0.0
KEYS=/vercel/keys
mkdir -p "$KEYS" && chmod 700 "$KEYS"
if [ ! -f "$KEYS/upload.jks" ]; then
  umask 077
  openssl rand -base64 24 | tr -d '\n' > "$KEYS/pass"
  keytool -genkeypair -noprompt -keystore "$KEYS/upload.jks" -alias nour -keyalg RSA -keysize 2048 -validity 10000 \
    -dname "CN=SAMASSA TECHNOLOGIE, O=SAMASSA TECHNOLOGIE, C=ML" -storepass:file "$KEYS/pass" -keypass:file "$KEYS/pass" >/dev/null 2>&1
  echo "CLE CREEE"
fi
OUT=/vercel/out; rm -rf /vercel/project "$OUT"; mkdir -p "$OUT"
cp /vercel/android/generate.mjs /vercel/twa/ && cd /vercel/twa && node generate.mjs /vercel/project "$1" "$2"
cd /vercel/project && chmod +x gradlew && ./gradlew --no-daemon -q assembleRelease bundleRelease
"$BT/zipalign" -f -p 4 app/build/outputs/apk/release/app-release-unsigned.apk "$OUT/aligned.apk"
"$BT/apksigner" sign --ks "$KEYS/upload.jks" --ks-key-alias nour --ks-pass "file:$KEYS/pass" --out "$OUT/nour-al-islam-$2.apk" "$OUT/aligned.apk"
cp app/build/outputs/bundle/release/app-release.aab "$OUT/nour-al-islam-$2.aab"
jarsigner -keystore "$KEYS/upload.jks" -storepass:file "$KEYS/pass" -keypass:file "$KEYS/pass" "$OUT/nour-al-islam-$2.aab" nour >/dev/null
rm -f "$OUT/aligned.apk"
"$BT/apksigner" verify --print-certs "$OUT/nour-al-islam-$2.apk" | grep -E "SHA-256" || true
ls -la "$OUT"; sha256sum "$OUT"/*
echo BUILD OK
