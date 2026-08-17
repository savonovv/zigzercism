const std = @import("std");
pub fn row(allocator: std.mem.Allocator, s: []const u8, index: i32) ![]i16 {
    return parseMatrix(allocator, s, index, null);
}

pub fn column(allocator: std.mem.Allocator, s: []const u8, index: i32) ![]i16 {
    return parseMatrix(allocator, s, null, index);
}

pub fn parseMatrix(allocator: std.mem.Allocator, str: []const u8, row_n: ?i32, column_n: ?i32) ![]i16 {
    var result: std.ArrayList(i16) = .empty;
    errdefer result.deinit(allocator);
    var rows = std.mem.splitScalar(u8, str, '\n');
    var i: i32 = 1;
    while (rows.next()) |row_e| : (i += 1) {
        var columns = std.mem.tokenizeScalar(u8, row_e, ' ');
        var n: i32 = 1;
        while (columns.next()) |column_e| : (n += 1) if (row_n == i or column_n == n) try result.append(allocator, try std.fmt.parseInt(i16, column_e, 10));
    }

    return result.toOwnedSlice(allocator);
}
