pub fn squareRoot(radicand: usize) usize {
    var i: usize = 1;
    while (i < radicand / i) : (i += 1) {}
    return i;
}
