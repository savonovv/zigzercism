const std = @import("std");
const mem = std.mem;

pub fn rows(allocator: mem.Allocator, letter: u8) mem.Allocator.Error![][]u8 {
    std.debug.assert(letter >= 'A');
    std.debug.assert(letter <= 'Z');

    const radius: usize = letter - 'A';
    const line_len = radius * 2 + 1;

    const result = try allocator.alloc([]u8, line_len);
    errdefer allocator.free(result);

    var i: usize = 0;

    errdefer {
        for (result[0..i]) |line| {
            allocator.free(line);
        }
    }

    while (i < line_len) : (i += 1) {
        const line = try allocator.alloc(u8, line_len);
        @memset(line, ' ');

        const rank = @min(i, line_len - 1 - i);

        const current_letter: u8 = 'A' + @as(u8, @intCast(rank));
        line[radius - rank] = current_letter;
        line[radius + rank] = current_letter;

        result[i] = line;
    }

    return result;
}
