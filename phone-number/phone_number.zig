pub fn clean(phrase: []const u8) ?[10]u8 {
    var buffer: [10]u8 = undefined;

    var digits_found: usize = 0;
    var got_prefix: bool = false;
    var plus_pending: bool = false;

    for (phrase) |char| {
        switch (char) {
            '0'...'9' => {
                if (digits_found > 9) return null;

                if (plus_pending) {
                    if (char != '1') return null;
                    plus_pending = false;
                    got_prefix = true;
                    continue;
                }

                if (char == '1' and digits_found == 0 and !got_prefix) {
                    got_prefix = true;
                    continue;
                }

                if ((char == '0' or char == '1') and (digits_found == 0 or digits_found == 3)) return null;

                buffer[digits_found] = char;
                digits_found += 1;
            },
            '+' => {
                if (digits_found > 0 or got_prefix or plus_pending) return null;
                plus_pending = true;
            },
            '-', '.', ' ', '(', ')' => continue,
            else => return null,
        }
    }

    if (digits_found != 10) return null;

    return buffer;
}
