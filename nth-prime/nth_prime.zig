const std = @import("std");
const mem = std.mem;

pub fn prime(allocator: mem.Allocator, number: usize) !usize {
    std.debug.assert(number > 0);

    var primes: std.ArrayList(usize) = .empty;
    defer primes.deinit(allocator);

    var candidate: usize = 2;
    while (primes.items.len < number) {
        var is_prime = true;
        for (primes.items) |divisor| {
            if (divisor > candidate / divisor) break;
            if (candidate % divisor == 0) {
                is_prime = false;
                break;
            }
        }

        if (is_prime) try primes.append(allocator, candidate);
        candidate = if (candidate == 2) 3 else candidate + 2;
    }

    return primes.items[number - 1];
}
