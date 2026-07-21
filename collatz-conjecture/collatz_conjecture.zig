// Please implement the `ComputationError.IllegalArgument` error.
pub const ComputationError = error{IllegalArgument};

pub fn steps(number: usize) ComputationError!usize {
    if (number == 0) return ComputationError.IllegalArgument;
    var result: usize = 0;
    var num_copy = number;
    while (num_copy > 1) {
        if (num_copy % 2 == 0) num_copy /= 2 else num_copy = num_copy * 3 + 1;
        result +=1;
    }
    return result;
}
