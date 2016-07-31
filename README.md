# my dotfiles
## dotfile organization forked from [holmans dotfiles](https://github.com/holman/dotfiles.git)

If you're interested in the philosophy behind why projects like these are
awesome, you might want to [read his post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

If you plan on using his system yourself, head over to his
[repository](https://github.com/holman/dotfiles.git) and fork it
to have a clean start.



## install

Run this:

```sh
cd
git clone --recursive https://github.com/benutzer193/.dotfiles.git ~/Dotfiles
cd Dotfiles
script/bootstrap
```

This will symlink the appropriate files in `Dotfiles` to your home directory.
Everything is configured and tweaked within `~/Dotfiles`.

I don't recommend to hide the Dotfiles like `~/.dotfiles` because [fzf](https://github.com/junegunn/fzf.git) is configured to exclude hidden folders and won't find files in `~/.dotfiles`.
.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` and
`.cfolder` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.
- **topic/\*.cfolder**: Any files ending in `*.cfolder` get symlinked into
  your `$HOME/.config` folder. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

The following files have to be located inside a **topic/\*\*/config-files/** folder:
- **\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.


## thanks

Many thanks to [Zach Holman](https://github.com/holman) for sharing his system.
