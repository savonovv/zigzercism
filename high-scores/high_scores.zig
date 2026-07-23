const std = @import("std");

pub const HighScores = struct {
    // This struct, as well as its fields and methods, needs to be implemented.
    scores: []const i32,

    pub fn init(scores: []const i32) HighScores {
        return .{ .scores = scores };
    }

    pub fn latest(self: *const HighScores) ?i32 {
        if (self.scores.len == 0) return null;
        return self.scores[self.scores.len - 1];
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        if (self.scores.len == 0) return null;
        return std.mem.max(i32, self.scores);
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        const size_of_slice = @max(3, self.scores.len);

        const result = &[size_of_slice].{};
        var scores = self.scores;
        for (scores) |score| {
            result[0]
        }
        return result;
    }
};
