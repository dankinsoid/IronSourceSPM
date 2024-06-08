#!/bin/bash

# Directory to scan (default is the current directory)
SCAN_DIR=${1:-.}

# Initialize the Package.swift content
PACKAGE_SWIFT_CONTENT_TEMPLATE="
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: \"{PACKAGE_NAME}\",
    defaultLocalization: \"en\",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: \"{PACKAGE_NAME}\", targets: [{FINAL_TARGET_NAMES}]),
    ],
    targets: [
        {TARGETS}
        {BINARY_TARGETS}
    ]
)
"

# Function to generate binaryTarget code
generate_binary_target() {
    local path="$1"
    local name
    name=$(basename "$path" .xcframework)
    local new_path
    new_path=$(echo "$path" | cut -d'/' -f4-)
    echo "        .binaryTarget(
            name: \"$name\",
            path: \"./$new_path\"
        ),"
}

# Function to process each folder
process_folder() {
    local folder_path="$1"
    local folder_name
    folder_name=$(basename "$folder_path")

    local dependencies=""
    local resources=""
    local binary_targets=""
    local targets=""
    local final_target_names=""

    # Scan for xcframework directories
    while IFS= read -r xcframework_path; do
        local name=$(basename "$xcframework_path" .xcframework)
        binary_targets+="$(generate_binary_target "$xcframework_path")"$'\n'
        dependencies+="\"$name\","
    done < <(find "$folder_path" -type d -name "*.xcframework")

    # Scan for xcprivacy files, excluding those inside xcframework directories
    while IFS= read -r file_path; do
        if [[ "$file_path" != *".xcframework/"* ]]; then
            resources+=".copy(\"$(echo "$file_path" | sed -e "s|^$folder_path/||")\"),"$'\n'
        fi
    done < <(find "$folder_path" -type f -name "*.xcprivacy")

    # Scan for bundle files, excluding those inside xcframework directories
    while IFS= read -r dir_path; do
        if [[ "$dir_path" != *".xcframework/"* ]]; then
            resources+=".process(\"$(echo "$dir_path" | sed -e "s|^$folder_path/||")\"),"$'\n'
        fi
    done < <(find "$folder_path" -type d -name "*.bundle")
    
    # Add target
    if [[ -n "$resources" ]]; then
        local target_name="${folder_name}Resources"
        targets+=".target(
            name: \"$target_name\",
            dependencies: [
                $(echo "$dependencies" | sed 's/,$//')
            ],
            path: \"./\",
            resources: [
                $(echo "$resources" | sed 's/$//')
            ]
        ),"
        final_target_names+="\"$target_name\","
    else
        final_target_names+="$(echo "$dependencies" | sed 's/,$//'),"
    fi

    # Replace placeholders in the template with actual values
    local package_swift_content="$PACKAGE_SWIFT_CONTENT_TEMPLATE"
    package_swift_content=$(echo "$package_swift_content" | sed "s|{PACKAGE_NAME}|$folder_name|g")
    package_swift_content=$(echo "$package_swift_content" | sed "s|{FINAL_TARGET_NAMES}|$(echo "$final_target_names" | sed 's/,$//')|g")
    package_swift_content=$(echo "$package_swift_content" | sed "s|{TARGETS}|${targets//$'\n'/\\n}|g")
    package_swift_content=$(echo "$package_swift_content" | sed "s|{BINARY_TARGETS}|${binary_targets//$'\n'/\\n}|g")

    # Write the Package.swift content to file
    echo "$package_swift_content" > "$folder_path/Package.swift"
    echo "Package.swift has been generated in $folder_path."
}

# Process each folder in the scan directory
find "$SCAN_DIR" -maxdepth 1 -type d | while read -r dir_path; do
    if [[ "$dir_path" != "$SCAN_DIR" ]]; then
        process_folder "$dir_path"
    fi
done
