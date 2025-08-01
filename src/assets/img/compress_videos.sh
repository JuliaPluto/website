#!/bin/bash

# Script to compress .mov files to .mp4 using ffmpeg and replace them in-place
# Usage: ./compress_videos.sh file1.mov file2.mov file3.mov ...

set -e  # Exit on any error

if [ $# -eq 0 ]; then
    echo "Usage: $0 <mov_file1> [mov_file2] [mov_file3] ..."
    echo "Example: $0 \"selecting cells.mov\" \"dragging cells.mov\""
    exit 1
fi

for mov_file in "$@"; do
    if [ ! -f "$mov_file" ]; then
        echo "Warning: File '$mov_file' does not exist, skipping..."
        continue
    fi
    
    # Check if it's a .mov file
    if [[ ! "$mov_file" =~ \.mov$ ]]; then
        echo "Warning: '$mov_file' is not a .mov file, skipping..."
        continue
    fi
    
    echo "Processing: $mov_file"
    
    # Generate temporary output filename
    temp_output="${mov_file%.mov}_temp.mp4"
    final_output="${mov_file%.mov}.mp4"
    
    # Run ffmpeg conversion
    if ffmpeg -i "$mov_file" -vcodec libx264 -crf 28 -preset medium -pix_fmt yuv420p -y "$temp_output"; then
        # Move temp file to final location and remove original
        mv "$temp_output" "$final_output"
        rm "$mov_file"
        echo "✓ Converted '$mov_file' to '$final_output'"
        
        # Print dimensions of the converted video
        dimensions=$(ffprobe -v quiet -print_format json -show_streams "$final_output" | grep -E '"width"|"height"' | tr -d ' ",' | cut -d: -f2)
        width=$(echo "$dimensions" | head -n1)
        height=$(echo "$dimensions" | tail -n1)
        echo "  Dimensions: ${width}×${height} pixels"
    else
        echo "✗ Failed to convert '$mov_file'"
        # Clean up temp file if it exists
        [ -f "$temp_output" ] && rm "$temp_output"
    fi
done

echo "Done!"
