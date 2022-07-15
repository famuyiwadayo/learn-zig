const std = @import("std");
const log = std.log;

const constant: i32 = 5; // signed 32-bit constant
var variable: u32 = 5000; // unsigned 32-bit variable

// @as performs an explicit type coercion
const inferred_constant = @as(i32, 5);
var inferred_variable = @as(u32, 5000);

pub fn main() anyerror!void {
    var a: u8 = 'b';
    a = a - 32;


    log.info("Hello, {s} {}!", .{
        "Dayo", a
    });
}
