Wordlint.vim provides a compiler based on the `wordlint` redundancy checking
program, intended for use in prose writing. 

#Installation

## Install the stand-alone `wordlint` program

Installation of this plugin is precluded by the installation of the external
tool `wordlint`, which may be found at
[https://github.com/gbgar/Wordlint](https://github.com/gbgar/Wordlint). It may
be installed through Hackage, via cabal: 

`cabal update && cabal insall wordlint`

or manually from source:

`git clone git://github.com/gbgar/Wordlint && cd Wordlint/ && cabal install`

Afterward, the vim interface may be installed.

## Install plugin via plugin manager

With the plugin manager of your choice, install the plugin, e.g.:

`NeoBundle 'gbgar/Wordlint.vim'`

While the benefit might be negligible due to the small size of this plugin,
lazy-loading features of the newest generation of plugin managers may be used
to restrict this plugin to prose filetypes (.txt, .md, tex, etc.) where I believe it
will be most useful.

## Install plugin Manually

Not recommended. Copy the repo's directory structure into ~/.vim/ folder.

#Usage 

Basic usage requires the user to set wordlint as the compiler:

`:compiler wordlint`

Afterward, the `:make` command may be used, with additional arguments if desired.

All linting options and the `--all` output flag are acceptable arguments.  See
`wordlint --help`, the wordlint man page, or the wordlint README for a full
list of available options. 

NOTE: As the `wordlint` program is in an early stage, options are subject to
change.

## Set filetype autocommand

Optionally, this compiler may be associated with a filetype in your .vimrc:

` autocmd FileType pandoc,markdown compiler wordlint`

#Commands

Wordlint.vim provides one convenience command for interfacing with wordlint. 

`:Wordlint` is a wrapper around :make which allows for user-defined default arguments. 


#Options

*g:wordlint_opts*

Default is ' '. Set this option to pass custom command line arguments to
`:Wordlint`, a wrapper for `:make`. Argument rules listed above apply.

For example:

`:let g:wordlint_opts = '-t line -d 20'
:Wordlint`

is equivalent to

`:make -t line -d 20 --nopunct`

and both will run `wordlint`, performing a line-based check and returning any
matching words that are greater than five characters (default) long and found
within 20 lines of one-another.
