const std = @import("std");
const mem = std.mem;

/// Returns the set of strings in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var result = std.BufSet.init(allocator);
    errdefer result.deinit();

    const word_counts = getWordCounts(word);
    for (candidates) |candidate| {
        const candidate_counts = getWordCounts(candidate);
        const same_counts = std.mem.eql(usize, word_counts[0..], candidate_counts[0..]);
        const equal_words = std.ascii.eqlIgnoreCase(word, candidate);
        if (same_counts and !equal_words) {
            try result.insert(candidate);
        }
    }

    return result;
}

pub fn getWordCounts(word: []const u8) [26]usize {
    var counts = [_]usize{0} ** 26;

    for (word) |char| {
        const index: usize = std.ascii.toLower(char) - 'a';
        counts[index] += 1;
    }

    return counts;
}
