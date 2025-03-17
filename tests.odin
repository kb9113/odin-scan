package scan

import "core:testing"

@(test)
test1 :: proc(t : ^testing.T)
{
    my_string := "hello 1234 0.54"
    u : u32
    f : f32
    scan_ok := scan(my_string, "hello ", &u, " ", &f)
    testing.expect_value(t, scan_ok, true)
    testing.expect_value(t, u, 1234)
    testing.expect_value(t, f, 0.54)
}

@(test)
test2 :: proc(t : ^testing.T)
{
    my_string := "hello 0.123 0.54"
    u : u32
    f : f32
    scan_ok := scan(my_string, "hello ", &u, " ", &f)
    testing.expect_value(t, scan_ok, false)
}

@(test)
test3 :: proc(t : ^testing.T)
{
    my_string := "hello 0.123 hello0.54"
    f1 : f32
    f2 : f32
    scan_ok := scan(my_string, "hello ", &f1, " hello", &f2)
    testing.expect_value(t, scan_ok, true)
    testing.expect_value(t, f1, 0.123)
    testing.expect_value(t, f2, 0.54)
}

@(test)
test4 :: proc(t : ^testing.T)
{
    my_string := "v 0.5 0.7 0.9"
    v : [3]f32
    scan_ok := scan(my_string, "v ", &v[0], " ", &v[1], " ", &v[2])
    testing.expect_value(t, scan_ok, true)
    testing.expect_value(t, v, [3]f32{0.5, 0.7, 0.9})
}
