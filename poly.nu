#!/usr/bin/env nu

# Polyglot script which can do many different things
# some of the functionality is broken out into seperate scripts
def main [] {}

# Run the nixos rebuild script
def "main rebuild" [
    --no-edit (-e) # Skip editing the config and just check
] {
    let config_dir = find_poly_nu_dir
    let cmd = $"($config_dir)/nixos/rebuild.nu"
    if $no_edit {
        ^$cmd --no-edit
    } else {
        ^$cmd
    }
}

def "main link" [] {
    let config_dir = find_poly_nu_dir
    let dotconfig_dir = $"/home/($env.USER)/.config"

    ls $config_dir
        | filter {|f| $f.type == "dir" and $f.name !~ "nixos"}
        | each {|f| {name: ($f.name | path basename), from: $f.name, to: ($dotconfig_dir | path join ($f.name | path basename))}}
        | filter {|l| ($l.to | path type) != "symlink"}
        | each {|link|
        # Now for each config that is not setup ask to activate it
        let activate = (input $"Link: ($link.name)? [Y/n] ")
        if ($activate | str upcase) == "Y" {
            # Check that stuff doesn't already exist
            let continue = if ($link.to | path exists) {
                let res = (input $"`($link.to)` exists creating this link will first delete the existing contents continue? [Y/n] ")
                ($res | str upcase) == "Y"
            } else {
                true
            }
            if $continue {
                do -i {|| rm -r $link.to} # Delete if it exists
                ln -s $link.from $link.to
            }
        }
    }
    null
}

# Find the location of this script in the user's home directory
def find_poly_nu_dir [] {
    ls $"/home/($env.USER)/**/*"
        | filter {|f| $f.type == "file" and ($f.name | str ends-with "poly.nu")}
        | first
        | get name
        | path expand
        | path dirname
}
