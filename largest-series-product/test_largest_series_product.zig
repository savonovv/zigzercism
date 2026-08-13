const std = @import("std");
const testing = std.testing;

const largest_series_product = @import("largest_series_product.zig");

test "finds the largest product if span equals length" {
    const expected: u64 = 18;
    const actual = try largest_series_product.largestProduct("29", 2);
    try testing.expectEqual(expected, actual);
}

test "can find the largest product of 2 with numbers in order" {
    const expected: u64 = 72;
    const actual = try largest_series_product.largestProduct("0123456789", 2);
    try testing.expectEqual(expected, actual);
}

test "can find the largest product of 2" {
    const expected: u64 = 48;
    const actual = try largest_series_product.largestProduct("576802143", 2);
    try testing.expectEqual(expected, actual);
}

test "can find the largest product of 3 with numbers in order" {
    const expected: u64 = 504;
    const actual = try largest_series_product.largestProduct("0123456789", 3);
    try testing.expectEqual(expected, actual);
}

test "can find the largest product of 3" {
    const expected: u64 = 270;
    const actual = try largest_series_product.largestProduct("1027839564", 3);
    try testing.expectEqual(expected, actual);
}

test "can find the largest product of 5 with numbers in order" {
    const expected: u64 = 15120;
    const actual = try largest_series_product.largestProduct("0123456789", 5);
    try testing.expectEqual(expected, actual);
}

test "can get the largest product of a big number" {
    const expected: u64 = 23514624000;
    const actual = try largest_series_product.largestProduct("7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450", 13);
    try testing.expectEqual(expected, actual);
}

test "reports zero if the only digits are zero" {
    const expected: u64 = 0;
    const actual = try largest_series_product.largestProduct("0000", 2);
    try testing.expectEqual(expected, actual);
}

test "reports zero if all spans include zero" {
    const expected: u64 = 0;
    const actual = try largest_series_product.largestProduct("99099", 3);
    try testing.expectEqual(expected, actual);
}

test "rejects span longer than string length" {
    const actual = largest_series_product.largestProduct("123", 4);
    try testing.expectError(largest_series_product.SeriesError.InsufficientDigits, actual);
}

test "reports 1 for empty string and empty product (0 span)" {
    const expected: u64 = 1;
    const actual = try largest_series_product.largestProduct("", 0);
    try testing.expectEqual(expected, actual);
}

test "reports 1 for nonempty string and empty product (0 span)" {
    const expected: u64 = 1;
    const actual = try largest_series_product.largestProduct("123", 0);
    try testing.expectEqual(expected, actual);
}

test "rejects empty string and nonzero span" {
    const actual = largest_series_product.largestProduct("", 1);
    try testing.expectError(largest_series_product.SeriesError.InsufficientDigits, actual);
}

test "rejects invalid character in digits" {
    const actual = largest_series_product.largestProduct("1234a5", 2);
    try testing.expectError(largest_series_product.SeriesError.InvalidCharacter, actual);
}

test "rejects negative span" {
    const actual = largest_series_product.largestProduct("12345", -1);
    try testing.expectError(largest_series_product.SeriesError.NegativeSpan, actual);
}
