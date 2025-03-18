## Odin Scan
A simple package to scan a formated string into variables.\
\
For example suppose you want to scan a line in a wavefront object file into variables you can simply do this.
```odin
my_string := "v 0.5 0.7 0.9"
v : [3]f32
scan_ok := scan(my_string, "v ", &v[0], " ", &v[1], " ", &v[2])
assert(scan_ok)
assert(v == [3]f32{0.5, 0.7, 0.9})
```
