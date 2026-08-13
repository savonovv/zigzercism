const std = @import("std");

pub const SeriesError = error{
    InvalidCharacter,
    NegativeSpan,
    InsufficientDigits,
};

pub fn largestProduct(digits: []const u8, span: i32) SeriesError!u64 {
    if (span < 0) return SeriesError.NegativeSpan;
    if (span == 0) return 1;
    if (span > digits.len) return SeriesError.InsufficientDigits;

    var result: u64 = 0;

    var i: usize = 0;

    const width: usize = @intCast(span);

    while (i + width <= digits.len) : (i += 1) {
        var product: u64 = 1;

        for (digits[i .. i + width]) |value| {
            if (!std.ascii.isDigit(value)) return SeriesError.InvalidCharacter;

            product *= value - '0';
        }
        result = @max(result, product);
    }

    return result;
}
