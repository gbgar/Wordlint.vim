Wordlint.vim provides two ex commands as an interface with the `wordlint`
redundancy checking program. These commands set the location list and
optionally highlight pairs of words found by the external program.

#Installation

## Install the stand-alone `wordlint` program

Instllation of this plugin is precluded by the installation of the external
tool `wordlint`, which may be found at
(https://github.com/gbgar/Wordlint)[https://github.com/gbgar/Wordlint] or may
be installed through Hackage, via cabal: 

`cabal update && cabal insall wordlint`

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

#Options

*g:wordlint_opts*

Default is ' '. Set this option to pass custom command line arguments to
wordlint.  All linting options and the `-a` output argument are acceptable
input. See `wordlint --help`, the wordlint man page, or the wordlint README for
a full list of available options. For example:

`:let g:wordlint_opts = '-t line -d 20'`

will cause :WordlintCheckBuffer to perform a line-based lint and return any
matching words that are greater than five characters (default) long and found
within 20 lines of one-another.

See the `wordlint` README.me, man page, or Haddock documentation for a listing
of all available options.
    
*g:wordlint_highlight*

If non-zero, highlight matches.  Default is '1'


*g:wordlint_custom_highlight_group*

Set the name of a custom syntax group for highlighting matches.
  For example:

`:highlight MyWordlintGroup ctermbg=yellow ctermfg=black`
`:let g:wordlint_custom_highlight_group = "MyWordLintGroup"`


Default is 'Error'

#Commands

Wordlint.vim provides two commands for interfacing with wordlint, one
targeting the entire buffer, and the other a selection. Both set the
location-list for the buffer, and both optionally set a custom highlight
for any matched words.

*:WordlintCheckBuffer*									

Runs `wordlint . g:wordlint_opts` on the current buffer, sets the
location-list, and optionally highlights all matches.

*:[range]WordlintCheckSelection*
		
The same as :WordlintCheckBuffer, but with an optional range.
Default range is set for the entire buffer.
