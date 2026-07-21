// | Letter                       | Value |
// | ---------------------------- | ----- |
// | A, E, I, O, U, L, N, R, S, T | 1     |
// | D, G                         | 2     |
// | B, C, M, P                   | 3     |
// | F, H, V, W, Y                | 4     |
// | K                            | 5     |
// | J, X                         | 8     |
// | Q, Z                         | 10    |
const std = @import("std");

pub fn score(s: []const u8) u32 {
    var result: u32 = 0;
    for (s) |char| {
        switch (std.ascii.toLower(char)) {
            'a', 'e', 'i', 'o', 'u', 'l', 'n', 'r', 's', 't' => result += 1,
            'd', 'g' => result += 2,
            'b', 'c', 'm', 'p' => result += 3,
            'f', 'h', 'v', 'w', 'y' => result += 4,
            'k' => result += 5,
            'j', 'x' => result += 8,
            'q', 'z' => result += 10,
            else => unreachable,
        }
    }
    return result;
}
