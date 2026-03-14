# OpenCode Zen in CodeCompanion Design

Date: 2026-03-14

## Goal

Enable OpenCode Zen for CodeCompanion in this Neovim config by making OpenCode the default chat adapter while preserving the current inline editing flow.

## Current State

- `lua/nvim-codecompanion.lua` currently uses HTTP adapters only.
- Chat and inline are both routed through non-ACP adapters today.
- CodeCompanion documents OpenCode as an ACP adapter started with `opencode acp`.
- OpenCode handles provider, model, and authentication outside of the Neovim config.

## Decision

Use OpenCode as the default chat adapter and keep inline edits on Ollama.

## Recommended Approach

1. Add an ACP `opencode` adapter in `lua/nvim-codecompanion.lua`.
2. Change the default chat strategy to `opencode`.
3. Leave the inline strategy on `ollama` because ACP adapters are chat-focused.
4. Keep the existing HTTP adapters so the user can switch providers later without rebuilding the config.

## Why This Approach

- Matches CodeCompanion's documented OpenCode integration path.
- Keeps Zen-specific credentials and model selection out of the repo.
- Avoids breaking inline workflows that already work with Ollama.
- Minimizes configuration churn while still making OpenCode Zen the main chat experience.

## OpenCode Zen Ownership

Zen should be configured in OpenCode, not in this repository.

- CodeCompanion is responsible only for launching `opencode acp`.
- OpenCode should be authenticated against OpenCode Zen using its own `/connect` flow.
- The default Zen-backed model should be selected in the user's OpenCode config or runtime settings.
- No project-local `opencode.json` will be added unless the repo later needs to enforce a shared project model.

## Configuration Shape

The intended CodeCompanion shape is:

- `adapters.acp.opencode` exists and is available for chat.
- `strategies.chat.adapter = "opencode"`.
- `strategies.inline.adapter = "ollama"`.
- Existing HTTP adapters remain available as non-default options.

## Failure Handling

- If `opencode` is not installed or not on `PATH`, chat startup should fail clearly.
- If OpenCode is installed but not authenticated, the chat adapter should fail without affecting inline edits.
- Inline editing should continue to function through Ollama even if OpenCode is unavailable.

## Verification Plan

1. Confirm `opencode` is installed and available on `PATH`.
2. Open a CodeCompanion chat and confirm the active adapter is `opencode`.
3. Verify chat responses work through OpenCode.
4. Verify inline edits still work through Ollama.

## Out of Scope

- Adding a repo-local `opencode.json`.
- Moving inline editing to ACP.
- Replacing or removing existing HTTP adapters.
- Managing Zen credentials from Neovim config.
