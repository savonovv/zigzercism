const std = @import("std");

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

pub fn classify(n: u64) Classification {
    std.debug.assert(n != 0);

    var divisor: u64 = 1;
    var parnter_divisor = n;

    var sum: u64 = 0;

    while (divisor <= n / divisor) : (divisor += 1) {
        if (n % divisor == 0) {
            sum += divisor + parnter_divisor;
            if (divisor > parnter_divisor) break;
            parnter_divisor = n / divisor;
            sum += divisor + parnter_divisor;
        }
        if (sum > n) return .abundant;
    }

    if (sum == n) return .perfect;
    if (sum > n) return .abundant;
    return .deficient;
}
