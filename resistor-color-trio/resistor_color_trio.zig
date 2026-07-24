const std = @import("std");
const mem = std.mem;

pub const ColorError = error{OutOfBound};

pub const ColorBand = enum(usize) {
    black = 0,
    brown = 1,
    red = 2,
    orange = 3,
    yellow = 4,
    green = 5,
    blue = 6,
    violet = 7,
    grey = 8,
    white = 9,
};

pub fn two_band_color_code(color_a: ColorBand, color_b: ColorBand) usize {
    return @intFromEnum(color_a) * 10 + @intFromEnum(color_b);
}

pub fn calculate_resistance(colors: []const ColorBand) ColorError!usize {
    if (colors.len < 3) return ColorError.OutOfBound;
    return two_band_color_code(colors[0], colors[1]) * std.math.pow(usize, 10, @intFromEnum(colors[2]));
}

pub fn label(allocator: mem.Allocator, colors: []const ColorBand) mem.Allocator.Error![]u8 {
    const resistance = calculate_resistance(colors) catch 0;
    var scaled_resistance: f32 = @floatFromInt(resistance);
    var size: usize = 0;
    while (scaled_resistance >= 1000) : (scaled_resistance /= 1000) {
        size += 1;
    }

    const prefix: []const u8 = switch (size) {
        0 => "",
        1 => "kilo",
        2 => "mega",
        3 => "giga",
        else => unreachable,
    };

    return std.fmt.allocPrint(allocator, "{d} {s}ohms", .{ scaled_resistance, prefix });
}
