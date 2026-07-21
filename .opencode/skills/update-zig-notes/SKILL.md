---
name: update-zig-notes
description: Update index.html with durable Zig learning Q&A. Use when the user asks a Zig question, resolves a Zig error, or asks to add, collect, document, or update their learning notes.
---

# Update Zig Notes

Maintain `/home/gorilla/projects/zig/index.html` as the user's concise Zig learning reference.

## Workflow

1. Answer and resolve the user's Zig question interactively before editing the notes unless the user explicitly asks for an immediate update.
2. Read `index.html` and determine whether the lesson is new, corrects existing content, or belongs in an existing answer.
3. Add only durable concepts, useful diagnostics, and minimal verified examples. Do not archive the conversation verbatim.
4. Merge closely related material into an existing section instead of creating duplicate questions.
5. When a genuinely new topic is added, add its anchor to the topic navigation and continue the two-digit question numbering.
6. Preserve the single-file document: semantic HTML, the existing inline Kanagawa CSS, no JavaScript, and no external dependencies.
7. Preserve the page's direct teaching style: explain the mental model, show a small example, and call out a common mistake or constraint when useful.
8. Write questions and answers as reusable concepts, not as descriptions of one exercise, test case, or conversation. Use neutral names and context-independent examples.
9. Check examples against the Zig version used by the current project. Mark version-dependent APIs clearly.
10. Validate that local fragment links resolve and that the file contains no script tags or external assets.

## Content Rules

- Prefer ASCII in source code and prose. Existing visible replacement characters used to illustrate uninitialized memory may remain.
- Escape HTML-sensitive code characters such as `&`, `<`, and `>`.
- Keep examples focused; do not insert complete Exercism solutions unless the user has already completed them or explicitly requests one.
- Avoid exercise names, fixed values, and copied test output unless they are essential to the concept.
- Do not add dates, progress counters, or generated metadata that creates maintenance noise.
- Never alter exercise source files while teaching, answering questions, diagnosing errors, reviewing solutions, updating notes, or preparing a commit.
- Treat suggestions and discovered issues as feedback only. Do not turn them into source edits.
- Only edit exercise source when the user explicitly asks to implement a specific change. Requests such as "update the repo", "update the notes", or "commit" do not grant permission to change exercise code.
- If it is unclear whether the user wants an explanation or an implementation, ask before editing.
