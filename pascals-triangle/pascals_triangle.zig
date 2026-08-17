const std = @import("std");
const mem = std.mem;

pub fn rows(allocator: mem.Allocator, count: usize) mem.Allocator.Error![][]u128 {
    const triangle = try allocator.alloc([]u128, count);
    errdefer allocator.free(triangle);

    var i: usize = 0;
    errdefer {
        for (triangle[0..i]) |alloc_row| allocator.free(alloc_row);
    }
    while (i < count) : (i += 1) {
        const current_row = try allocator.alloc(u128, i + 1);
        var n: usize = 0;

        while (n <= i) : (n += 1) {
            if (n == 0 or n == i) {
                current_row[n] = 1;
            } else {
                current_row[n] = triangle[i - 1][n - 1] + triangle[i - 1][n];
            }
        }
        triangle[i] = current_row;
    }

    return triangle;
}
