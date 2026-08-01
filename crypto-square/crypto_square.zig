const std = @import("std");
const mem = std.mem;

pub fn ciphertext(allocator: mem.Allocator, plaintext: []const u8) mem.Allocator.Error![]u8 {
    var ciphered_text: std.ArrayList(u8) = .empty;
    errdefer ciphered_text.deinit(allocator);
    var columns: usize = 1;
    var rows: usize = 1;

    var normalized_text: std.ArrayList(u8) = .empty;
    defer normalized_text.deinit(allocator);

    for (plaintext) |char| {
        if (std.ascii.isAlphanumeric(char)) try normalized_text.append(allocator, std.ascii.toLower(char));
    }

    const trimmed_len = normalized_text.items.len;
    if (trimmed_len == 0) return ciphered_text.toOwnedSlice(allocator);

    while (columns * rows < trimmed_len) {
        columns += 1;
        if (columns * rows >= trimmed_len) break;
        rows += 1;
    }

    for (0..columns) |c| {
        for (0..rows) |r| {
            const found_index = c + (r * columns);
            if (found_index >= trimmed_len) {
                try ciphered_text.append(allocator, ' ');
                continue;
            }
            try ciphered_text.append(allocator, normalized_text.items[found_index]);
        }
        if (c + 1 < columns) try ciphered_text.append(allocator, ' ');
    }

    return ciphered_text.toOwnedSlice(allocator);
}
