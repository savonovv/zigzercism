const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;

pub fn recite(allocator: mem.Allocator, words: []const []const u8) mem.Allocator.Error![][]u8 {
    const lines = try allocator.alloc([]u8, words.len);
    errdefer allocator.free(lines);

    var initialized: usize = 0;
    errdefer {
        for (lines[0..initialized]) |line| {
            allocator.free(line);
        }
    }

    while (initialized < words.len) : (initialized += 1) {
        if (words.len == initialized + 1) {
            lines[initialized] = try fmt.allocPrint(allocator, "And all for the want of a {s}.\n", .{words[0]});
        } else {
            lines[initialized] = try fmt.allocPrint(allocator, "For want of a {s} the {s} was lost.\n", .{ words[initialized], words[initialized + 1] });
        }
    }

    return lines;
}
