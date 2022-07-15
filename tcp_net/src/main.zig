const std = @import("std");
const net = std.net;
const StreamServer = net.StreamServer;
const Address = net.Address;
const GeneralPurposeAllocator = std.heap.GeneralPurposeAllocator;

pub const io_mode = .evented;

pub fn main() anyerror!void {
    var gpa = GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var stream_server = StreamServer.init(.{});
    defer stream_server.close();
    const addr = try net.Address.resolveIp("127.0.0.1", 8080);
    try stream_server.listen(addr);

    // const allocator =

    while (true) {
        const connection = try stream_server.accept();
        try streamHandler(allocator, connection.stream, connection.address);
    }
}

fn streamHandler(allocator: std.mem.Allocator, stream: net.Stream, addr: Address) !void {
    defer stream.close();
    var Writer = stream.writer();
    try Writer.print("TCP connected on {}", .{addr});
}
