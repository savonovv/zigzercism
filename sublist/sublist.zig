const std = @import("std");

pub const Relation = enum {
    equal,
    sublist,
    superlist,
    unequal,
};

pub fn compare(list_one: []const i32, list_two: []const i32) Relation {
    if (list_one.len == list_two.len) {
        if (std.mem.eql(i32, list_one, list_two)) return .equal else return .unequal;
    }

    var sublist_candidate: []const i32 = undefined;
    var superlist_candidate: []const i32 = undefined;

    if (list_one.len > list_two.len) {
        sublist_candidate = list_two;
        superlist_candidate = list_one;
    } else {
        sublist_candidate = list_one;
        superlist_candidate = list_two;
    }

    if (std.mem.find(i32, superlist_candidate, sublist_candidate) != null) {
        if (list_one.len > list_two.len) return .superlist;
        return .sublist;
    }

    return .unequal;
}
