const std = @import("std");

pub const QueenError = error{
    InitializationFailure,
};

pub const Queen = struct {
    row: i8,
    col: i8,

    pub fn init(row: i8, col: i8) QueenError!Queen {
        if (row >= 0 and row <= 7 and col >= 0 and col <= 7) {
            return .{ .row = row, .col = col };
        }
        return QueenError.InitializationFailure;
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        if (self.col == other.col and self.row == other.row) return false;
        if (self.col == other.col or self.row == other.row) return true;
        if (@abs(self.row - other.row) == @abs(self.col - other.col)) return true;

        return false;
    }
};
