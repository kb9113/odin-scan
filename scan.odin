package scan
import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:c/libc"
import "core:math"
import "core:io"
import "base:runtime"
import "core:bufio"

read_int_string_at_start :: proc(curr : string) -> (string, bool)
{
    ans := "";
    for i in 0..<len(curr)
    {
        if ('0' <= curr[i] && curr[i] <= '9') || (i == 0 && curr[i] == '-')
        {
            ans = curr[0:(i + 1)]
        }
        else
        {
            break
        }
    }
    if ans == ""
    {
        return "", false
    }
    return ans, true
}

read_float_string_at_start :: proc(curr : string) -> (string, bool)
{
    ans := "";
    for i in 0..<len(curr)
    {
        if ('0' <= curr[i] && curr[i] <= '9') || (i == 0 && curr[i] == '-') || (curr[i] == '.')
        {
            ans = curr[0:(i + 1)]
        }
        else
        {
            break
        }
    }
    if ans == ""
    {
        return "", false
    }
    return ans, true
}

scan :: proc(source : string, args: ..any) -> (ok : bool)
{
    curr := source
    ok = false
    for arg in args
    {
        switch v in arg
        {
            case string:
            {
                if strings.starts_with(curr, v)
                {
                    curr = curr[len(v):]
                    continue
                }
                else
                {
                    return false
                }
            }
            case ^u64:
            {
                number_string := read_int_string_at_start(curr) or_return
                curr = curr[len(number_string):]
                value_parsed := strconv.parse_u64(number_string) or_return
                v^ = value_parsed
            }
            case ^u32:
            {
                number_string := read_int_string_at_start(curr) or_return
                curr = curr[len(number_string):]
                value_parsed := strconv.parse_u64(number_string) or_return
                if !(value_parsed < u64(libc.UINT32_MAX)) { return false }
                v^ = u32(value_parsed)
            }
            case ^u16:
            {
                number_string := read_int_string_at_start(curr) or_return
                curr = curr[len(number_string):]
                value_parsed := strconv.parse_u64(number_string) or_return
                if !(value_parsed < u64(libc.UINT16_MAX)) { return false }
                v^ = u16(value_parsed)
            }
            case ^u8:
            {
                number_string := read_int_string_at_start(curr) or_return
                curr = curr[len(number_string):]
                value_parsed := strconv.parse_u64(number_string) or_return
                if !(value_parsed < u64(libc.UINT8_MAX)) { return false }
                v^ = u8(value_parsed)
            }
            case ^i64:
            {
                number_string := read_int_string_at_start(curr) or_return
                curr = curr[len(number_string):]
                value_parsed := strconv.parse_i64(number_string) or_return
                v^ = value_parsed
            }
            case ^i32:
            {
                number_string := read_int_string_at_start(curr) or_return
                curr = curr[len(number_string):]
                value_parsed := strconv.parse_i64(number_string) or_return
                if !(i64(libc.INT32_MIN) < value_parsed && value_parsed < i64(libc.INT32_MAX)) { return false }
                v^ = i32(value_parsed)
            }
            case ^i16:
            {
                number_string := read_int_string_at_start(curr) or_return
                curr = curr[len(number_string):]
                value_parsed := strconv.parse_i64(number_string) or_return
                if !(i64(libc.INT16_MIN) < value_parsed && value_parsed < i64(libc.INT16_MAX)) { return false }
                v^ = i16(value_parsed)
            }
            case ^i8:
            {
                number_string := read_int_string_at_start(curr) or_return
                curr = curr[len(number_string):]
                value_parsed := strconv.parse_i64(number_string) or_return
                if !(i64(libc.INT8_MIN) < value_parsed && value_parsed < i64(libc.INT8_MAX)) { return false }
                v^ = i8(value_parsed)
            }
            case ^f64:
            {
                number_string := read_float_string_at_start(curr) or_return
                curr = curr[len(number_string):]
                value_parsed := strconv.parse_f64(number_string) or_return
                v^ = value_parsed
            }
            case ^f32:
            {
                number_string := read_float_string_at_start(curr) or_return
                curr = curr[len(number_string):]
                value_parsed := strconv.parse_f64(number_string) or_return
                v^ = f32(value_parsed)
            }
            case ^f16:
            {
                number_string := read_float_string_at_start(curr) or_return
                curr = curr[len(number_string):]
                value_parsed := strconv.parse_f64(number_string) or_return
                v^ = f16(value_parsed)
            }
            case ^string:
            {
                v^ = curr
                curr = ""
            }
            case:
            {
                return false
            }
        }
    }
    if curr != ""
    {
        return false
    }
    else
    {
        return true
    }
}
