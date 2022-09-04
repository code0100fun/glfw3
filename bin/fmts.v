import os

const (
    vexe = $if windows {
        'v.bat'
    } $else {
        'v'
    }
    tab    = '\t'
    spaces = '    '
)

fn main() {
    args := os.args_after('fmt')
    if args.len == 1 {
        println('Usage: v run fmt.v file.v')
        return
    }
    file := args[1]

    if !os.is_file(file) {
        println('Invalid file: $file')
        return
    }

    res := os.execute('$vexe fmt $file')

    if res.exit_code != 0 {
        println(res.output)
        return
    }

    tab_formatted := res.output
    space_formatted := tab_formatted.replace(tab, spaces)
    os.write_file(file, space_formatted) or { panic(err) }
}
