pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();
        // Please implement the doubly linked `Node` (replacing each `void`).
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
            fn isTail(node: *Node) bool {
                return node.next == null;
            }
        };

        // Please implement the fields of the linked list (replacing each `void`).
        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        // Please implement the below methods.
        // You need to add the parameters to each method.

        pub fn push(self: *Self, node: *Node) void {
            if (self.len == 0) {
                node.prev = null;
                node.next = null;
                self.first = node;
                self.last = node;
            } else {
                const old_last_node = self.last;
                old_last_node.?.next = node;
                node.prev = old_last_node;
                node.next = null;
                self.last = node;
            }

            self.len += 1;
        }

        pub fn pop(self: *Self) ?*Node {
            const popped_node = self.last;
            if (popped_node.?.prev == null) {
                self.first = null;
                self.last = null;
            } else {
                self.last = popped_node.?.prev;
                self.last.?.next = null;
            }

            self.len -= 1;

            popped_node.?.prev = null;
            popped_node.?.next = null;
            return popped_node;
        }

        pub fn shift(self: *Self) ?*Node {
            const shifted_node = self.first;
            if (shifted_node.?.next == null) {
                self.first = null;
                self.last = null;
            } else {
                self.first = shifted_node.?.next;
                self.first.?.prev = null;
            }

            self.len -= 1;

            shifted_node.?.prev = null;
            shifted_node.?.next = null;
            return shifted_node;
        }

        pub fn unshift(self: *Self, node: *Node) void {
            if (self.len == 0) {
                node.prev = null;
                node.next = null;
                self.first = node;
                self.last = node;
            } else {
                const old_first_node = self.first;
                old_first_node.?.prev = node;
                node.prev = null;
                node.next = old_first_node;
                self.first = node;
            }

            self.len += 1;
        }

        pub fn delete(self: *Self, node: *Node) void {
            var i: usize = 0;
            var current_node = self.first;

            while (i < self.len) : (i += 1) {
                if (current_node == node) {
                    if (self.len == 1) {
                        self.first = null;
                        self.last = null;
                    } else if (current_node == self.first) {
                        var new_first = current_node.?.next;
                        new_first.?.prev = null;
                        self.first = new_first;
                    } else if (current_node.?.isTail()) {
                        var new_last = current_node.?.prev;
                        new_last.?.next = null;
                        self.last = new_last;
                    } else {
                        var prev = current_node.?.prev;
                        var next = current_node.?.next;
                        prev.?.next = next;
                        next.?.prev = prev;
                    }
                    self.len -= 1;

                    return;
                } else if (!current_node.?.isTail()) {
                    current_node = current_node.?.next;
                } else return;
            }
        }
    };
}
