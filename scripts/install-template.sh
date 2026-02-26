#!/bin/sh
# install-template.sh — Cross-platform skill installation script
# This file is a template. During skill generation, {{SKILL_NAME}} is replaced
# with the actual skill name and the result is shipped as install.sh inside
# every generated skill package.
#
# POSIX-compatible (works in bash, dash, zsh, ash, etc.)
# Exit codes:
#   0 — Success
#   1 — Validation failed (missing or malformed SKILL.md)
#   2 — Platform not detected
#   3 — Permission denied

set -euo pipefail

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
SKILL_NAME="{{SKILL_NAME}}"
VERSION="1.0.0"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ---------------------------------------------------------------------------
# Colors (disabled when stdout is not a terminal)
# ---------------------------------------------------------------------------
if [ -t 1 ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    BOLD='\033[1m'
    NC='\033[0m'
else
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    BOLD=''
    NC=''
fi

# ---------------------------------------------------------------------------
# Logging helpers
# ---------------------------------------------------------------------------
info()    { printf "${BLUE}[INFO]${NC}  %s\n" "$1"; }
success() { printf "${GREEN}[OK]${NC}    %s\n" "$1"; }
warn()    { printf "${YELLOW}[WARN]${NC}  %s\n" "$1"; }
error()   { printf "${RED}[ERROR]${NC} %s\n" "$1" >&2; }

# ---------------------------------------------------------------------------
# Usage / help
# ---------------------------------------------------------------------------
show_help() {
    cat <<EOF
${BOLD}install.sh${NC} — Install the ${BOLD}${SKILL_NAME}${NC} skill (v${VERSION})

USAGE
    ./install.sh [OPTIONS]

OPTIONS
    --platform PLATFORM   Explicit platform selection. One of:
                          claude-code, copilot, cursor, windsurf,
                          cline, codex, gemini
    --project             Install at project level (current directory)
    --path PATH           Custom install path (overrides detection)
    --dry-run             Show what would happen without making changes
    -h, --help            Show this help message

EXAMPLES
    ./install.sh                          # Auto-detect platform, user-level
    ./install.sh --project                # Auto-detect platform, project-level
    ./install.sh --platform cursor        # Force Cursor, user-level
    ./install.sh --path ~/my-skills/      # Custom destination
    ./install.sh --dry-run                # Preview without installing
EOF
}

# ---------------------------------------------------------------------------
# Argument parsing
# ---------------------------------------------------------------------------
PLATFORM=""
PROJECT_LEVEL=false
CUSTOM_PATH=""
DRY_RUN=false

parse_args() {
    while [ $# -gt 0 ]; do
        case "$1" in
            --platform)
                [ $# -ge 2 ] || { error "Missing value for --platform"; exit 1; }
                PLATFORM="$2"
                shift 2
                ;;
            --project)
                PROJECT_LEVEL=true
                shift
                ;;
            --path)
                [ $# -ge 2 ] || { error "Missing value for --path"; exit 1; }
                CUSTOM_PATH="$2"
                shift 2
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                error "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done
}

# ---------------------------------------------------------------------------
# SKILL.md validation
# ---------------------------------------------------------------------------
validate_skill_md() {
    local skill_md="${SCRIPT_DIR}/SKILL.md"

    if [ ! -f "$skill_md" ]; then
        error "SKILL.md not found in ${SCRIPT_DIR}"
        error "Every skill package must contain a valid SKILL.md file."
        exit 1
    fi

    # Check that the file starts with YAML frontmatter delimiter
    local first_line
    first_line="$(head -n 1 "$skill_md")"
    if [ "$first_line" != "---" ]; then
        error "SKILL.md must start with YAML frontmatter (---)"
        exit 1
    fi

    # Verify required frontmatter fields: name and description
    # We look between the opening --- and closing --- for these fields.
    local in_frontmatter=false
    local found_name=false
    local found_description=false
    local line_num=0

    while IFS= read -r line; do
        line_num=$((line_num + 1))

        if [ "$line_num" -eq 1 ]; then
            in_frontmatter=true
            continue
        fi

        if $in_frontmatter && [ "$line" = "---" ]; then
            # End of frontmatter
            break
        fi

        if $in_frontmatter; then
            case "$line" in
                name:*) found_name=true ;;
                description:*) found_description=true ;;
            esac
        fi
    done < "$skill_md"

    if ! $found_name; then
        error "SKILL.md frontmatter is missing required field: name"
        exit 1
    fi

    if ! $found_description; then
        error "SKILL.md frontmatter is missing required field: description"
        exit 1
    fi

    success "SKILL.md validated (name and description present)"
}

# ---------------------------------------------------------------------------
# Platform detection
# ---------------------------------------------------------------------------
# Returns the detected platform slug or exits with code 2.
detect_platform() {
    # If explicitly provided, validate and return it.
    if [ -n "$PLATFORM" ]; then
        case "$PLATFORM" in
            claude-code|copilot|cursor|windsurf|cline|codex|gemini)
                info "Platform explicitly set to: ${PLATFORM}"
                return 0
                ;;
            *)
                error "Unknown platform: ${PLATFORM}"
                error "Supported: claude-code, copilot, cursor, windsurf, cline, codex, gemini"
                exit 2
                ;;
        esac
    fi

    # Auto-detection: check user-level config directories.
    # Order matters — check most specific / least ambiguous first.
    if [ -d "${HOME}/.claude" ]; then
        PLATFORM="claude-code"
    elif [ -d "${HOME}/.cursor" ] || [ -d ".cursor" ]; then
        PLATFORM="cursor"
    elif [ -d "${HOME}/.windsurf" ]; then
        PLATFORM="windsurf"
    elif [ -d "${HOME}/.cline" ] || [ -d ".clinerules" ]; then
        PLATFORM="cline"
    elif [ -d "${HOME}/.codex" ]; then
        PLATFORM="codex"
    elif [ -d "${HOME}/.gemini" ]; then
        PLATFORM="gemini"
    elif [ -d "${HOME}/.copilot" ] || [ -d ".github" ]; then
        PLATFORM="copilot"
    else
        error "Could not auto-detect any supported AI coding platform."
        error "Use --platform PLATFORM to specify one explicitly."
        error "Supported: claude-code, copilot, cursor, windsurf, cline, codex, gemini"
        exit 2
    fi

    info "Auto-detected platform: ${PLATFORM}"
}

# ---------------------------------------------------------------------------
# Install path resolution
# ---------------------------------------------------------------------------
# Sets INSTALL_DIR based on platform, project-level flag, or custom path.
resolve_install_path() {
    # Custom path takes precedence over everything.
    if [ -n "$CUSTOM_PATH" ]; then
        INSTALL_DIR="${CUSTOM_PATH}"
        info "Using custom install path: ${INSTALL_DIR}"
        return 0
    fi

    local base=""

    if $PROJECT_LEVEL; then
        # Project-level: paths are relative to the current working directory.
        case "$PLATFORM" in
            claude-code) base=".claude/skills" ;;
            copilot)     base=".github/skills" ;;
            cursor)      base=".cursor/rules" ;;
            windsurf)    base=".windsurf/skills" ;;
            cline)       base=".clinerules" ;;
            codex)       base=".codex/skills" ;;
            gemini)      base=".gemini/skills" ;;
        esac
        INSTALL_DIR="$(pwd)/${base}/${SKILL_NAME}"
    else
        # User-level: paths are under the home directory.
        case "$PLATFORM" in
            claude-code) base="${HOME}/.claude/skills" ;;
            copilot)     base="${HOME}/.copilot/skills" ;;
            cursor)      base="${HOME}/.cursor/rules" ;;
            windsurf)    base="${HOME}/.windsurf/skills" ;;
            cline)       base="${HOME}/.cline/rules" ;;
            codex)       base="${HOME}/.codex/skills" ;;
            gemini)      base="${HOME}/.gemini/skills" ;;
        esac
        INSTALL_DIR="${base}/${SKILL_NAME}"
    fi

    info "Install directory: ${INSTALL_DIR}"
}

# ---------------------------------------------------------------------------
# File installation
# ---------------------------------------------------------------------------
install_files() {
    # Collect the list of files to install.
    # We copy everything in SCRIPT_DIR except the install script itself.
    local file_count=0
    local install_script_name
    install_script_name="$(basename "$0")"

    if $DRY_RUN; then
        printf "\n${BOLD}Dry-run mode — no files will be copied.${NC}\n\n"
        info "Would create directory: ${INSTALL_DIR}"
        for file in "${SCRIPT_DIR}"/*; do
            [ -e "$file" ] || continue
            local fname
            fname="$(basename "$file")"
            # Skip the install script itself
            [ "$fname" = "$install_script_name" ] && continue
            info "Would copy: ${fname}"
            file_count=$((file_count + 1))
        done
        # Also handle dotfiles
        for file in "${SCRIPT_DIR}"/.*; do
            [ -e "$file" ] || continue
            local fname
            fname="$(basename "$file")"
            [ "$fname" = "." ] || [ "$fname" = ".." ] && continue
            info "Would copy: ${fname}"
            file_count=$((file_count + 1))
        done
        printf "\n"
        info "Total files: ${file_count}"
        return 0
    fi

    # Create destination directory.
    if ! mkdir -p "$INSTALL_DIR" 2>/dev/null; then
        error "Cannot create directory: ${INSTALL_DIR}"
        error "Check file permissions or run with appropriate privileges."
        exit 3
    fi

    # Copy files.
    for file in "${SCRIPT_DIR}"/*; do
        [ -e "$file" ] || continue
        local fname
        fname="$(basename "$file")"
        [ "$fname" = "$install_script_name" ] && continue

        if ! cp -R "$file" "${INSTALL_DIR}/" 2>/dev/null; then
            error "Failed to copy ${fname} to ${INSTALL_DIR}/"
            error "Check file permissions."
            exit 3
        fi
        file_count=$((file_count + 1))
    done

    # Copy dotfiles (if any).
    for file in "${SCRIPT_DIR}"/.*; do
        [ -e "$file" ] || continue
        local fname
        fname="$(basename "$file")"
        [ "$fname" = "." ] || [ "$fname" = ".." ] && continue

        if ! cp -R "$file" "${INSTALL_DIR}/" 2>/dev/null; then
            error "Failed to copy ${fname} to ${INSTALL_DIR}/"
            error "Check file permissions."
            exit 3
        fi
        file_count=$((file_count + 1))
    done

    success "Copied ${file_count} file(s) to ${INSTALL_DIR}"
}

# ---------------------------------------------------------------------------
# Activation instructions
# ---------------------------------------------------------------------------
print_activation_instructions() {
    if $DRY_RUN; then
        return 0
    fi

    printf "\n${GREEN}${BOLD}Installation complete!${NC}\n\n"

    case "$PLATFORM" in
        claude-code)
            printf "To activate the skill in Claude Code:\n"
            printf "  1. Start a new Claude Code session.\n"
            printf "  2. The skill will be loaded automatically from:\n"
            printf "     ${BOLD}${INSTALL_DIR}/SKILL.md${NC}\n"
            printf "  3. Use trigger phrases defined in the skill's description.\n"
            ;;
        copilot)
            printf "To activate the skill in GitHub Copilot:\n"
            printf "  1. Open your project in VS Code or the GitHub CLI.\n"
            printf "  2. The skill is available at:\n"
            printf "     ${BOLD}${INSTALL_DIR}/SKILL.md${NC}\n"
            printf "  3. Reference the skill in your Copilot instructions.\n"
            ;;
        cursor)
            printf "To activate the skill in Cursor:\n"
            printf "  1. Open your project in Cursor.\n"
            printf "  2. The rule is loaded automatically from:\n"
            printf "     ${BOLD}${INSTALL_DIR}/SKILL.md${NC}\n"
            printf "  3. Use trigger phrases to invoke the skill.\n"
            ;;
        windsurf)
            printf "To activate the skill in Windsurf:\n"
            printf "  1. Open your project in Windsurf.\n"
            printf "  2. The skill is available at:\n"
            printf "     ${BOLD}${INSTALL_DIR}/SKILL.md${NC}\n"
            printf "  3. Use trigger phrases to invoke the skill.\n"
            ;;
        cline)
            printf "To activate the skill in Cline:\n"
            printf "  1. Open your project in VS Code with Cline.\n"
            printf "  2. The rule is loaded from:\n"
            printf "     ${BOLD}${INSTALL_DIR}/SKILL.md${NC}\n"
            printf "  3. Cline will pick up the rule automatically.\n"
            ;;
        codex)
            printf "To activate the skill in OpenAI Codex CLI:\n"
            printf "  1. Start a new Codex CLI session.\n"
            printf "  2. The skill is available at:\n"
            printf "     ${BOLD}${INSTALL_DIR}/SKILL.md${NC}\n"
            printf "  3. Reference the skill in your instructions.\n"
            ;;
        gemini)
            printf "To activate the skill in Gemini CLI:\n"
            printf "  1. Start a new Gemini CLI session.\n"
            printf "  2. The skill is available at:\n"
            printf "     ${BOLD}${INSTALL_DIR}/SKILL.md${NC}\n"
            printf "  3. The skill will be loaded automatically.\n"
            ;;
    esac

    printf "\n"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    printf "${BOLD}Installing skill: ${SKILL_NAME}${NC}\n"
    printf "%-40s\n" "----------------------------------------"

    parse_args "$@"
    validate_skill_md
    detect_platform
    resolve_install_path
    install_files
    print_activation_instructions

    if $DRY_RUN; then
        info "Dry run complete. No changes were made."
    else
        success "Skill '${SKILL_NAME}' installed successfully for ${PLATFORM}."
    fi

    exit 0
}

main "$@"
