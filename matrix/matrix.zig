const std = @import("std");
const mem = std.mem;
/// Returns the selected row of the matrix.
pub fn row(allocator: mem.Allocator, s: []const u8, index: i32) ![]i16 {
    return parseMatrix(allocator, s, index, null);
}

/// Returns the selected column of the matrix.
pub fn column(allocator: mem.Allocator, s: []const u8, index: i32) ![]i16 {
    return parseMatrix(allocator, s, null, index);
}

pub fn parseMatrix(allocator: mem.Allocator, str: []const u8, row_n: ?i32, column_n: ?i32) ![]i16 {
    var result: std.ArrayList(i16) = .empty;
    errdefer result.deinit(allocator);
    var rows = std.mem.splitScalar(u8, str, '\n');

    var i: i32 = 1;

    while (rows.next()) |row_e| : (i += 1) {
        var columns = std.mem.tokenizeScalar(u8, row_e, ' ');
        var n: i32 = 1;
        while (columns.next()) |column_e| : (n += 1) {
            const parsed_int = try std.fmt.parseInt(i16, column_e, 10);
            if (row_n == i or column_n == n) try result.append(allocator, parsed_int);
        }
    }

    return result.toOwnedSlice(allocator);
}
