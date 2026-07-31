const std = @import("std");
const mem = std.mem;

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    var space_input_counter: u3 = 0;
    for (s) |char| {
        if (std.ascii.isAlphanumeric(char)) {
            if (space_input_counter == 5) {
                space_input_counter = 0;
                try result.append(allocator, ' ');
            }
            space_input_counter += 1;
        }
        if (std.ascii.isDigit(char)) {
            try result.append(allocator, char);
            continue;
        }
        if (std.ascii.isAlphabetic(char)) {
            const inner = std.ascii.toLower(char);
            const calculated_index = inner - 'a';
            const shifted_char = 'z' - calculated_index;
            try result.append(allocator, shifted_char);
        }
    }

    return try result.toOwnedSlice(allocator);
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    for (s) |char| {
        if (std.ascii.isDigit(char)) try result.append(allocator, char);
        if (std.ascii.isAlphabetic(char)) {
            const inner = std.ascii.toLower(char);
            const calculated_index = inner - 'a';
            const shifted_char = 'z' - calculated_index;
            try result.append(allocator, shifted_char);
        }
    }

    return try result.toOwnedSlice(allocator);
}
