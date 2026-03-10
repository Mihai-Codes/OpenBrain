# OpenBrain

Local-first MCP memory hub for AI coding tools. MVP target: OpenCode.

This repo ships a minimal, production-practical setup using `agent-memory-mcp` (LanceDB + hybrid BM25/vector search + local embeddings) to solve context loss from compaction.

## Why this MVP
- Hybrid search (BM25 + vector) improves recall over pure vector or pure graph memory.
- Fully local: no API keys, no network dependency after model download.
- MCP-compatible: works across CLI/TUI/GUI tools that speak MCP.

## What you get
- Ready-to-use MCP config templates
- macOS LaunchAgent setup for always-on memory server
- Clean directory layout for local storage

## Requirements
- macOS (MVP target)
- Node.js 18+ with npm

## Quickstart
1) Install the MCP server globally (downloads ONNX model once):

```bash
npm install -g @adamrdrew/agent-memory-mcp
```

2) Create local storage paths:

```bash
mkdir -p ~/.openbrain/memory-db ~/.openbrain/hardcopy ~/.openbrain/logs
```

3) Configure OpenCode MCP (project-level):

Copy `config/opencode.mcp.json` to `.mcp.json` in your project and edit paths.

4) Start server manually (for quick test):

```bash
MEMORY_DB_PATH="$HOME/.openbrain/memory-db" \
ENABLE_HARDCOPY=true \
HARDCOPY_PATH="$HOME/.openbrain/hardcopy" \
MEMORY_DECAY_HALF_LIFE=30 \
agent-memory-mcp
```

## OpenCode MCP config
Use this as `.mcp.json` in your OpenCode project:

```json
{
  "agent-memory": {
    "command": "agent-memory-mcp",
    "env": {
      "MEMORY_DB_PATH": "/Users/you/.openbrain/memory-db",
      "MEMORY_DECAY_HALF_LIFE": "30",
      "ENABLE_HARDCOPY": "true",
      "HARDCOPY_PATH": "/Users/you/.openbrain/hardcopy"
    }
  }
}
```

## Claude Desktop config (optional)
Add to `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "agent-memory": {
      "command": "agent-memory-mcp",
      "env": {
        "MEMORY_DB_PATH": "/Users/you/.openbrain/memory-db",
        "MEMORY_DECAY_HALF_LIFE": "30",
        "ENABLE_HARDCOPY": "true",
        "HARDCOPY_PATH": "/Users/you/.openbrain/hardcopy"
      }
    }
  }
}
```

## macOS LaunchAgent (always-on)
1) Edit `scripts/macos/com.mihai-codes.openbrain.agent-memory.plist` and update the path to this repo.
2) Load it:

```bash
launchctl unload ~/Library/LaunchAgents/com.mihai-codes.openbrain.agent-memory.plist 2>/dev/null || true
cp scripts/macos/com.mihai-codes.openbrain.agent-memory.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.mihai-codes.openbrain.agent-memory.plist
```

## Storage layout (recommended)
```
~/.openbrain/
  memory-db/      # LanceDB
  hardcopy/       # optional JSON mirror
  logs/
```

## Notes on licensing
`agent-memory-mcp` is GPL-3.0. This repo only provides configuration and glue. If you embed or redistribute a derivative, GPL obligations apply.

## Upgrade paths
- **Hindsight**: stronger structured memory and ranking, heavier stack. Good for long-horizon tasks.
- **mcp-knowledge-graph**: explicit entities/relations, weaker fuzzy recall.
- **memory-lancedb-pro** (OpenClaw plugin): MIT, hybrid + rerank; can be used as an alternative pattern.

## Sources
- agent-memory-mcp: https://github.com/adamrdrew/agent-memory-mcp
- mcp-knowledge-graph: https://github.com/shaneholloman/mcp-knowledge-graph
- Hindsight: https://github.com/vectorize-io/hindsight
- memory-lancedb-pro: https://github.com/win4r/memory-lancedb-pro
