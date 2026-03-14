# OpenCode Zen Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Make CodeCompanion use OpenCode as the default chat adapter so OpenCode Zen can power chat, while keeping inline edits on Ollama.

**Architecture:** Update the existing CodeCompanion setup in `lua/nvim-codecompanion.lua` to add the built-in ACP `opencode` adapter and point the chat strategy at it. Leave Zen authentication and model selection in the user's OpenCode runtime config so this repo stays free of secrets and provider-specific credentials.

**Tech Stack:** Neovim, Lua, CodeCompanion.nvim, OpenCode ACP, Ollama

---

## Notes Before Starting

- Preserve any unrelated local edits already present in `lua/nvim-codecompanion.lua`.
- This is a configuration change, so use smoke verification instead of unit-test-first TDD.
- Do not add a repo-local `opencode.json` unless requirements change.

### Task 1: Add the OpenCode ACP adapter

**Files:**
- Modify: `lua/nvim-codecompanion.lua`

**Step 1: Review the current adapter block**

Inspect the `strategies` and `adapters` tables in `lua/nvim-codecompanion.lua` and identify the existing `http` adapter definitions.

**Step 2: Add the failing configuration check**

Run:

```bash
nvim --headless "+lua dofile('lua/nvim-codecompanion.lua')" +qa
```

Expected: PASS now, proving the current file parses before changes.

**Step 3: Write the minimal implementation**

Add an ACP adapter entry alongside the existing HTTP adapters.

```lua
adapters = {
  acp = {
    opencode = "opencode",
  },
  http = {
    -- existing adapters stay here
  },
}
```

**Step 4: Run the parse check again**

Run:

```bash
nvim --headless "+lua dofile('lua/nvim-codecompanion.lua')" +qa
```

Expected: PASS with no Lua parse errors.

**Step 5: Commit**

```bash
git add lua/nvim-codecompanion.lua
git commit -m "Add OpenCode ACP adapter"
```

### Task 2: Switch chat to OpenCode and keep inline on Ollama

**Files:**
- Modify: `lua/nvim-codecompanion.lua`

**Step 1: Write the intended behavior down in the config diff**

Change the chat strategy to `opencode` and leave inline on `ollama`.

**Step 2: Write the minimal implementation**

Update the strategy block to this shape:

```lua
strategies = {
  chat = {
    adapter = "opencode",
  },
  inline = {
    adapter = "ollama",
  },
}
```

Keep the rest of the file unchanged unless needed for compatibility.

**Step 3: Run the parse check**

Run:

```bash
nvim --headless "+lua dofile('lua/nvim-codecompanion.lua')" +qa
```

Expected: PASS with no Lua errors.

**Step 4: Run a repo-level smoke check**

Run:

```bash
nvim --headless +qa
```

Expected: PASS with startup completing successfully.

**Step 5: Commit**

```bash
git add lua/nvim-codecompanion.lua
git commit -m "Use OpenCode for CodeCompanion chat"
```

### Task 3: Verify runtime expectations for OpenCode Zen

**Files:**
- Verify only: `lua/nvim-codecompanion.lua`

**Step 1: Confirm the OpenCode executable is available**

Run:

```bash
command -v opencode
```

Expected: prints the OpenCode executable path.

**Step 2: Confirm ACP starts**

Run:

```bash
opencode acp --help
```

Expected: exits successfully and shows ACP command help.

**Step 3: Manual editor verification**

Open Neovim and start a CodeCompanion chat.

Expected:

- The active chat adapter is `opencode`.
- Chat works if OpenCode is already authenticated.
- Inline edits still use Ollama.

**Step 4: If chat fails, verify OpenCode runtime setup**

Check the user-level OpenCode setup outside the repo:

- `~/.config/opencode/opencode.json`
- `~/.local/share/opencode/auth.json`

Expected: OpenCode is configured to use a Zen-backed model and has valid auth.

**Step 5: Commit or document the result**

If no repo files changed during verification, do not create a commit. Record any manual follow-up needed in the task summary.
