const std = @import("std");
const mem = std.mem;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    const intermediate = try decodeToInteger(digits, input_base);
    return encodeToOutput(allocator, intermediate, output_base);
}

fn decodeToInteger(digits: []const u32, base: u32) ConversionError!u32 {
    if (base < 2) return ConversionError.InvalidInputBase;

    var intermediate: u32 = 0;
    for (digits) |digit| {
        if (digit >= base) return ConversionError.InvalidDigit;
        intermediate = intermediate * base + digit;
    }

    return intermediate;
}

fn encodeToOutput(allocator: mem.Allocator, intermediate: u32, base: u32) (mem.Allocator.Error || ConversionError)![]u32 {
    if (base < 2) return ConversionError.InvalidOutputBase;

    var value = intermediate;
    var output: std.ArrayList(u32) = .empty;
    errdefer output.deinit(allocator);

    if (value == 0) try output.append(allocator, value);

    while (value > 0) : (value /= base) {
        try output.append(allocator, value % base);
    }

    std.mem.reverse(u32, output.items);

    return output.toOwnedSlice(allocator);
}
