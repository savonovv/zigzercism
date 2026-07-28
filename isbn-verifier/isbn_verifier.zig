const std = @import("std");

pub fn isValidIsbn10(string: []const u8) bool {
    var check_sum: usize = 0;
    var position: usize = 0;

    for (string) |char| {
        if (char == '-') continue;
        if (position >= 10) return false;
        if (std.ascii.isDigit(char)) {
            check_sum += (char - '0') * (10 - position);
            position += 1;
        } else if (char == 'X' and position == 9) {
            check_sum += 10;
            position += 1;
        } else {
            return false;
        }
    }

    if (position != 10) return false;

    return check_sum % 11 == 0;
}
