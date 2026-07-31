const std = @import("std");
const dict: [12][2][]const u8 = .{
    .{ "first", "a Partridge in a Pear Tree" },
    .{ "second", "two Turtle Doves" },
    .{ "third", "three French Hens" },
    .{ "fourth", "four Calling Birds" },
    .{ "fifth", "five Gold Rings" },
    .{ "sixth", "six Geese-a-Laying" },
    .{ "seventh", "seven Swans-a-Swimming" },
    .{ "eighth", "eight Maids-a-Milking" },
    .{ "ninth", "nine Ladies Dancing" },
    .{ "tenth", "ten Lords-a-Leaping" },
    .{ "eleventh", "eleven Pipers Piping" },
    .{ "twelfth", "twelve Drummers Drumming" },
};

const ReciteError = error{IndexOutOfBound};

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) ![]const u8 {
    if (start_verse > end_verse or start_verse < 1 or start_verse > 12 or end_verse < 1 or end_verse > 12) return ReciteError.IndexOutOfBound;

    var writer = std.Io.Writer.fixed(buffer);

    var i = start_verse;
    while (i <= end_verse) : (i += 1) {
        try writer.print("On the {s} day of Christmas my true love gave to me: ", .{dict[i - 1][0]});

        var n = i;
        while (n >= 1) : (n -= 1) {
            try writer.print("{s}", .{dict[n - 1][1]});
            if (n - 1 == 0) try writer.writeAll(".");
            if (n - 1 == 1) try writer.writeAll(", and ");
            if (n - 1 >= 2) try writer.writeAll(", ");
        }
        if (i != end_verse) try writer.writeAll("\n");
    }

    return writer.buffered();
}
