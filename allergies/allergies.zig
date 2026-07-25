const std = @import("std");
const EnumSet = std.EnumSet;

pub const Allergen = enum {
    eggs,
    peanuts,
    shellfish,
    strawberries,
    tomatoes,
    chocolate,
    pollen,
    cats,
};

pub fn isAllergicTo(score: u8, allergen: Allergen) bool {
    const mask: u8 = switch (allergen) {
        .eggs => 1,
        .peanuts => 2,
        .shellfish => 4,
        .strawberries => 8,
        .tomatoes => 16,
        .chocolate => 32,
        .pollen => 64,
        .cats => 128,
    };

    return score & mask != 0;
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    const normalized_score: u8 = @truncate(score);
    var set: EnumSet(Allergen) = .empty;

    for (std.enums.values(Allergen)) |allergen| {
        if (isAllergicTo(normalized_score, allergen)) set.insert(allergen);
    }

    return set;
}
