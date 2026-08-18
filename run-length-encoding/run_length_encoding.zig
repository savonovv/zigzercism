const std = @import("std");

pub fn encode(buffer: []u8, string: []const u8) []u8 {
    var counter: usize = 0;
    var last_checked: u8 = .empty;
    var size: usize = 0;

    for (string, 0..) |char, i| {
        if ((i != 0 and char != last_checked) or i == string.len - 1) {
            if (counter > 1) {
                const digits = std.fmt.bufPrint(buffer[size..], "{d}", .{counter}) catch unreachable;
                size += digits.len;
            }
            size += 1;
            buffer[size] = last_checked;

            counter = 0;
        }
        counter += 1;
        last_checked = char;
    }

    return buffer[0..size];
}
//
// pub fn decode(buffer: []u8, string: []const u8) []u8 {
//     _ = buffer;
//     _ = string;
//     @compileError("please implement the decode function");
// }
