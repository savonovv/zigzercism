const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var iterator_count = mem.tokenizeAny(u8, words, " -_");
    var alloc_size: usize = 0;

    while (iterator_count.next()) |_| {
        alloc_size += 1;
    }

    const result = try allocator.alloc(u8, alloc_size);

    var iterator = mem.tokenizeAny(u8, words, " -_");
    var i: usize = 0;

    while (iterator.next()) |word| : (i += 1) {
        result[i] = std.ascii.toUpper(word[0]);
    }

    return result;
}
