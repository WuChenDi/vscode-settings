#!/usr/bin/env bash

OUTPUT_FILENAME="extensions.json"

generate_extension_recommendations() {
  local extensions=$(code --list-extensions | sed 's/^/"/;s/$/",/g')
  echo "{\"recommendations\":[$extensions]}"
}

pretty_print_json() {
  awk \
    -v RS='\n' -v ORS='\n' 'BEGIN { level = 0; indent=""; } {
        if ($0 ~ /^{$/) {
            level++;
            indent=sprintf("%*s", level * 2, "");
        } else if ($0 ~ /^}$/) {
            level--;
            indent=sprintf("%*s", level * 2, "");
        } else {
            indent=sprintf("%*s", level * 2, "");
        }
        printf("%s%s\n", indent, $0);
    }'
}

generate_extension_recommendations | pretty_print_json > "$OUTPUT_FILENAME"
