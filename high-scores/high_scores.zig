const std = @import("std");

pub const HighScores = struct {
    scores: []const i32,
    high_scores: [3]i32,
    high_scores_len: usize,

    pub fn init(scores: []const i32) HighScores {
        var high_scores_len: usize = 0;
        var high_scores: [3]i32 = undefined;

        for (scores) |score| {
            var insert_at: usize = 0;

            while (insert_at < high_scores_len and score < high_scores[insert_at]) : (insert_at += 1) {}

            if (insert_at >= high_scores.len) continue;

            const new_len = @min(high_scores_len + 1, high_scores.len);
            var j = new_len - 1;

            while (j > insert_at) : (j -= 1) {
                high_scores[j] = high_scores[j - 1];
            }

            high_scores[insert_at] = score;
            high_scores_len = new_len;
        }
        return .{ .scores = scores, .high_scores = high_scores, .high_scores_len = high_scores_len };
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
        return self.high_scores[0..self.high_scores_len];
    }
};
