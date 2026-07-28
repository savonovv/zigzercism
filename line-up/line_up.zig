const std = @import("std");
const mem = std.mem;

pub fn format(allocator: mem.Allocator, name: []const u8, number: u10) ![]u8 {
    var size: usize = 0;
    const ordinal = toOrdinalNumeral(number);

    const buffer = try allocator.alloc(u8, name.len + ordinal.len);
    return buffer;
}

pub fn toOrdinalNumeral(number: u10) []const u8 {
    if (number == 11 or number == 12 or number == 13) return "th";
    switch (number % 10) {
        1 => return "st",
        2 => return "nd",
        3 => return "rd",
        else => return "th",
    }
}
