const std = @import("std");
const net = std.net;

pub fn main() anyerror!void {
    // std.log.info("All your codebase are belong to us.", .{});
    var options: net.StreamServer.Options = {
        kernel_backlog = 128;
        reuse_address = true;
    };
    const stream_server = net.StreamServer.init(options);
    defer stream_server.deinit();

    const addr = try net.Address.parseIp("127.0.0.1", 8080);
    stream_server.listen(addr);
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
