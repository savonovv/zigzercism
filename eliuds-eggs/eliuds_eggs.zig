pub fn eggCount(number: usize) usize {
    var result: usize = 0;

    var tmp_num = number;

    while (tmp_num > 0) : (tmp_num >>= 1) {
        result += tmp_num & 1;
    }

    return result;
}
