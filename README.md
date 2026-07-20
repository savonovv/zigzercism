# Zigzercism

Zig exercises and practical learning notes collected while working through the
[Exercism Zig track](https://exercism.org/tracks/zig).

## Learning Notes

[`index.html`](./index.html) is a standalone, Kanagawa-themed reference for the
Zig concepts encountered along the way. It currently covers mutable buffers,
slices, byte copying, formatting, sequential writes, and string reversal.

The project-local OpenCode skill in
`.opencode/skills/update-zig-notes/` keeps the reference updated with durable,
context-independent answers to future Zig questions.

## Exercises

| Exercise | Status |
| --- | --- |
| [Raindrops](./raindrops/) | Complete |
| [Reverse String](./reverse-string/) | Complete |
| [RNA Transcription](./rna-transcription/) | In progress |

## Running Tests

Run a test suite from its exercise directory:

```sh
cd raindrops
zig test test_raindrops.zig
```

Replace the directory and test filename for another exercise.
