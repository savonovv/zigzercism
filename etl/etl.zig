const std = @import("std");
const mem = std.mem;

pub fn transform(allocator: mem.Allocator, legacy: std.AutoHashMap(i5, []const u8)) mem.Allocator.Error!std.AutoHashMap(u8, i5) {
    var result = std.AutoHashMap(u8, i5).init(allocator);
    errdefer result.deinit();

    var iterator = legacy.iterator();

    while (iterator.next()) |pair| {
        for (pair.value_ptr.*) |char| {
            try result.put(std.ascii.toLower(char), pair.key_ptr.*);
        }
    }

    return result;
}
