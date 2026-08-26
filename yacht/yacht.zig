const std = @import("std");
const mem = std.mem;

pub const Category = enum {
    ones,
    twos,
    threes,
    fours,
    fives,
    sixes,
    full_house,
    four_of_a_kind,
    little_straight,
    big_straight,
    choice,
    yacht,
};

pub fn score(dice: [5]u3, category: Category) u32 {
    var result: u32 = 0;

    var sorted_dice = dice;
    std.mem.sort(u3, sorted_dice[0..], {}, std.sort.asc(u3));

    var current = sorted_dice[0];
    var all_different = true;

    for (sorted_dice, 0..) |die, i| {
        switch (category) {
            .ones => {
                if (die == 1) result += 1;
            },
            .twos => {
                if (die == 2) result += 2;
            },
            .threes => {
                if (die == 3) result += 3;
            },
            .fours => {
                if (die == 4) result += 4;
            },
            .fives => {
                if (die == 5) result += 5;
            },
            .sixes => {
                if (die == 6) result += 6;
            },
            .full_house => {},
            .four_of_a_kind, .little_straight, .big_straight, .choice, .yacht => {},
        }
    }

    return result;
}
