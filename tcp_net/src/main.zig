const std = @import("std");
const net = std.net;
const StreamServer = net.StreamServer;
const Address = net.Address;
const GeneralPurposeAllocator = std.heap.GeneralPurposeAllocator;
const print = std.debug.print;

pub const io_mode = .evented;

pub fn main() anyerror!void {
    var gpa = GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var stream_server = StreamServer.init(.{});
    defer stream_server.close();
    const addr = try net.Address.resolveIp("127.0.0.1", 8080);
    try stream_server.listen(addr);

    var connsList = std.ArrayList(StreamServer.Connection).init(allocator);
    defer connsList.deinit();

    while (true) {
        const connection = try stream_server.accept();
        try connsList.append(connection);
        try streamHandler(allocator, connsList.items, connection);
    }
}

fn streamHandler(allocator: std.mem.Allocator, list: []StreamServer.Connection, latest: StreamServer.Connection) !void {
    var Reader = latest.stream.reader();
    // std.math.maxInt(usize)
    var lines = try Reader.readAllAlloc(allocator, (1 << 20));
    var i: u3 = if (lines.len > 1) 1 else 0;

    while (i > 0) : (i = 0) {
        print("i = {any}:: \n{s} sent {s}\n", .{ i, latest.address, lines });
        for (list) |conn| {
            var writer = conn.stream.writer();

            if (!conn.address.eql(latest.address)) {
                try writer.print("\n{s} connected and said {s}\n", .{ conn.address, lines });
            }
        }
    }

    // for (list) |conn| {
    //     const stream = conn.stream;
    //     var Writer = stream.writer();

    //     if (lines.len > 0) print("\n{s} said {s}\n", .{ conn.address, lines });

    //     if (conn.address.eql(latest.address)) {
    //         try Writer.print("TCP connected on {}\n", .{conn.address});
    //     } else {
    //         try conn.stream.writer().print("\n{s} connected and said {s}\n", .{ conn.address, lines });
    //     }
    // }
}
