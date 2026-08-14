const std = @import("std");
const mem = std.mem;

pub fn isBalanced(allocator: mem.Allocator, s: []const u8) !bool {
    var stack: std.ArrayList(u8) = .empty;
    defer stack.deinit(allocator);

    for (s) |byte| {
        switch (byte) {
            '(', '[', '{' => try stack.append(allocator, byte),
            '}' => {
                const popped = stack.pop() orelse return false;
                if (popped != '{') return false;
            },
            ']' => {
                const popped = stack.pop() orelse return false;
                if (popped != '[') return false;
            },
            ')' => {
                const popped = stack.pop() orelse return false;
                if (popped != '(') return false;
            },
            else => continue,
        }
    }

    return stack.items.len == 0;
}
