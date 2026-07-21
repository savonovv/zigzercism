pub const Coordinate = struct {
    // This struct, as well as its fields and methods, needs to be implemented.
    x: f32,
    y: f32,

    const outer_radius = 10;
    const mid_radius = 5;
    const inner_radius = 1;

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return .{ .x = x_coord, .y = y_coord };
    }
    pub fn score(self: Coordinate) usize {
        const squared_sides = self.x * self.x + self.y * self.y;

        if (squared_sides > outer_radius * outer_radius) return 0;
        if (squared_sides > mid_radius * mid_radius) return 1;
        if (squared_sides > inner_radius * inner_radius) return 5;
        return 10;
    }
};
