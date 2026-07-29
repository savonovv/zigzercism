const std = @import("std");

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

pub fn classify(n: u64) Classification {
    std.debug.assert(n != 0);
    if (n == 1) return .deficient;

    var divisor: u64 = 1;
    var sum: u64 = 0;

    while (divisor <= n / divisor) : (divisor += 1) {
        if (n % divisor == 0) {
            if (divisor > n - sum) return .abundant;
            sum += divisor;
            const partner_divisor = n / divisor;
            if (divisor >= partner_divisor) break;
            if (partner_divisor != n) {
                if (partner_divisor > n - sum) return .abundant;
                sum += partner_divisor;
            }
        }
    }

    if (sum == n) return .perfect;
    if (sum > n) return .abundant;
    return .deficient;
}
