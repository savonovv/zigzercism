pub fn primes(buffer: []u32, limit: u12) []u32 {
    var prime_index_map = [_]bool{true} ** 4096;

    var candidate: usize = 2;
    const end: usize = @intCast(limit);

    while (candidate <= end / candidate) : (candidate += 1) {
        if (prime_index_map[candidate]) {
            var multiple = candidate * candidate;
            while (multiple <= end) : (multiple += candidate) {
                prime_index_map[multiple] = false;
            }
        }
    }

    var composing_index: u32 = 2;

    var i: usize = 0;
    while (composing_index <= end) : (composing_index += 1) {
        if (prime_index_map[composing_index]) {
            buffer[i] = composing_index;
            i += 1;
        }
    }

    return buffer[0..i];
}
