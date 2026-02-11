---
name: worktree-skill
description: Create isolated git worktrees for parallel feature development. Use when starting feature work that needs isolation from current workspace or before executing implementation plans. Creates worktrees in ~/.claude-worktrees/{project-name}/{workflow-name} allowing work on multiple features simultaneously without switching branches or stashing changes. Use when (1) Starting new feature work, (2) Need to work on multiple features in parallel, (3) Want to isolate experimental changes, (4) Before executing implementation plans that modify code.
---

# Worktree

Create isolated git worktrees for parallel feature development without switching branches or stashing changes.

## Overview

This skill creates git worktrees in an organized directory structure: `~/.claude-worktrees/{project-name}/{workflow-name}`

This allows:

- Working on multiple features simultaneously
- Isolating experimental changes from main workspace
- Maintaining clean separation of work contexts
- Avoiding branch switching and stash management

## Workflow

### 1. Validate Repository

Check that we're in a git repository with worktree support:

```bash
git rev-parse --show-toplevel
git worktree list
```

### 2. Determine Project Name

Extract project name from repository root directory:

```bash
basename $(git rev-parse --show-toplevel)
```

### 3. Prepare Workflow Name

Sanitize the workflow name from user input:

- Convert to lowercase
- Replace spaces and special characters with hyphens
- Remove invalid characters
- Example: "Feature Auth" → "feature-auth"

### 4. Check Branch Existence

Determine branch creation strategy:

```bash
# Check remote branches
git branch -r | grep -i "workflow-name"

# Check local branches
git branch | grep -i "workflow-name"
```

**If branch exists remotely**: Create worktree tracking the remote branch
**If branch exists locally**: Warn user and request different name
**If branch is new**: Create new branch in worktree from current HEAD

### 5. Create Worktree

Build the worktree path and create it:

```bash
# Path format
WORKTREE_PATH=~/.claude-worktrees/{project-name}/{sanitized-workflow-name}

# For new branch
git worktree add -b {branch-name} {WORKTREE_PATH}

# For existing remote branch
git worktree add {WORKTREE_PATH} {remote-branch-name}
```

### 6. Verify Creation

Confirm the worktree was created successfully:

```bash
# List worktrees
git worktree list

# Check directory exists
ls -la {WORKTREE_PATH}

# Verify git status in new worktree
cd {WORKTREE_PATH} && git status
```

## Directory Structure

All worktrees are organized under a global base directory:

```
~/.claude-worktrees/
├── project-one/
│   ├── feature-auth/
│   ├── bugfix-login/
│   └── refactor-api/
└── project-two/
    ├── feature-dashboard/
    └── experimental-ui/
```

## Output Format

Upon successful creation, provide:

1. Full path to new worktree
2. Current branch name
3. Git status from new worktree
4. Clear `cd` command for user

Example output:

```
Worktree created successfully!

Path: ~/.claude-worktrees/my-project/feature-auth
Branch: feature-auth
Status: On branch feature-auth, nothing to commit, working tree clean

To switch to this worktree:
cd ~/.claude-worktrees/my-project/feature-auth
```

Keep output clean and minimal - no extra notes or reminders.

## Success Criteria

- New worktree directory created successfully
- Branch properly created or tracking remote
- Git status shows clean working tree in new worktree
- User receives clear path and cd command
