const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    _ = allocator;
    var result: u64 = 0;

    upper: for (0..limit) |i| {
        for (factors) |factor| {
            if (factor == 0) continue;
            if (i % factor == 0) {
                result += i;
                continue :upper;
            }
        }
    }

    return result;
}
