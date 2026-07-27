const std = @import("std");

pub fn response(s: []const u8) []const u8 {
    const message = std.mem.trim(u8, s, &std.ascii.whitespace);
    var mask: u4 = 0;
    for (message, 0..) |char, i| {
        mask |= 1 << 3;
        if (char == '?' and message.len == i + 1) mask |= 1 << 0;
        if (std.ascii.isLower(char)) mask |= 1 << 1;
        if (std.ascii.isUpper(char)) mask |= 1 << 2;
    }

    switch (mask) {
        0 => return "Fine. Be that way!",
        0b1011, 0b1111, 0b1001 => return "Sure.",
        0b1100 => return "Whoa, chill out!",
        0b1101 => return "Calm down, I know what I'm doing!",
        else => return "Whatever.",
    }
}
