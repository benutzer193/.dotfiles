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
git clone --recursive https://github.com/benutzer193/.dotfiles.git
cd .dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

`dot` is a simple script that installs some dependencies, sets sane OS X
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.
- **topic/\*.cfolder**: Any files ending in `*.cfolder` get symlinked into
  your `$HOME/.config` folder. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.


## thanks

Many thanks to [Zach Holman](https://github.com/holman) for sharing his system.
