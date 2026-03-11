#!/bin/bash
focused=$(aerospace list-workspaces --focused 2>/dev/null)
workspaces=$(aerospace list-workspaces --monitor all --empty no 2>/dev/null | sort -n)

if [[ -z "$workspaces" ]]; then
    exit 0
fi

output=""
for ws in $workspaces; do
    if [[ "$ws" == "$focused" ]]; then
        output+="#[fg=#c6a0f6,bold]$ws #[default]"
    else
        output+="#[fg=#6e738d]$ws #[default]"
    fi
done

echo "$output"
