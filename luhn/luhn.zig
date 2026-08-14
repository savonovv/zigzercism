const std = @import("std");

pub fn isValid(s: []const u8) bool {
    var sum: usize = 0;
    var odd: bool = false;

    var i = s.len;
    var counter: usize = 0;

    while (i > 0) {
        i -= 1;
        const c = s[i];
        if (c == ' ') continue;
        if (!std.ascii.isDigit(c)) return false;

        var digit = c - '0';

        if (odd) {
            digit = digit * 2;
            if (digit > 9) digit -= 9;
        }

        sum += digit;
        odd = !odd;
        counter += 1;
    }

    if (counter < 2) return false;

    return sum % 10 == 0;
}
