const std = @import("std");
const mem = std.mem;

pub const Box = union(enum) {
    none,
    one: i12,
    many: []const Box,
};

pub fn flatten(allocator: mem.Allocator, box: Box) mem.Allocator.Error![]i12 {
    var result: std.ArrayList(i12) = .empty;
    errdefer result.deinit(allocator);

    switch (box) {
        .none => {},
        .one => |value| {
            try result.append(allocator, value);
        },
        .many => |children| {
            for (children) |c_box| {
                const nested = try flatten(allocator, c_box);
                defer allocator.free(nested);
                try result.appendSlice(allocator, nested);
            }
        },
    }

    return result.toOwnedSlice(allocator);
}
