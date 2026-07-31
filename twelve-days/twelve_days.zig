const std = @import("std");
const dict: [12][3][]const u8 = .{
    .{ "first", "a", "Partridge in a Pear Tree" },
    .{ "second", "two", "Turtle Doves" },
    .{ "third", "three", "French Hens" },
    .{ "fourth", "four", "Calling Birds" },
    .{ "fifth", "five", "Gold Rings" },
    .{ "sixth", "six", "Geese-a-Laying" },
    .{ "seventh", "seven", "Swans-a-Swimming" },
    .{ "eighth", "eight", "Maids-a-Milking" },
    .{ "ninth", "nine", "Ladies Dancing" },
    .{ "tenth", "ten", "Lords-a-Leaping" },
    .{ "eleventh", "eleven", "Pipers Piping" },
    .{ "twelve", "twelve", "Drummers Drumming" },
};

const ReciteError = error{IndexOutOfBound};

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) ![]const u8 {
    if (start_verse > end_verse or start_verse < 1 or start_verse > 12 or end_verse < 1 or end_verse > 12) return ReciteError.IndexOutOfBound;

    var writer = std.Io.Writer.fixed(buffer);

    const normalized_start = start_verse - 1;
    const normalized_end = end_verse - 1;

    var i = normalized_start;
    while (i <= normalized_end) : (i += 1) {
        try writer.print("On the {s} day of Christmas my true love gave to me:", .{dict[i][0]});

        // \\On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.
        // \\On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.
        // \\On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
        var n = normalized_start + i;
        while (n <= normalized_start) : (n += 1) {
            // try writer.print(" {s} {s}", .{ end_verse, n });
            std.debug.print(
                \\ inner loop
                \\ i = {d}
                \\ n = {d}
                \\ end_verse = {d}
                \\
            , .{ i, n, normalized_end });
        }
    }

    return writer.buffered();
}
