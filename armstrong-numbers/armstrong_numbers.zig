const std = @import("std");
pub fn isArmstrongNumber(num: u128) bool {
    var number_of_digits: u8 = 0;
    var temp_num = num;
    var result: u128 = 0;
    while (temp_num > 0) : (temp_num /= 10) {
        number_of_digits += 1;
    }

    var changable_num = num;
    while (changable_num > 0) : (changable_num /= 10) {
        result += changable_num % 10 ^ number_of_digits;
    }
    return (result == num);
}
