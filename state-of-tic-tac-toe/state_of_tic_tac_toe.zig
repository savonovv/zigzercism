pub const GameState = enum {
    win,
    draw,
    ongoing,
    impossible,
};

pub fn gameState(board: []const []const u8) GameState {
    var x_count: usize = 0;
    var o_count: usize = 0;

    const x_won = hasWon(board, 'X');
    const o_won = hasWon(board, 'O');

    for (board) |row| {
        for (row) |byte| {
            if (byte == 'X') x_count += 1;
            if (byte == 'O') o_count += 1;
        }
    }

    const valid_count = x_count == o_count or x_count == o_count + 1;
    if (!valid_count) return .impossible;
    if (x_won and o_count >= x_count) return .impossible;
    if (o_won and o_count != x_count) return .impossible;
    if (x_won or o_won) return .win;
    if (x_count + o_count == 9) return .draw;

    return .ongoing;
}

pub fn hasWon(board: []const []const u8, player: u8) bool {
    const size = board.len;
    var diagonal_up = true;
    var diagonal_down = true;
    for (0..size) |row| {
        diagonal_up = diagonal_up and board[size - 1 - row][row] == player;
        diagonal_down = diagonal_down and board[row][row] == player;
        var full_row = true;
        var full_col = true;
        for (0..size) |cell| {
            full_row = full_row and board[row][cell] == player;
            full_col = full_col and board[cell][row] == player;
        }

        if (full_row or full_col) return true;
    }

    if (diagonal_up or diagonal_down) return true;

    return false;
}
