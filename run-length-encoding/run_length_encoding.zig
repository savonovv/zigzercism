const std = @import("std");

pub fn encode(buffer: []u8, string: []const u8) []u8 {
    if (string.len == 0) return buffer[0..0];
    var counter: usize = 1;
    var current: u8 = string[0];
    var size: usize = 0;

    for (string[1..]) |char| {
        if (char != current) {
            if (counter > 1) {
                const digits = std.fmt.bufPrint(buffer[size..], "{d}", .{counter}) catch unreachable;
                size += digits.len;
            }
            buffer[size] = current;
            size += 1;
            counter = 0;
        }
        counter += 1;
        current = char;
    }

    if (counter > 1) {
        const digits = std.fmt.bufPrint(buffer[size..], "{d}", .{counter}) catch unreachable;
        size += digits.len;
    }
    buffer[size] = current;
    size += 1;

    return buffer[0..size];
}

pub fn decode(buffer: []u8, string: []const u8) []u8 {
    var input_index: usize = 0;
    var output_index: usize = 0;

    while (input_index < string.len) : (input_index += 1) {
        const number_start = input_index;
        while (input_index < string.len and std.ascii.isDigit(string[input_index])) : (input_index += 1) {}

        const count = if (input_index == number_start) 1 else std.fmt.parseInt(usize, string[number_start..input_index], 10) catch unreachable;

        @memset(buffer[output_index .. output_index + count], string[input_index]);
        output_index += count;
    }

    return buffer[0..output_index];
}
