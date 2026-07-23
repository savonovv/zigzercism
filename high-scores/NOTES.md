# High Scores Learning Notes

## Current Checkpoint

The fixed array has capacity for three scores, but capacity is not the same as
the number of initialized entries. The current implementation still needs to
maintain this invariant:

```text
high_scores[0..top_len] is initialized and sorted descending.
high_scores[top_len..3] is uninitialized and must never be read.
```

`top_len` starts at zero, grows by at most one per inserted score, and never
exceeds `high_scores.len`.

## Two Limits

```text
top_len          logical length: safe read boundary
high_scores.len  physical capacity: safe write boundary
```

Search only the initialized prefix. Capacity is used only to decide whether a
new score can enter the bounded result.

```text
Find the first index where the new score belongs in [0..top_len].

If the index equals capacity:
    the result is full and the score is too small; skip it.

Otherwise:
    new_len = min(top_len + 1, capacity)
    shift the affected initialized tail right
    write the new score once
    top_len = new_len
```

## Why Shift Backward?

Suppose the initialized array is:

```text
index:   0   1   2
value:  90  70  30
```

Insert `100` at index `0`. Start at the last destination and move toward the
insertion point.

First copy index 1 to index 2:

```text
before: 90  70  30
after:  90  70  70
```

Then copy index 0 to index 1:

```text
before: 90  70  70
after:  90  90  70
```

Finally write the new value at index 0:

```text
result: 100  90  70
```

The loop must copy data, not merely decrement the index:

```zig
var j = new_len - 1;
while (j > insert_at) : (j -= 1) {
    high_scores[j] = high_scores[j - 1];
}
high_scores[insert_at] = score;
```

Moving left-to-right would overwrite a value before it had been copied. Moving
right-to-left preserves every value that still belongs in the bounded result.

## Example: 20, 10, 30

```text
start
    values = [?, ?, ?]
    top_len = 0

insert 20 at 0
    values = [20, ?, ?]
    top_len = 1

insert 10 at 1
    values = [20, 10, ?]
    top_len = 2

insert 30 at 0
    copy [1] -> [2]  => [20, 10, 10]
    copy [0] -> [1]  => [20, 20, 10]
    write 30 at [0]  => [30, 20, 10]
    top_len = 3
```

The returned slice is only `high_scores[0..top_len]`; unused slots are never
exposed.
