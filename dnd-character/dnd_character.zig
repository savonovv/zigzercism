const std = @import("std");

var rng = std.Random.DefaultPrng.init(101);

pub fn modifier(score: i8) i8 {
    return @divFloor((score - 10), 2);
}

pub fn ability() i8 {
    var sum: i8 = 0;
    var smallest_number: i8 = 0;

    for (0..4) |i| {
        const num = rng.random().intRangeAtMost(i8, 1, 6);
        if (i == 0) smallest_number = num;
        sum += num;
        if (smallest_number > num) smallest_number = num;
    }

    return sum - smallest_number;
}

pub const Character = struct {
    strength: i8,
    dexterity: i8,
    constitution: i8,
    intelligence: i8,
    wisdom: i8,
    charisma: i8,
    hitpoints: i8,

    pub fn init() Character {
        const constitution = ability();

        return .{
            .strength = ability(),
            .dexterity = ability(),
            .constitution = constitution,
            .intelligence = ability(),
            .wisdom = ability(),
            .charisma = ability(),
            .hitpoints = 10 + modifier(constitution),
        };
    }
};
