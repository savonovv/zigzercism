const std = @import("std");

pub const HighScores = struct {
    // This struct, as well as its fields and methods, needs to be implemented.
    scores: []const i32,
    high_scores: [3]i32,
    hish_scores_len: usize,

    pub fn init(scores: []const i32) HighScores {
        var high_scores_len: usize = 0;
        var high_scores: [3]i32 = undefined;
        const MAX_HIGH_SCORE_LEN = 3;

        var i: usize = 0;
        for (scores) |score| {
            while (i < MAX_HIGH_SCORE_LEN) : (i += 1) {
                if (score > high_scores[i]) {
                    if (i + 1 < high_scores_len) {
                        var j = high_scores_len - 1;
                        while (j > i) : (j -= 1) {
                            high_scores[j] = high_scores[j - 1];
                        }
                        high_scores[i] = score;
                        high_scores_len += 1;
                        break;
                    }
                    high_scores[i] = score;
                    high_scores_len += 1;
                }
            }
            i = 0;
        }
        return .{ .scores = scores, .high_scores = high_scores, .hish_scores_len = high_scores_len };
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
        return self.high_scores[0..self.hish_scores_len];
    }
};
