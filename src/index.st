>>>
title: Subtext 
packages:
  - guide
format: html
template: basic
---

•title[ subtitle={A Text Processor (Beta Release)} ]

•section{Introduction}

See section •(ref){sec:running-subtext-ctr}, “•(ref){sec:running-subtext},”
for more information. •secnum{sec:running-subtext}. •secname{sec:running-subtext}

I wrote Subtext because I wanted to write multi-format documents. I wanted to
write one “source file” and use it to produce •html, •latex, and other format
types. I also wanted a code generator that would help with Go’s lack of
generics and streamline the maintenance of a large number of Terraform files
in my day job. Subtext does all of this.

A Subtext source file contains commands that Subtext expands using macro
definitions. Macro definitions can reside in standalone, reusable packages, or
they can be included directly in Subtext files. You can instruct Subtext to
auto-generate paragraphs, useful for creating •html pages, or you can preserve
line breaks as they are in the source file, useful for •latex or when using
Subtext as a preprocessor.

For instance, a Subtext file might contain the text

•codeblock*{hello, `•emph{world}*}

If the macro for the •code{emph} command was defined as

•codeblock*{
`•(newmacro){
    name: emph
    format: html
    parameters: ["arg"]
    template: "<i>[[ .arg ]]</i>"
}
*}

then Subtext would produce the •html

•codeblock*{hello, <i>world</i>*}

This short example demonstrates a few things about Subtext. First, by default
the `• character begins a command.•sidenote{Eventually, you’ll be able to
specify the command character, but that functionality isn’t fully baked yet.}
For most commands, the name of the command follows immediately after the
command character, but there are a few variations. The names of system
commands, such as the •code{newmacro} command in the example, are enclosed
in parantheses.

Command arguments are enclosed in braces: •code*{{...}*}. In this example,
both the •code{emph} and •code{newmacro} commands take just a single argument,
but, as is detailed later, commands may take multiple arguments and the
arguments can be named. Commands also support optional arguments with default
values as well as flags that can futher customize the output. Any text can
be placed inside a command argument including other commands.

The •code{template} field in a macro uses Go’s
•link[{https://golang.org/pkg/text/template/}{template}] functionality to
specify the command’s output. In our example, the Go template is

•codeblock{<i>[[ .arg ]]</i>}

While this is a simple template that just surrounds the argument with the
•html tags to italicize text, Go templates allow you to create much more
complex macros, especially when combined with Subtext’s extensive library of
custom template functions and its support for user defined variables.

The last thing to note about the example is that the argument of the
•code{newmacro} command is •sc{yaml}. This means that you can use the various
ways of defining a string 



This manual serves also as an example of how you might use Subtext. The source
for the manual is a Subtext file that produces both •html and •latex outputs.
The •latex output is further processed to produce a •sc{pdf} version of the
manual. Both versions use layout styles inspired by Edward Tufte’s work. The
•html uses •code{tufte.css} from the
•link[{https://github.com/edwardtufte/tufte-css} {Tufte CSS}] project, and the
•latex version uses the •link[{https://tufte-latex.github.io/tufte-latex/}
{Tufte-•latex}] package.

•(exec){[[ setdata "testcounter" "3" ]]}
•testsection[{Test Section}{sec-test}]

•section[{Running Subtext}{sec:running-subtext}]

You run Subtext from the command line, and it accepts several commands with a
variety of flags. The core commands are •code{make} and •code{build}. You can
always use the •code{help} command to get more information, for instance,
•code{subtext help make}.

•subsection{The •code{make} Command}

When you want to process a single file, use the •code{make} command. 

•codeblock{subtext make testfile.st}

•section{Macros}

Macros are defined using the •code{`•newmacro} system command which takes a
•sc{yaml} document as an argument.

•subsection{Document Templates}

A document template is a special sort of macro that is invoked auotomatically
if the document's preamble includes a template field. 

•section{Techniques}

•epigraphs{
	•epigraph[
		quote = {Remember that the basic rule of vocabulary is to use the
		first word that comes to your mind, if it is appropriate and
		colourful.}
		attr = {Stephen King, •booktitle{On Writing: A Memoir of the Craft}}
	]
	•epigraph[ <nopar>
		quote = {Short, meaningful quote.}
		attr = {Stephen King, •booktitle{On Writing: A Memoir of the Craft}}
	]
}

•subsection{Curly Quotes}

If you want curly quotes or apostrophes, also known as smart quotes, you can
simply use the appropriate Unicode characters in your source file. 

•marginnote{On macOS, hold the •keystroke{option} key and, if needed, the
•keystroke{shift} key, and press the indicated bracket key. On Windows,
hold the •keystroke{alt} key and type the four-digit character code on the
keypad with numlock on.}

•table[
header = {
	•trow{ •tcell{Glyph} •tcell{Description} •tcell{macOS} •tcell{Windows} }
}
body = {
	•frow{ •glyphcell{‘} •tcell{open single quote}  •tcell{•keystroke{option + ]}}         •tcell{•keystroke{alt 0145}} }
	•trow{ •glyphcell{’} •tcell{close single quote} •tcell{•keystroke{option + shift + ]}} •tcell{•keystroke{alt 0146}} }
	•trow{ •glyphcell{“} •tcell{open double quote}  •tcell{•keystroke{option + [}}         •tcell{•keystroke{alt 0147}} }
	•trow{ •glyphcell{”} •tcell{close double quote} •tcell{•keystroke{option + shift + [}} •tcell{•keystroke{alt 0148}} }
}]

◊•sidenote{On macOS, hold the
◊option key and press the open bracket key ‘[’ to produce an open double quote,
◊and hold the option and shift keys with the open bracket key to produce a
◊close double quote. Similarly, the close bracket key ‘]’ produces an open
◊single quote with the option key held and an open double quote with the option
◊and shift held.}

Alternatively, you can•marginnote{Another sidenote.} use the •cmd{sq} or
•cmd{dq} commands to produce single quotes or double quotes. This is the most
flexible approach since it allows you to customize how quotes are implemented
for different formats. Unfortunately, it is also the least readable.
