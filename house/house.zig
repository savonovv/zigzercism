const std = @import("std");

const phrases = [_][]const u8{
    "the house that Jack built.",
    "the malt that lay in ",
    "the rat that ate ",
    "the cat that killed ",
    "the dog that worried ",
    "the cow with the crumpled horn that tossed ",
    "the maiden all forlorn that milked ",
    "the man all tattered and torn that kissed ",
    "the priest all shaven and shorn that married ",
    "the rooster that crowed in the morn that woke ",
    "the farmer sowing his corn that kept ",
    "the horse and the hound and the horn that belonged to ",
};

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) ![]const u8 {
    std.debug.assert(start_verse >= 1);
    std.debug.assert(start_verse <= end_verse);
    std.debug.assert(end_verse <= phrases.len);

    var writer = std.Io.Writer.fixed(buffer);

    var verse: usize = @intCast(start_verse - 1);
    const last_verse: usize = @intCast(end_verse - 1);
    while (verse <= last_verse) : (verse += 1) {
        try writer.writeAll("This is ");

        var phrase = verse;
        while (true) : (phrase -= 1) {
            try writer.writeAll(phrases[phrase]);
            if (phrase == 0) break;
        }

        if (verse < last_verse) try writer.writeByte('\n');
    }

    return writer.buffered();
}
