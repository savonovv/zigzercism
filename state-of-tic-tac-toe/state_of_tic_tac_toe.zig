pub const GameState = enum {
    win,
    draw,
    ongoing,
    impossible,
};

pub fn gameState(board: []const []const u8) GameState {
    var x_count: usize = 0;
    var o_count: usize = 0;

    for (board) |row| {
        for (row) |byte| {
            if (byte == 'X') x_count += 1;
            if (byte == 'O') o_count += 1;
        }
    }
}

pub fn hasWon(board: []const []const u8, player: u8) bool {
    const size = board.len;
    for (0..size) |i| {
        var complete_row = true;
        var complete_column = true;

        for (0..size) |j| {
            complete_row = complete_row and board[i][j] == player;

            complete_column = complete_column and board[j][i] == player;
        }

        if (complete_row or complete_column) return true;
    }

    var falling_diagonal = true;
    var rising_diagonal = true;

    for (0..size) |i| {
        falling_diagonal = falling_diagonal and board[size - 1 - i][i] == player;

        rising_diagonal = rising_diagonal and board[i][size - 1 - i] == player;
    }

    return falling_diagonal or rising_diagonal;
}
