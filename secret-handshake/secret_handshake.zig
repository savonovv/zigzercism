const std = @import("std");
const mem = std.mem;

pub const Signal = enum(u5) {
    wink = 1 << 0,
    double_blink = 1 << 1,
    close_your_eyes = 1 << 2,
    jump = 1 << 3,
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var sequence: std.ArrayList(Signal) = .empty;
    errdefer sequence.deinit(allocator);

    if ((number & @intFromEnum(Signal.wink)) != 0) try sequence.append(allocator, .wink);
    if ((number & @intFromEnum(Signal.double_blink)) != 0) try sequence.append(allocator, .double_blink);
    if ((number & @intFromEnum(Signal.close_your_eyes)) != 0) try sequence.append(allocator, .close_your_eyes);
    if ((number & @intFromEnum(Signal.jump)) != 0) try sequence.append(allocator, .jump);
    if ((number & 1 << 4) != 0) mem.reverse(Signal, sequence.items);

    return sequence.toOwnedSlice(allocator);
}
