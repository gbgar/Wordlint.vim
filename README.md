Wordlint.vim provides two ex commands as an interface with the `wordlint`
redundancy checking program. These commands set the location list and
optionally highlight pairs of words found by the external program.

#Installation

Instllation of this plugin is precluded by the installation of the external
tool `wordlint`, which may be found at https://github.com/gbgar/Wordlint
or may be installed through Hackage, via cabal: 


	`cabal insall wordlint`


Afterward, the vim interface may be installed.
##Using a plugin manager


##Manually

	Not recommended. Copy the repo's directory structure into ~/.vim/ folder.

#Options

g:wordlint_opts

    Default is ' '. Set this option to pass custom command line arguments to
    wordlint.  All linting options and the `-a` output argument are acceptable
    input. See `wordlint --help`, the wordlint man page, or the wordlint README for
    a full list of available options. For example:

            `:let g:wordlint_opts = '-t line -d 20'`

	will cause :WordcheckCheckBuffer to perform a line-based lint and
	return any matching words that are within 20 lines of one-another.

g:wordlint_highlight

	If non-zero, highlight matches.  Default is '1'


g:wordlint_custom_highlight_group

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

:WordlintCheckBuffer									

				Runs `wordlint . g:wordlint_opts` on the current buffer, sets the
				location-list, and optionally highlights all matches.

:[range]WordlintCheckSelection
		
				The same as :WordlintCheckBuffer, but with an optional range.
				Default range is set for the entire buffer.

