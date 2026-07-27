const std = @import("std");

const Error = error{IndexOutOfBound};

const Capitalized = struct {
    text: []const u8,

    pub fn format(self: Capitalized, writer: *std.Io.Writer) std.Io.Writer.Error!void {
        if (self.text.len == 0) return;
        try writer.print("{c}{s}", .{ std.ascii.toUpper(self.text[0]), self.text[1..] });
    }
};

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) ![]const u8 {
    if (start_bottles < take_down or start_bottles > 10 or take_down > 10) return Error.IndexOutOfBound;

    var start: u32 = start_bottles;
    var writer = std.Io.Writer.fixed(buffer);

    while (start > start_bottles - take_down) : (start -= 1) {
        const numerated = numeration(start);
        const cap_numeration = Capitalized{ .text = numerated };

        try writer.print(
            \\{f} green bottle{s} hanging on the wall,
            \\{f} green bottle{s} hanging on the wall,
            \\And if one green bottle should accidentally fall,
            \\There'll be {s} green bottle{s} hanging on the wall.
        , .{ cap_numeration, plural(start), cap_numeration, plural(start), numeration(start - 1), plural(start - 1) });

        if (start > start_bottles - take_down + 1) {
            try writer.writeAll("\n\n");
        }
    }

    return writer.buffered();
}

pub fn plural(number: u32) []const u8 {
    if (number == 1) return "" else return "s";
}

pub fn numeration(number: u32) []const u8 {
    switch (number) {
        0 => return "no",
        1 => return "one",
        2 => return "two",
        3 => return "three",
        4 => return "four",
        5 => return "five",
        6 => return "six",
        7 => return "seven",
        8 => return "eight",
        9 => return "nine",
        10 => return "ten",
        else => unreachable,
    }
}
