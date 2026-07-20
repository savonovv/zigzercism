const std = @import("std");

pub fn convert(buffer: []u8, n: u32) []const u8 {
    var used: usize = 0;
    if (n%3==0) {
        @memcpy(buffer[used .. used + 5], "Pling");
        used +=5;
    }
    if (n%5==0) {
        @memcpy(buffer[used .. used + 5], "Plang");
        used +=5;
    }
    if (n%7==0) {
        @memcpy(buffer[used .. used + 5], "Plong");
        used +=5;
    }
    if (used > 0) {
        return buffer[0..used];
    } else {
        return std.mem.print(buffer, "{}", .{n}) catch unreachable;
    }
}
