const std = @import("std");
const mem = std.mem;

const Mapping = struct {
    value: i16,
    symbols: []const u8,
};

const mappings = [_]Mapping{
    .{ .value = 1000, .symbols = "M" },
    .{ .value = 900, .symbols = "CM" },
    .{ .value = 500, .symbols = "D" },
    .{ .value = 400, .symbols = "CD" },
    .{ .value = 100, .symbols = "C" },
    .{ .value = 90, .symbols = "XC" },
    .{ .value = 50, .symbols = "L" },
    .{ .value = 40, .symbols = "XL" },
    .{ .value = 10, .symbols = "X" },
    .{ .value = 9, .symbols = "IX" },
    .{ .value = 5, .symbols = "V" },
    .{ .value = 4, .symbols = "IV" },
    .{ .value = 1, .symbols = "I" },
};

pub fn toRoman(allocator: mem.Allocator, arabicNumeral: i16) mem.Allocator.Error![]u8 {
    std.debug.assert(arabicNumeral <= 3999);
    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    var remaining: i16 = arabicNumeral;
    for (mappings) |mapping| {
        while (remaining >= mapping.value) : (remaining -= mapping.value) {
            try result.appendSlice(allocator, mapping.symbols);
        }
    }

    return result.toOwnedSlice(allocator);
}
