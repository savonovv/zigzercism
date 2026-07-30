const std = @import("std");
const mem = std.mem;

pub const TranslationError = error{
    InvalidCodon,
};

pub const Protein = enum {
    methionine,
    phenylalanine,
    leucine,
    serine,
    tyrosine,
    cysteine,
    tryptophan,
};

pub fn proteins(allocator: mem.Allocator, strand: []const u8) (mem.Allocator.Error || TranslationError)![]Protein {
    var found_proteins: std.ArrayList(Protein) = .empty;
    errdefer found_proteins.deinit(allocator);

    var current_i: usize = 0;
    var stopped = false;

    while (current_i + 3 <= strand.len) : (current_i += 3) {
        const protein = (try translateProtein(strand[current_i..][0..3].*)) orelse {
            stopped = true;
            break;
        };

        try found_proteins.append(allocator, protein);
    }

    if (current_i != strand.len and !stopped) return TranslationError.InvalidCodon;

    return found_proteins.toOwnedSlice(allocator);
}

pub fn translateProtein(strand: [3]u8) TranslationError!?Protein {
    return switch (codonKey(strand)) {
        codonKey("AUG".*) => .methionine,
        codonKey("UUU".*), codonKey("UUC".*) => .phenylalanine,
        codonKey("UUA".*), codonKey("UUG".*) => .leucine,
        codonKey("UCU".*), codonKey("UCC".*), codonKey("UCA".*), codonKey("UCG".*) => .serine,
        codonKey("UAU".*), codonKey("UAC".*) => .tyrosine,
        codonKey("UGU".*), codonKey("UGC".*) => .cysteine,
        codonKey("UGG".*) => .tryptophan,
        codonKey("UAA".*), codonKey("UAG".*), codonKey("UGA".*) => null,
        else => TranslationError.InvalidCodon,
    };
}

pub fn codonKey(codon: [3]u8) u24 {
    return (@as(u24, codon[0]) << 16) | (@as(u24, codon[1]) << 8) | (@as(u24, codon[2]));
}
