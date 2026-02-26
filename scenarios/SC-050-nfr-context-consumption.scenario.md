# SC-050: Meta-Skill SKILL.md Context Consumption Under 5000 Tokens

> Covers: NFR-002 — Meta-skill SKILL.md context consumption <5,000 tokens for body
> Type: Performance

## Given
- The meta-skill's own SKILL.md has been restructured for v4.0
- The file is at `/Users/francylisboacharuto/agent-skill-creator/SKILL.md`

## When
- The token count of the SKILL.md body (excluding frontmatter) is estimated

## Then
- The body content consumes fewer than 5,000 tokens
- Using the heuristic of ~4 chars per token, the body is <20,000 characters
- Detailed content is in `references/` and loaded on demand

## Verification Method

**Method**: CLI command

**Steps**:
1. Extract the body (everything after the second `---`): `sed -n '/^---$/,/^---$/!p' SKILL.md | tail -n +1`
2. Count characters: `wc -c` on the body
3. Assert character count <20,000 (conservative ~4 chars/token estimate for 5,000 token limit)
4. Alternatively, use `tiktoken` if available: `python3 -c "import tiktoken; enc=tiktoken.get_encoding('cl100k_base'); print(len(enc.encode(open('SKILL.md').read())))"`

**Expected evidence**: Body character count is <20,000 characters. Estimated token count is <5,000 tokens.
