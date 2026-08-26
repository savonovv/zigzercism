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

    var counts: [7]u3 = @splat(0);

    for (sorted_dice) |die| {
        counts[die] += 1;
    }

    var current: u3 = 0;
    var sum: u32 = 0;
    var all_different = true;

    for (sorted_dice, 0..) |die, i| {
        const last = i == sorted_dice.len - 1;
        all_different = all_different and current != die;
        sum += die;

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
            .full_house => {
                if (last and mem.indexOfScalar(u3, counts[0..], 3) != null and mem.indexOfScalar(u3, counts[0..], 2) != null) result += sum;
            },
            .four_of_a_kind => {
                if (last and mem.indexOfScalar(u3, counts[0..], 4) != null) {
                    if (mem.indexOfScalar(u3, counts[0..], 1)) |lonely_index| {
                        const lonely_value: u32 = @intCast(lonely_index);
                        result += sum - lonely_value;
                    }
                }
                if (last and mem.indexOfScalar(u3, counts[0..], 5) != null) {
                    if (mem.indexOfScalar(u3, counts[0..], 5)) |lonely_index| {
                        const lonely_value: u32 = @intCast(lonely_index);
                        result += sum - lonely_value;
                    }
                }
            },
            .little_straight => {
                if (last and all_different and sum == 15) result += 30;
            },
            .big_straight => {
                if (last and all_different and sum == 20) result += 30;
            },
            .choice => {
                if (last) result += sum;
            },
            .yacht => {
                if (last and mem.indexOfScalar(u3, counts[0..], 5) != null) result += 50;
            },
        }
        current = die;
    }

    return result;
}
