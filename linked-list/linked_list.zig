pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        head: ?*Node = null,
        tail: ?*Node = null,
        len: usize = 0,

        pub fn push(self: *Self, node: *Node) void {
            if (self.tail) |tail| {
                tail.next = node;
                node.prev = tail;
            } else {
                self.head = node;
                node.prev = null;
            }

            node.next = null;
            self.tail = node;
            self.len += 1;
        }

        pub fn pop(self: *Self) ?*Node {
            const popped_node = self.tail;
            if (popped_node.?.prev == null) {
                self.head = null;
                self.tail = null;
            } else {
                self.tail = popped_node.?.prev;
                self.tail.?.next = null;
            }

            self.len -= 1;

            popped_node.?.prev = null;
            popped_node.?.next = null;
            return popped_node;
        }

        pub fn unshift(self: *Self, node: *Node) void {
            if (self.head) |head| {
                head.prev = node;
                node.next = head;
            } else {
                self.tail = node;
                node.next = null;
            }

            node.prev = null;
            self.head = node;
            self.len += 1;
        }

        pub fn shift(self: *Self) ?*Node {
            const shifted_node = self.head;
            if (shifted_node.?.next == null) {
                self.head = null;
                self.tail = null;
            } else {
                self.head = shifted_node.?.next;
                self.head.?.prev = null;
            }

            self.len -= 1;

            shifted_node.?.prev = null;
            shifted_node.?.next = null;
            return shifted_node;
        }

        pub fn delete(self: *Self, node: *Node) void {
            var current_node = self.head;

            while (current_node) |cnode| : (current_node = cnode.next) {
                if (cnode != node) continue;
                if (cnode == self.head) self.head = cnode.next;
                if (cnode == self.tail) self.tail = cnode.prev;
                if (cnode.prev) |prev| prev.next = cnode.next;
                if (cnode.next) |next| next.prev = cnode.prev;
                self.len -= 1;
                return;
            }
        }
    };
}
