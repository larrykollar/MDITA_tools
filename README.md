# MDITA tools

Awk scripts to set up Markdown documents for Lightweight DITA,
either as standalone MDITA topics or as a stepping stone to full-weight DITA.
They are also useful to convert word processor documents,
first by exporting or converting to Markdown.

Currently, the utilities are:

*  *mdsplit*: split a Markdown file into individual MDITA topics,
   and build an XML bookmap to preserve the hierarchy and order.

*  *infotype*: assign a DITA topic type (concept, task, reference)
   to MDITA files, based on their content.
   You can easily modify or expand the default rules,
   which are based on regular expressions.

   **Note**: files are edited in place, so make a backup before running this script.

## Converting word processor files

Using *pandoc* is the fastest way to convert .docx or .odt files to Markdown:

`pandoc --atx-headers -t markdown_github -o` *file.md* *file*

Later versions of *pandoc* support `gfm` (GitHub Flavored Markdown)
in place of `markdown_github`.

**Note**: GIGO (Garbage In, Garbage Out) applies.
If your word processor files are not styled properly,
plan for a lot of cleanup
before running *mdsplit*.

## Using *mdsplit*

Usage: `mdsplit` [*options*] *`file`*

By default, *mdsplit* sends its output to the sub-directory `out/`,
and creates a bookmap `book.ditamap`.
You can change some of this behavior by setting options on the command line,
using Awk's `-v`&nbsp;*option*=*value* option.
You can use as many `-v` options as needed.
The options are:

*  `outdir`: specifies the output directory name (default: `out`).
*  `keyfilename`: if the input Markdown file has a YAML header,
   *mdsplit* converts those entries into keys
   and writes them into a DITA file with this name
   (default: `keys.xml`).
   Bookmaps include a reference to the key file.
*  `bookfilename`: the name of the map or bookmap (default: `book.ditamap`).
*  `maptitle`: the title or booktitle (default: `User Guide`).
*  `bookdtd`: the default bookmap DTD (default: OASIS DITA bookmap DTD).
*  `mapdtd`: the default map DTD (default: OASIS DITA map DTD).
*  `usemap`: set to a non-zero value to use a map instead of a bookmap (default: `0`).

If you want to permanently change the defaults,
either edit the script or use a shell script wrapper.

**Note**: *mdsplit* creates file names for each topic
based on the topic title.
If topic titles are not unique,
*mdsplit* appends a numeric value to the file name
to make the file names unique.

## Using *infotype*

While *infotype* can do a reasonable job of assigning topic types to MDITA topics,
you should always inspect the results.
Do not be afraid to override the script's decisions.
You can also assign topic types to MDITA topics before running the script,
and *infotype* respects your decisions.
Humans should ultimately be in charge.

The default *infotype* behavior
is to analyze each Markdown file,
use its rules to determine its topic type,
and edit the topic type into the file.
**So make a backup of your files before running the script**.

You can change some of this behavior by setting options on the command line,
using Awk's `-v`&nbsp;*option*=*value* option.
The options are:

*  `DEBUG`: set to a non-zero value to include debugging messages.
   This can be useful to debug new or modified rules (default: `0`).

*  `generic`: if *infotype* cannot determine a topic type based on its rules,
   assign this type to the topic.
   The default is a blank string (which means to use `topic`).
   If you have constrained out the `topic` type, `concept` is a good replacement.

### Adding or modifying rules

The function `weight_setup()`, at the end of the script,
defines the rules used to determine topic types.
You can modify or add to the rules as needed.
The `pattern` in each rule is a regular expression.

If you discover patterns that could be generally useful,
please put them in an issue or pull request.

