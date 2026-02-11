---
name: worktree
description: Create a new git worktree for isolated feature development
argument-hint: [feature-name]
allowed-tools: Bash(git *), Read, Glob
---

<objective>
Create a new git worktree for the specified feature/workflow in an isolated directory.

This allows working on multiple features simultaneously without switching branches or stashing changes, maintaining a clean separation of work contexts.

The worktree will be created in: `~/.claude-worktrees/{project-name}/{workflow-name}`
</objective>

<context>
Current repository state:
- Repository root: !`git rev-parse --show-toplevel`
- Current branch: !`git branch --show-current`
- Existing worktrees: !`git worktree list`
- Remote branches: !`git branch -r | head -10`

Project name will be extracted from the repository root directory name.
Worktrees will be organized in: `~/.claude-worktrees/{project-name}/{workflow-name}`
</context>

<process>
1. Validate that we're in a git repository and worktree feature is available
2. Determine the base directory for worktrees:
   - Get repository name from current directory or git remote
   - Use pattern: `~/.claude-worktrees/{project-name}/{workflow-name}`
   - Create directory structure if it doesn't exist
3. Sanitize workflow name from argument:
   - Convert to lowercase
   - Replace spaces and special chars with hyphens
   - Remove invalid characters
4. Check if branch already exists:
   - If exists remotely: create worktree tracking remote branch
   - If exists locally: warn and ask to use different name
   - If new: create new branch in worktree
5. Create the worktree:
   - Use format: `~/.claude-worktrees/{project-name}/{sanitized-workflow-name}`
   - Execute: `git worktree add -b [branch-name] [path] [start-point]`
6. Verify worktree creation
</process>

<verification>
After creating the worktree, verify:
- Worktree appears in `git worktree list`
- Directory exists and is accessible
- Branch is created or tracked correctly
- No errors in git status within new worktree
</verification>

<success_criteria>

- New worktree directory created successfully
- Branch properly created or tracking remote
- Git status shows clean working tree in new worktree
- User receives clear path to new worktree and cd command
  </success_criteria>

<output>
Upon successful creation:
1. Show full path to new worktree: `~/.claude-worktrees/{project-name}/{workflow-name}`
2. Display current branch in new worktree
3. Show git status from the new worktree
4. Provide clear `cd` command for switching to the worktree

Keep the output clean and minimal - no extra notes or reminders.
</output>
