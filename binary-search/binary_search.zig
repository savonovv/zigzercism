pub fn binarySearch(comptime T: type, target: T, items: []const T) ?usize {
    var left_bound: usize = 0;
    var right_bound: usize = items.len;

    while (left_bound < right_bound) {
        const target_index = left_bound + (right_bound - left_bound) / 2;
        if (items[target_index] < target) {
            left_bound = target_index + 1;
        } else if (items[target_index] > target) {
            right_bound = target_index;
        } else {
            return target_index;
        }
    }

    return null;
}
