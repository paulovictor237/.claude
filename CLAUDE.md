# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**claudinho** is a boilerplate and configuration repository for Claude Code setup. It provides:
- Quick installation script for setting up Claude Code CLI
- Best practices documentation for writing effective CLAUDE.md files
- Template configurations and examples for different project types

This repository itself serves as a reference for how to structure and document Claude Code projects.

## Repository Structure

- `README.md` - Installation instructions and project description
- `dicas-claude.md` - Comprehensive guide for writing CLAUDE.md files (in Portuguese)
- `install.sh` - Bash installation script for quick setup
- `settings.json` - Claude Code configuration file

## Key Commands

- View current Claude Code memory configuration: `/memory`
- Install Claude Code: `bash install.sh`
- View git status: `git status`
- View recent commits: `git log --oneline`

## Git Workflow

- Main branch: `main`
- All changes should be made via pull requests
- Commit message format: descriptive and concise
- Repository URL: https://github.com/paulovictor237/claudinho

## Important Notes for Future Instances

When working with this repository:

1. **This is a configuration/documentation repository**, not a traditional software project with source code, builds, or tests.

2. **The primary purpose** is to serve as a template and guide for other Claude Code projects. The `dicas-claude.md` file contains the most valuable information about how to structure CLAUDE.md files effectively.

3. **When editing documentation**:
   - Keep it accurate and up-to-date with the actual setup process
   - Reference the dicas-claude.md file for guidance on what makes good documentation
   - Ensure installation instructions match the actual script and repository setup

4. **Key files to understand the project**:
   - `dicas-claude.md` - The comprehensive guide on CLAUDE.md best practices (main reference material)
   - `README.md` - User-facing installation and usage documentation
   - `install.sh` - The actual installation mechanism
