const std = @import("std");
const mem = std.mem;

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    if (value <= 1) return &[_]u64{};

    var found_factors: std.ArrayList(u64) = .empty;
    errdefer found_factors.deinit(allocator);

    var remaining = value;
    var candidate: u64 = 2;

    while (candidate <= remaining / candidate) {
        if (remaining % candidate == 0) {
            try found_factors.append(allocator, candidate);
            remaining /= candidate;
        } else if (candidate == 2) candidate += 1 else candidate += 2;
    }

    try found_factors.append(allocator, remaining);

    return try found_factors.toOwnedSlice(allocator);
}
