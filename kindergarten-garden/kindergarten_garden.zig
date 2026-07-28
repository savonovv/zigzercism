const std = @import("std");

pub const Plant = enum(u8) {
    clover = 'C',
    grass = 'G',
    radishes = 'R',
    violets = 'V',
};

pub const Students = enum(usize) {
    Alice = 0,
    Bob = 2,
    Charlie = 4,
    David = 6,
    Eve = 8,
    Fred = 10,
    Ginny = 12,
    Harriet = 14,
    Ileana = 16,
    Joseph = 18,
    Kincaid = 20,
    Larry = 22,
};

pub const PlantError = error{ StudentOutOfBound, NoSecondRow };

pub fn plants(diagram: []const u8, student: []const u8) PlantError![4]Plant {
    var result: [4]Plant = undefined;
    const student_enum = std.meta.stringToEnum(Students, student) orelse return PlantError.StudentOutOfBound;
    const student_index = @intFromEnum(student_enum);
    const row_width = std.mem.indexOfScalar(u8, diagram, '\n') orelse return PlantError.NoSecondRow;

    if (student_index + 1 >= row_width) return PlantError.StudentOutOfBound;

    const second_row_start = row_width + 1;

    for (0..2) |i| {
        result[i] = @enumFromInt(diagram[i + student_index]);
        result[i + 2] = @enumFromInt(diagram[i + student_index + second_row_start]);
    }

    return result;
}
