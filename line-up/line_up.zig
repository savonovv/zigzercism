const std = @import("std");
const mem = std.mem;

pub fn format(allocator: mem.Allocator, name: []const u8, number: u10) ![]u8 {
    return std.fmt.allocPrint(allocator,
        \\{s}, you are the {d}{s} customer we serve today. Thank you!
    , .{ name, number, toOrdinalNumeral(number) });
}

pub fn toOrdinalNumeral(number: u10) []const u8 {
    if (number % 100 == 11 or number % 100 == 12 or number % 100 == 13) return "th";

    const numeral = switch (number % 10) {
        1 => "st",
        2 => "nd",
        3 => "rd",
        else => "th",
    };

    return numeral;
}
