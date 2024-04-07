#!/usr/bin/env nu

let EDITOR = "vim"
let CLIP_CMD = "wl-copy"

def find_nixos [] {
    ls $"/home/($env.USER)/**/*"
        | filter {|f| $f.type == "dir" and ($f.name | str contains "nixos")}
        | first
        | get name
        | path expand
}

def hash_directory [path: directory] {
    ls $"($path)/**/*"
        | filter {|f| $f.type == "file"}
        | each {|f| open $f.name}
        | md5sum
}

def find_nix_error [err: string] {
    let parsed = ($err | grep "at /nix/store"
        | str trim
        | parse "at /nix/store/{_}/nixos/{path}:{line}:{col}")
    if ($parsed | is-empty) {
        null
    } else {
        $parsed | last
    }
}

def main [] {
    let nixos_dir = find_nixos
    cd $nixos_dir

    # Compute the hash of the config
    # before editing
    let pre_hash = hash_directory $nixos_dir

    # Open the config directory for editing
    ^$"($EDITOR)" $nixos_dir
    git add .

    # If none of the config files were changed abort
    if $pre_hash == (hash_directory $nixos_dir) {
        print "No changes made to config. Exiting..."
        exit 0;
    }

    # Otherwise continue updating the active config
    print "Checking flake..."
    mut res = (do -p {nix flake check} | complete)

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
        }
        ^$"($EDITOR)" $nixos_dir
        git add .
        print "Checking flake..."
        $res = (do -p {nix flake check} | complete)
    }

    # Format all the nix files
    nix-shell -p alejandra --run "alejandra ."
    git add .

    # Show final changes compared to last commit
    git diff -U0 HEAD ./*

    # Commit changes to git
    git commit -m (input "Commit message: ")

    let apply = (input "Apply Changes? Y/n: ")
    if ($apply | str upcase) == "Y" {
        sudo nixos-rebuild switch --flake .
    }

    let optimize = (input "Optimize nix store? Y/n: ")
    if ($optimize | str upcase) == "Y" {
        nix store optimise
    }
}
