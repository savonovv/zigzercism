---
name: review-zig-solution
description: Review Zig solutions for correctness, idioms, optimality, Zig Zen alignment, and data-oriented design. Use when the user asks for a code review, whether a Zig solution is idiomatic or optimal, whether it follows Zig Zen, or how it relates to DOD, AoS, or SoA.
---

# Review Zig Solution

Perform a read-only review of a Zig solution. Prioritize correctness and useful
learning over stylistic preference.

## Source Boundary

- Never modify exercise source, tests, notes, configuration, or any other file.
- Never turn a finding into an edit, even when the fix is obvious.
- Run read-only checks and tests when useful.
- Give focused hints and small illustrative fragments, not a complete replacement
  solution, unless the user explicitly asks for one.
- If the target solution is unclear, ask which file or exercise to review.

## Review Workflow

1. Read the implementation, tests, and relevant exercise requirements.
2. Check the Zig version used by the project before judging APIs or idioms.
3. Run the relevant tests. Use `zig fmt --check` when formatting is part of the
   review; never run a formatter that writes files.
4. Review in this order:
   - correctness and requirement coverage;
   - edge cases, integer overflow, invalid inputs, and error behavior;
   - ownership, lifetimes, allocation, and cleanup;
   - clarity and Zig idioms;
   - time and space complexity;
   - Zig Zen alignment;
   - DOD relevance and data layout.
5. Report findings before praise or summary. Order findings by severity and cite
   `path:line` references.
6. If there are no findings, say so explicitly and identify residual test or
   input-domain risks.

## Correctness And Idioms

Check for:

- behavior required by both tests and README, including untested requirements;
- consumed iterators, uninitialized bytes, invalid ranges, and boundary errors;
- signed and unsigned underflow, overflow, narrowing, and incorrect accumulator
  types;
- explicit error handling and allocation failure;
- matching allocation and deallocation ownership;
- use of `usize` for lengths and indexes;
- standard-library functions and builtins that communicate intent more directly;
- unnecessary allocation, copying, casts, abstraction, or control-flow cleverness;
- APIs that actually exist in the project's Zig version.

Do not call code unidiomatic merely because another valid spelling is shorter.
Prefer the smallest change in concept and explain the tradeoff.

## Optimality

State the current time and extra-space complexity. Separate three questions:

1. Is it asymptotically optimal for the stated problem?
2. Is it practically appropriate for the tested input sizes?
3. Would a more complex approach provide a measurable benefit?

Do not equate fewer lines, bit tricks, fewer function calls, or no allocator with
faster code. Account for overflow, readability, input size, and compiler
optimization. Recommend benchmarking when performance depends on constants,
cache behavior, branch prediction, or vectorization.

## Zig Zen

Use the principles reported by `zig zen` for the installed Zig version:

- Communicate intent precisely.
- Edge cases matter.
- Favor reading code over writing code.
- Only one obvious way to do things.
- Runtime crashes are better than bugs.
- Compile errors are better than runtime crashes.
- Incremental improvements.
- Avoid local maximums.
- Reduce the amount one must remember.
- Focus on code rather than style.
- Resource allocation may fail; resource deallocation must succeed.
- Memory is a resource.
- Together we serve the users.

Only cite principles that materially apply. Explain the concrete connection;
do not award a vague "Zig Zen compliant" label. Distinguish safety checks and
intent from personal formatting preferences.

## Data-Oriented Design

Treat data-oriented design as a performance design method based on data layout,
access patterns, transformations, and hardware behavior. It is not synonymous
with procedural programming, explicit allocation, `comptime`, ECS, or Zig in
general.

Assess DOD only when the workload has meaningful collections, hot loops, or data
movement. Consider:

- number of elements and frequency of processing;
- which fields are read or written together;
- contiguous versus scattered access;
- working-set size and cache-line utilization;
- batching and opportunities for SIMD;
- temporary allocations and data transformation costs;
- whether measurement shows the code is performance-sensitive.

### AoS Versus SoA

- Do not claim AoS is inherently slower.
- AoS can be preferable when records are small, fields are commonly accessed
  together, or the workload is not hot.
- SoA can be preferable when large loops repeatedly process only a subset of
  fields, denser access improves cache use, or SIMD benefits are plausible.
- Include conversion complexity, ergonomics, synchronization between arrays,
  and measured performance in the tradeoff.
- Do not recommend ECS or SoA for a small scalar exercise without a relevant
  data-layout problem.

Classify DOD relevance as one of:

- `Not applicable`: scalar or tiny workload with no meaningful layout decision.
- `Low`: a collection exists, but layout is unlikely to matter.
- `Medium`: repeated collection processing makes access patterns relevant.
- `High`: data layout, bandwidth, cache behavior, or SIMD dominates the design.

## Response Format

Use this compact structure:

```markdown
**Findings**

1. **Severity: concise title** - `path:line`
   Explain the behavior, evidence, and consequence.

**Assessment**

- Tests: pass/fail/not run
- Idiomatic Zig: yes/mixed/no, with one sentence
- Complexity: time and extra space
- Zig Zen: only the relevant principles
- DOD relevance: not applicable/low/medium/high, with justification
- Residual risks: untested inputs, overflow limits, or benchmark gaps
```

If no findings exist, begin with `No correctness findings.` Keep optional
improvements separate from defects so the user can distinguish necessary work
from experimentation.
