#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install RingoJS and Narwhal.
# Note that the order in which these are installed is important;
# see http://git.io/brew-narwhal-ringo.
brew install ringojs
brew install narwhal

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install homebrew/php/php56 --with-gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

# Install other useful binaries.
brew install ack
brew install dark-mode
# brew install exiv2
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rhino
brew install speedtest_cli
brew install ssh-copy-id
brew install testssl
brew install tree
brew install vbindiff
brew install webkit2png
brew install zopfli
brew install htop
brew install nvm
brew install jq

# Remove outdated versions from the cellar.
brew cleanup

brew cask install atom

apm install apathy-theme
apm install atom-beautify
apm install atom-ctags
apm install atom-django
apm install atom-material-syntax
apm install atom-material-ui
apm install atom-typescript
apm install color-picker
apm install django-templates
apm install editorconfig
apm install emmet
apm install fizzy
apm install git-log
apm install git-plus
apm install git-tab-status
apm install ink
apm install isotope-ui
apm install language-assembly
apm install language-matlab
apm install language-rust
apm install linter
apm install linter-coffeelint
apm install linter-flake8
apm install linter-jscs
apm install linter-jshint
apm install linter-python-pep8
apm install linter-scss-lint
apm install merge-conflicts
apm install monokai
apm install newton-dark-syntax
apm install newton-dark-ui
apm install node-debugger
apm install northem-dark-atom-ui
apm install oceanic-reef-syntax
apm install one-o-eight-syntax
apm install pigments
apm install pretty-json
apm install proto-repl
apm install proto-repl-charts
apm install remote-sync
apm install seti-syntax
apm install seti-ui
apm install solarized-dark-ui
apm install sort-lines
apm install symbols-tree-view
apm install tabasco
apm install terminal-plus
apm install tesla-atom
apm install writer-syntax

pip install glances
pip install binwalk
pip install dnet
pip install flake8
pip install hashpumpy
pip install Magic-file-extensions
pip install mccabe
pip install pbr
pip install pep8
pip install psutil
pip install pyflakes
pip install six
pip install stevedore
pip install virtualenv
pip install virtualenv-clone
pip install virtualenvwrapper
pip install wheel

brew cask install noizio

sudo gem install mdless
