#!/bin/bash

# Directory to scan (default is the current directory)
SCAN_DIR=${1:-.}

# Initialize the Package.swift content
PACKAGE_SWIFT_CONTENT="
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: \"IronSource\",
    defaultLocalization: \"en\",
    platforms: [
        .iOS(.v11)
    ],
    products: [
"

PRODUCTS_SECTION=""

DEPENDENCIES_SECTION="
    dependencies: [
        .package(url: \"https://github.com/yandexmobile/yandex-ads-sdk-ios.git\", from: \"7.0.0\"),
        .package(url: \"https://github.com/myTargetSDK/mytarget-ios-spm.git\", from: \"5.0.0\"),
"

TARGETS_SECTION="
    targets: [
"

# Function to generate a local package dependency
generate_local_package_dependency() {
    local path="$1"
    local name
    name=$(basename "$path")
    echo "        .package(path: \"$path\"),"
}

# Function to process each subfolder
process_subfolder() {
    local subfolder_path="$1"
    local subfolder_name
    subfolder_name=$(basename "$subfolder_path")

    # Add the local package as a dependency
    DEPENDENCIES_SECTION+="$(generate_local_package_dependency "$subfolder_path")"$'\n'

    # Add library to the Package.swift content
    PRODUCTS_SECTION+="        .library(name: \"$subfolder_name\", targets: [\"$subfolder_name\"]),"$'\n'

    # Add target to the targets section
    TARGETS_SECTION+="        .target(
            name: \"$subfolder_name\",
            dependencies: [
                \"$subfolder_name\"
            ],
            path: \"$subfolder_path\"
        ),"$'\n'
}

# Function to process each folder
process_folder() {
    local folder_path="$1"

    # Call the script to generate local packages for subfolders
    ./generate_local_package.sh "$folder_path"

    # Process each subfolder that was generated as a package
    for subfolder_path in $(find "$folder_path" -maxdepth 1 -type d -not -path "$folder_path"); do
        process_subfolder "$subfolder_path"
    done
}

# Process each folder that matches "IS" + title pattern
for dir_path in $(find "$SCAN_DIR" -maxdepth 1 -type d -name "IS*"); do
    process_folder "$dir_path"
done

# Add hardcoded libraries and targets
PRODUCTS_SECTION+="        .library(name: \"IronSource\", targets: [\"IronSource\", \"IronSourceAdQualitySDK\"]),"$'\n    ],\n'

DEPENDENCIES_SECTION+="    ],"

TARGETS_SECTION+="        .binaryTarget(
            name: \"IronSource\",
            url: \"https://github.com/ironsource-mobile/iOS-sdk/raw/master/8.1.0/IronSource8.1.0.zip\",
            checksum: \"2af1acc57245a9e253f6fa61981cc3b48882c7767b9951e4fb70c4580ad509c9\"
        ),"$'\n'
TARGETS_SECTION+="        .binaryTarget(
            name: \"IronSourceAdQualitySDK\",
            url: \"https://github.com/ironsource-mobile/iOS-adqualitysdk/releases/download/IronSource_AdQuality_7.14.2/IronSourceAdQualitySDK-ios-v7.14.2.zip\",
            checksum: \"05f6f206148fd84c3bded71ef27c22448fedf555555c69cfcefccf9cf8a4fd0b\"
        )"$'\n'
TARGETS_SECTION+="    ]
)
"

# Combine the sections
PACKAGE_SWIFT_CONTENT+="$PRODUCTS_SECTION$DEPENDENCIES_SECTION$TARGETS_SECTION"

# Write the Package.swift content to file
echo "$PACKAGE_SWIFT_CONTENT" > Package.swift

echo "Package.swift has been generated."