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

TARGETS_SECTION="
    targets: [
"

# Function to generate binaryTarget code
generate_binary_target() {
    local path="$1"
    local name
    name=$(basename "$path" .xcframework)
    echo "        .binaryTarget(
            name: \"$name\",
            path: \"$path\"
        ),"
}

# Function to process each folder
process_folder() {
    local folder_path="$1"
    local folder_name
    folder_name=$(basename "$folder_path")

    local dependencies=""
    local resources=""
    local imports=""

    # Scan for xcframework directories
    while IFS= read -r xcframework_path; do
        local name=$(basename "$xcframework_path" .xcframework)
        TARGETS_SECTION+="$(generate_binary_target "$xcframework_path")"$'\n'
        dependencies+="\"$name\","
        imports+="@_exported import $name"$'\n'
    done < <(find "$folder_path" -type d -name "*.xcframework")

    # Scan for xcprivacy and bundle files, excluding those inside xcframework directories
    while IFS= read -r file_path; do
        if [[ "$file_path" != *".xcframework/"* ]]; then
            resources+=".copy(\"$(echo "$file_path" | sed -e "s|^$folder_path/||")\"),
"
        fi
    done < <(find "$folder_path" -type f \( -name "*.xcprivacy" -o -name "*.bundle" \))

    # Create the swift file with imports
    echo "$imports" > "$folder_path/$folder_name.swift"

    # Add library to the Package.swift content
    PRODUCTS_SECTION+="        .library(name: \"$folder_name\", targets: [\"$folder_name\"]),"$'\n'

    # Add target to the targets section
    TARGETS_SECTION+="        .target(
            name: \"$folder_name\",
            dependencies: [
                $(echo "$dependencies" | sed 's/,$//')
            ],
            path: \"$folder_path\",
            resources: [$(echo "$resources" | sed 's/,$//')]
        ),"$'\n'
}

# Process each folder that matches "IS" + title pattern
for dir_path in $(find "$SCAN_DIR" -maxdepth 1 -type d -name "IS*"); do
    process_folder "$dir_path"
done

# Add hardcoded libraries and targets
PRODUCTS_SECTION+="        .library(name: \"IronSource\", targets: [\"IronSource\", \"IronSourceAdQualitySDK\"]),"$'\n    ],\n    dependencies: [],'

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
PACKAGE_SWIFT_CONTENT+="$PRODUCTS_SECTION$TARGETS_SECTION"

# Write the Package.swift content to file
echo "$PACKAGE_SWIFT_CONTENT" > Package.swift

echo "Package.swift has been generated."
