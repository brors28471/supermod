#!/bin/bash

# Build script for AgarIOMenu iOS app (.ipa)
# This script builds the app and creates an .ipa file for iOS distribution

set -e

PROJECT_NAME="AgarIOMenu"
SCHEME="AgarIOMenu"
CONFIGURATION="Release"
BUILD_DIR="build"
ARCHIVE_PATH="$BUILD_DIR/$PROJECT_NAME.xcarchive"
EXPORT_PATH="$BUILD_DIR/ipa"

echo "🔨 Building $PROJECT_NAME for iOS..."

# Clean previous builds
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Build archive
echo "📦 Creating archive..."
xcodebuild archive \
    -project "$PROJECT_NAME.xcodeproj" \
    -scheme "$SCHEME" \
    -configuration "$CONFIGURATION" \
    -archivePath "$ARCHIVE_PATH" \
    -derivedDataPath "$BUILD_DIR/DerivedData" \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO

# Export IPA
echo "📱 Exporting IPA..."
mkdir -p "$EXPORT_PATH"

xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$EXPORT_PATH" \
    -exportOptionsPlist ExportOptions.plist

echo "✅ Build complete!"
echo "📍 IPA file location: $EXPORT_PATH/$PROJECT_NAME.ipa"
