# Pacman
alias pac="pacman"

# Installs packages from repositories.
alias paci="sudo pacman --sync"

# Installs packages from files.
alias paci-from-file="sudo pacman --upgrade"

# Removes packages, their configuration, and unneeded dependencies.
alias pac-del="sudo pacman --remove --nosave --recursive"
alias pacx="pac-del"

# Displays information about a package from the repositories.
alias pac-info="pacman --sync --info"

# Searches for packages in the repositories.
alias pac-search="pacman --sync --search"

# Searches for packages in the local database.
alias pac-search-local="pacman --query --search"

# Synchronizes the local package database against the repositories then
# upgrades outdated packages.
alias pacu="sudo pacman --sync --refresh --sysupgrade"

# Maintenance
alias pacm-update-mirrors="sudo reflector --threads 8 --verbose -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist"
alias pacm-remove-orphans="sudo pacman --remove --recursive \$(pacman --quiet --query --deps --unrequired)"
alias pacm-list-orphans="sudo pacman --query --deps --unrequired"
alias pacm-update-db="sudo pacman-db-upgrade"
alias pacm-optimize="sudo pacman-optimize"

# pacaur
alias auri="pacaur -S"
alias auru="pacaur -Syu"
alias auru-all="auru --devel --needed"
alias auru-dev="pacaur --update --devel --needed"
alias aur-info="pacaur -Si"
alias aur-search="pacaur -Ss"
