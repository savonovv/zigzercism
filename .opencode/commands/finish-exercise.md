---
description: Review, document, submit, commit, and push a Zig exercise
agent: build
---

Finish the Zig Exercism exercise in directory `$1` end to end.

If `$1` is empty or does not identify exactly one exercise directory, ask for a valid directory and stop.

Follow this sequence:

1. Load the `review-zig-solution` and `update-zig-notes` skills.
2. Read the exercise source, tests, README, `.exercism/config.json`, repository README, and relevant field notes.
3. Treat exercise source and tests as read-only. Never change them during review, documentation, submission, or Git operations. If tests expose a problem, report focused findings and stop before submission.
4. Run `zig fmt --check` on the configured solution file and run the exercise's complete `zig test` suite from its directory.
5. Review correctness, ownership, edge cases, idioms, complexity, and allocation behavior. Continue only when there are no blocking findings and all tests pass.
6. Update root `index.html` with only new durable, context-independent lessons. Merge into existing topics when appropriate and preserve inline Kanagawa CSS, local anchors, and the no-JavaScript/no-external-assets rule.
7. Mark the exercise complete in root `README.md` without changing unrelated entries.
8. Validate HTML anchors, forbidden external assets, `git diff --check`, and the final intended diff.
9. Submit only the configured solution file with `exercism submit` from the exercise directory. Stop if submission fails.
10. Before committing, inspect `git status`, the full diff, and `git log --oneline -10`. Never stage unrelated work.
11. Stage the exercise directory, `index.html`, `README.md`, and only other files intentionally created for this exercise. Commit with a concise message matching repository history, then push the current tracked branch without force.
12. Confirm the worktree is clean and synchronized. Report test totals, formatting result, Exercism URL, commit hash, and GitHub push result.

Do not amend commits, force-push, modify unrelated work, or silently fix exercise source.
