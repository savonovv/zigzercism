// | Planet  | Orbital period in Earth Years |
// | ------- | ----------------------------- |
// | Mercury | 0.2408467                     |
// | Venus   | 0.61519726                    |
// | Earth   | 1.0                           |
// | Mars    | 1.8808158                     |
// | Jupiter | 11.862615                     |
// | Saturn  | 29.447498                     |
// | Uranus  | 84.016846                     |
// | Neptune | 164.79132                     |
const std = @import("std");
const seconds_in_year = 31_557_600;
pub const Planet = enum {
    mercury,
    venus,
    earth,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,

    pub fn age(self: Planet, seconds: usize) f64 {
        const seconds_float: f64 = @floatFromInt(seconds);
        switch (self) {
            Planet.mercury => return seconds_float / seconds_in_year / 0.2408467,
            Planet.venus => return seconds_float / seconds_in_year / 0.61519726,
            Planet.earth => return seconds_float / seconds_in_year / 1.0,
            Planet.mars => return seconds_float / seconds_in_year / 1.8808158,
            Planet.jupiter => return seconds_float / seconds_in_year / 11.862615,
            Planet.saturn => return seconds_float / seconds_in_year / 29.447498,
            Planet.uranus => return seconds_float / seconds_in_year / 84.016846,
            Planet.neptune => return seconds_float / seconds_in_year / 164.79132,
        }
    }
};
