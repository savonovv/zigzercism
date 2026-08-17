const std = @import("std");
const mem = std.mem;

pub fn translate(allocator: mem.Allocator, phrase: []const u8) mem.Allocator.Error![]u8 {
    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    var tokenized = std.mem.tokenizeScalar(u8, phrase, ' ');

    while (tokenized.next()) |str| {
        for (str, 0..) |char, i| {
            switch (std.ascii.toLower(char)) {
                'a', 'e', 'i', 'o', 'u' => {
                    try result.appendSlice(allocator, str[i..]);
                    try result.appendSlice(allocator, str[0..i]);
                    try result.appendSlice(allocator, "ay");
                    break;
                },
                'q' => {
                    if (i + 1 < str.len and str[i + 1] == 'u') {
                        try result.appendSlice(allocator, str[i + 2 ..]);
                        try result.appendSlice(allocator, str[0 .. i + 2]);
                        try result.appendSlice(allocator, "ay");
                        break;
                    }
                },
                'x' => {
                    if (i == 0 and i + 1 < str.len and str[i + 1] == 'r') {
                        try result.appendSlice(allocator, str[i..]);
                        try result.appendSlice(allocator, "ay");
                        break;
                    }
                },
                'y' => {
                    if (i == 0 and i + 1 < str.len and str[i + 1] == 't') {
                        try result.appendSlice(allocator, str[i..]);
                        try result.appendSlice(allocator, "ay");
                        break;
                    }
                    if (i == 0) continue;
                    try result.appendSlice(allocator, str[i..]);
                    try result.appendSlice(allocator, str[0..i]);
                    try result.appendSlice(allocator, "ay");
                    break;
                },
                else => {},
            }
        }

        if (tokenized.rest().len > 0) try result.append(allocator, ' ');
    }

    return result.toOwnedSlice(allocator);
}
