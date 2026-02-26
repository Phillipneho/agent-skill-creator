# SC-058: Cross-Platform Export for Desktop/Web as .zip

> Covers: FR-019 — Export system MUST continue to support Desktop/Web .zip
> Type: Happy Path

## Given
- A valid skill directory `data-processor/` exists
- The user wants a Desktop/Web export

## When
- `export_skill("data-processor/", variants=["desktop"])` is called

## Then
- A `.zip` file is produced
- The zip contains the skill directory with all files
- The zip is suitable for Desktop/Web import

## Verification Method

**Method**: Automated test

**Steps**:
1. Call `export_skill("data-processor/", variants=["desktop"])`
2. Verify a `.zip` file was created
3. Run `unzip -l <output.zip>` to list contents
4. Verify SKILL.md is present in the archive

**Expected evidence**: `.zip` file produced. Contains `SKILL.md`, `scripts/`, `references/`, `install.sh`, `README.md`. Archive is valid.
