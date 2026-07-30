const std = @import("std");
const mem = std.mem;

pub fn rotate(allocator: mem.Allocator, text: []const u8, shiftKey: u5) mem.Allocator.Error![]u8 {
    const ciphered_text = try allocator.alloc(u8, text.len);

    for (text, 0..) |char, i| {
        const base: u8 = if (std.ascii.isLower(char)) 'a' else if (std.ascii.isUpper(char)) 'A' else {
            ciphered_text[i] = char;
            continue;
        };

        const offset: u8 = char - base;
        const shifted = (offset + @as(u8, shiftKey)) % 26;
        ciphered_text[i] = base + shifted;
    }

    return ciphered_text;
}
