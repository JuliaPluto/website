#!/bin/bash

# PNG Compression Script
# Compresses all PNG files in the current directory using pngquant
# Shows before/after sizes and calculates total savings
# Skips files that are already compressed (8-bit or limited palette)

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# Check if required tools are installed
if ! command -v pngquant &> /dev/null; then
    echo -e "${RED}Error: pngquant is not installed.${NC}"
    echo "Please install it with: brew install pngquant"
    exit 1
fi

if ! command -v identify &> /dev/null; then
    echo -e "${RED}Error: ImageMagick (identify command) is not installed.${NC}"
    echo "Please install it with: brew install imagemagick"
    exit 1
fi

# Check if there are PNG files in the current directory
if ! ls *.png >/dev/null 2>&1; then
    echo -e "${RED}No PNG files found in the current directory.${NC}"
    exit 1
fi

echo -e "${BLUE}🖼️  PNG Compression Script${NC}"
echo -e "${BLUE}=========================${NC}\n"

# Quality setting (can be modified)
QUALITY="65-80"

# Option to create backups
BACKUP=false
FORCE=false
if [[ "$1" == "--backup" ]]; then
    BACKUP=true
    echo -e "${YELLOW}Creating backups of original files...${NC}"
elif [[ "$1" == "--force" ]]; then
    FORCE=true
    echo -e "${YELLOW}Force mode: will compress all files regardless of current state${NC}"
elif [[ "$1" == "--help" ]]; then
    echo -e "${BLUE}Usage:${NC}"
    echo -e "  ./compress_pngs.sh           # Normal compression (skips already compressed)"
    echo -e "  ./compress_pngs.sh --backup  # Create backups before compression"
    echo -e "  ./compress_pngs.sh --force   # Force compress all files (not recommended)"
    echo -e "  ./compress_pngs.sh --help    # Show this help"
    exit 0
fi

# Function to check if PNG is already compressed (8-bit or limited colors)
is_already_compressed() {
    local file="$1"
    local depth=$(identify -format "%[bit-depth]" "$file" 2>/dev/null || echo "unknown")
    local colors=$(identify -format "%[colors]" "$file" 2>/dev/null || echo "999999")
    
    # If bit depth is 8 or less, it's likely already compressed
    if [[ "$depth" == "8" ]] || [[ "$depth" == "4" ]] || [[ "$depth" == "1" ]]; then
        return 0  # Already compressed
    fi
    
    # If it has 256 colors or fewer, it's likely already quantized
    if [[ "$colors" =~ ^[0-9]+$ ]] && [[ "$colors" -le 256 ]]; then
        return 0  # Already compressed
    fi
    
    return 1  # Not compressed
}

# Calculate total size before compression
echo -e "${BLUE}📊 ANALYZING FILES:${NC}"
TO_COMPRESS=()
ALREADY_COMPRESSED=()
FAILED_ANALYSIS=()

for file in *.png; do
    if [[ -f "$file" ]]; then
        if [[ "$FORCE" == true ]]; then
            TO_COMPRESS+=("$file")
        else
            if is_already_compressed "$file"; then
                ALREADY_COMPRESSED+=("$file")
                echo -e "  ${GRAY}⏭️  $file (already compressed)${NC}"
            else
                TO_COMPRESS+=("$file")
                echo -e "  ${BLUE}📋 $file (will compress)${NC}"
            fi
        fi
    fi
done

echo ""

if [[ ${#TO_COMPRESS[@]} -eq 0 ]]; then
    echo -e "${GREEN}✅ All PNG files are already compressed!${NC}"
    echo -e "${GRAY}Use --force flag to compress anyway (not recommended)${NC}"
    exit 0
fi

echo -e "${BLUE}📊 BEFORE COMPRESSION:${NC}"
if [[ ${#TO_COMPRESS[@]} -gt 0 ]]; then
    du -h "${TO_COMPRESS[@]}" | sort -hr
    TOTAL_BEFORE=$(du -ch "${TO_COMPRESS[@]}" | tail -1 | cut -f1)
    TOTAL_BEFORE_KB=$(du -ck "${TO_COMPRESS[@]}" | tail -1 | cut -f1)
    echo -e "\n${BLUE}Total size of files to compress: ${TOTAL_BEFORE}${NC}"
fi

if [[ ${#ALREADY_COMPRESSED[@]} -gt 0 ]]; then
    ALREADY_SIZE=$(du -ch "${ALREADY_COMPRESSED[@]}" | tail -1 | cut -f1)
    echo -e "${GRAY}Already compressed files: ${#ALREADY_COMPRESSED[@]} files (${ALREADY_SIZE})${NC}"
fi

echo ""

# Create backup if requested
if [[ "$BACKUP" == true ]]; then
    mkdir -p originals
    cp "${TO_COMPRESS[@]}" originals/
    echo -e "${GREEN}✅ Backups created in 'originals' folder${NC}\n"
fi

# Compress each PNG file that needs compression
echo -e "${BLUE}🔄 Compressing files...${NC}"
COMPRESSED_COUNT=0
for file in "${TO_COMPRESS[@]}"; do
    echo -n "  Compressing $file... "
    if pngquant --quality="$QUALITY" --force --ext .png "$file" 2>/dev/null; then
        echo -e "${GREEN}✅${NC}"
        ((COMPRESSED_COUNT++))
    else
        echo -e "${RED}❌ (failed)${NC}"
    fi
done

echo ""

# Calculate total size after compression
if [[ ${#TO_COMPRESS[@]} -gt 0 ]]; then
    echo -e "${BLUE}📊 AFTER COMPRESSION:${NC}"
    du -h "${TO_COMPRESS[@]}" | sort -hr
    TOTAL_AFTER=$(du -ch "${TO_COMPRESS[@]}" | tail -1 | cut -f1)
    TOTAL_AFTER_KB=$(du -ck "${TO_COMPRESS[@]}" | tail -1 | cut -f1)
    echo -e "\n${BLUE}Total size after: ${TOTAL_AFTER}${NC}\n"

    # Calculate savings
    SAVINGS_KB=$((TOTAL_BEFORE_KB - TOTAL_AFTER_KB))
    SAVINGS_PERCENT=$(echo "scale=1; $SAVINGS_KB * 100 / $TOTAL_BEFORE_KB" | bc -l 2>/dev/null || echo "0")
else
    TOTAL_AFTER="0"
    SAVINGS_KB=0
    SAVINGS_PERCENT="0"
fi

# Results summary
echo -e "${GREEN}🎉 COMPRESSION COMPLETE!${NC}"
echo -e "${GREEN}======================${NC}"
echo -e "Files processed: ${COMPRESSED_COUNT}/${#TO_COMPRESS[@]}"
if [[ ${#ALREADY_COMPRESSED[@]} -gt 0 ]]; then
    echo -e "Files skipped: ${#ALREADY_COMPRESSED[@]} (already compressed)"
fi
echo -e "Size before: ${TOTAL_BEFORE:-0}"
echo -e "Size after:  ${TOTAL_AFTER}"
echo -e "Space saved: ${SAVINGS_KB}KB"
echo -e "${GREEN}Reduction: ${SAVINGS_PERCENT}%${NC}"

if [[ "$BACKUP" == true ]]; then
    echo -e "${YELLOW}\n💡 Original files are backed up in 'originals' folder${NC}"
fi

echo -e "\n${BLUE}ℹ️  Note: This uses lossy compression (reduces colors to ~256)${NC}"
echo -e "${BLUE}   Quality setting used: ${QUALITY}${NC}"
echo -e "${BLUE}   Skipped files with ≤8-bit depth or ≤256 colors${NC}"
echo -e "${BLUE}   For lossless compression, use optipng or similar tools.${NC}" 