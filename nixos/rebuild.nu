#!/usr/bin/env nu

let EDITOR = "vim"
let CLIP_CMD = "wl-copy"

def find_nixos [] {
    ls ...(glob $"/home/($env.USER)/**/nixos/flake.nix")
        | filter {|f| $f.type == "file"}
        | first
        | get name
        | path expand
        | path dirname
}

def find_nix_error [err: string] {
    let parsed = ($err | grep "at /nix/store"
        | str trim
        | split row -r '\n'
        | str trim
        | last
        | parse "at /nix/store/{_}/nixos/{path}:{line}:{col}")
    echo $parsed
    if ($parsed | is-empty) {
        null
    } else {
        $parsed | last
    }
}

# Rebuild the nixos config
def main [
    --edit (-e) # Open default editor to fix the problem
] {
    let nixos_dir = find_nixos
    print $nixos_dir
    cd $nixos_dir

    # Open the config directory for editing
    if $edit {
        ^$"($EDITOR)" $nixos_dir
    }
    git add .

    # If none of the config files were changed abort
    if (do -i {|| git diff --quiet HEAD ./*} | complete).exit_code == 0 {
        print "No changes made to config. Exiting..."
        exit 0;
    }

    # Otherwise continue updating the active config
    print "Checking flake..."
    mut res = (do -i {nix flake check} | complete)

    while $res.exit_code != 0 {
        print ($res.stderr)

        # Check if we want to try fixing the problems we have
        let continue = (input "Edit to fix issues? Y/n: ")
        if ($continue | str upcase) == "N" {
            exit 0
        }

        let err = find_nix_error $res.stderr
        if $err != null and $EDITOR == "vim" {
            ^$"($EDITOR)" $"+($err.line)" $"($nixos_dir)/($err.path)"
        } else {
            ^$"($EDITOR)" $nixos_dir
        }
        git add .
        print "Checking flake..."
        $res = (do -i {nix flake check} | complete)
    }

    # Format all the nix files
    nix-shell -p alejandra --run "alejandra ."
    git add .

    # Show final changes compared to last commit
    git diff -U0 HEAD ./*

    let apply = (input "Apply Changes? Y/n: ")
    if ($apply | str upcase) == "Y" {
        sudo nixos-rebuild switch --flake .
    }

    let optimize = (input "Optimize nix store? Y/n: ")
    if ($optimize | str upcase) == "Y" {
        nix store optimise
    }
}
