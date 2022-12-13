%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% POLITEX.CLS
%
% Copyright (c) 2014 Luiz Chamon
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License (LPPL)
% version 1.3 or (at your option) any later version.
% The latest version of this license can be found in
%      http://latex-project.org/lppl/lppl-1-3c.txt
% and is reproduced in the LICENSE file.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            PREAMBLE                              %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%  IDENTIFICATION  %%%%%%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{politex}%
	[2013/12/29 POLI-USP LaTeX Class]


%%%%%%  REQUIRED PACKAGES  %%%%%%
%% inputenc - for accented letters
\RequirePackage[utf8]{inputenc}

%% ifthen - for condition statements
\RequirePackage{ifthen}

%% calc - easy calculation of lengths and numbers
\RequirePackage{calc}

%% multicol - better multicolumns
\RequirePackage{multicol}


%%%%%%  INTERNATIONALIZATION  %%%%%%
\newcommand*{\POLIagradecimentosname}{Agradecimentos}
\providecommand*{\POLIannexname}{Anexo}
\providecommand*{\POLIappendixname}{Apêndice}
\providecommand*{\POLIbibliographyname}{Referências}

\AtBeginDocument{
	\@ifpackagewith{babel}{brazil}{%
			\renewcommand*{\POLIagradecimentosname}{Agradecimentos}%
			\renewcommand*{\POLIannexname}{Anexo}%
			\renewcommand*{\POLIappendixname}{Apêndice}%
			\renewcommand*{\POLIbibliographyname}{Referências}%
	}{}
	\@ifpackagewith{babel}{portuguese}{%
			\renewcommand*{\POLIagradecimentosname}{Agradecimentos}%
			\renewcommand*{\POLIannexname}{Anexo}%
			\renewcommand*{\POLIappendixname}{Apêndice}%
			\renewcommand*{\POLIbibliographyname}{Referências}%
	}{}
	\@ifpackagewith{babel}{english}{%
			\renewcommand*{\POLIagradecimentosname}{Acknowledgments}%
			\renewcommand*{\POLIannexname}{Annex}%
			\renewcommand*{\POLIappendixname}{Appendix}%
			\renewcommand*{\POLIbibliographyname}{References}%
	}{}
}


%%%%%%  OPTIONS DECLARATIONS  %%%%%%
%% Page numbering squeme
\providecommand{\ABNTpnum}{}
\DeclareOption{pnumabnt}{\renewcommand*{\ABNTpnum}{ABNT}}
\DeclareOption{pnumromarab}{\renewcommand*{\ABNTpnum}{RomArab}}
\ExecuteOptions{pnumabnt}

%% Style of page numbers in TOC
\newboolean{ABNTpagenumstyle}
\DeclareOption{abnttoc}{\setboolean{ABNTpagenumstyle}{true}}
\DeclareOption{normaltoc}{\setboolean{ABNTpagenumstyle}{false}}
\ExecuteOptions{normaltoc}

%% Figures and tables independent of sections?
\newboolean{ABNTnumbering}
\DeclareOption{abntnum}{\setboolean{ABNTnumbering}{true}}
\DeclareOption{normalnum}{\setboolean{ABNTnumbering}{false}}
\ExecuteOptions{abntnum}

%% Page options (margins)
\providecommand{\POLIgeo}{}
\DeclareOption{normalprint}	{\renewcommand*{\POLIgeo}{\geometry{inner = 3cm}}}
\DeclareOption{draftprint}	{\renewcommand*{\POLIgeo}{\geometry{inner = 2cm}}}
\DeclareOption{twosideprint}{\renewcommand*{\POLIgeo}{\geometry{inner = 3cm, twoside}}}
\ExecuteOptions{normalprint}

%% Should section titles be capitalized? (default = NO)
\newboolean{ABNTcapsec}
\setboolean{ABNTcapsec}{false}
\DeclareOption{capsec}{\setboolean{ABNTcapsec}{true}}

%% Line Spacing options: change current setting.
\newcommand*{\ABNTespacodefault}{}%
\DeclareOption{espacoumemeio}	{\renewcommand*{\ABNTespacodefault}{\taxaespacoumemeio}}
\DeclareOption{espacosimples}	{\renewcommand*{\ABNTespacodefault}{\taxaespacosimples}}
\DeclareOption{espacoduplo}		{\renewcommand*{\ABNTespacodefault}{\taxaespacoduplo}}
\ExecuteOptions{espacoumemeio}

%% Times font option
\newboolean{ABNTtimesfont}
\DeclareOption{times}{\setboolean{ABNTtimesfont}{true}}
\DeclareOption{notimes}{\setboolean{ABNTtimesfont}{false}}
\ExecuteOptions{notimes}

%% Font size options (passed on to the report class)
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{report}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{report}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{report}}
\ExecuteOptions{12pt}

%% Option to indent the first paragraph of each section or chapter
\newboolean{ABNTindentfirst}
\DeclareOption{indentfirst}{\setboolean{ABNTindentfirst}{true}}
\DeclareOption{noindentfirst}{\setboolean{ABNTindentfirst}{false}}
\ExecuteOptions{indentfirst}


%%%%%%  PROCESS OPTIONS  %%%%%%
%% Issue a warning for all undefined options
\DeclareOption*{
	\PackageWarning{politex}{Unknown option `\CurrentOption'}
}

%% Process options
\ProcessOptions

%% Pass the appropriate options to class
\PassOptionsToClass{a4paper}{report}
\PassOptionsToClass{openright}{report}

%% ABNTeX trick for continuous figure/table counting
%% Redefine \newcounter to exclude [chapter] in case it is a figure/table.
\ifthenelse{\boolean{ABNTnumbering}}{
	% Save old \newcounter
	\let\ABNToldnewcounter\newcounter\relax
	\def\ABNTeatbrackets[#1]{\relax}

	\renewcommand{\newcounter}[1]{%
		\ifthenelse{\equal{#1}{figure}\or\equal{#1}{table}}%
			{\ABNToldnewcounter{#1}%
			\@ifnextchar[{\ABNTeatbrackets}{} }%
			{\ABNToldnewcounter{#1}}%
	}
}{}


%%%%%%  LOAD REPORT CLASS  %%%%%%
%% Load base class
\LoadClass{report}

%% Undo the \newcounter redefinition and fix counter style
\ifthenelse{\boolean{ABNTnumbering}}{
	\let\newcounter\ABNToldnewcounter\relax
	\renewcommand*{\thefigure}{\arabic{figure}}
	\renewcommand*{\thetable}{\arabic{table}}
}{}






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                         IMPLEMENTATION                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%  PAGE SETTINGS AND PACKAGES  %%%%%%

%% Stretch factor for default line spacing schemes
\newcommand*{\taxaespacosimples}{1.}
\newcommand*{\taxaespacoumemeio}{1.35}
\newcommand*{\taxaespacoduplo}{1.7}

%% Require geometry for setting page geometry
\RequirePackage[a4paper]{geometry}

%% Require geometry for setting page geometry
\RequirePackage{fancyhdr}

%% Require setspace for proper line spacing commands and environments
\RequirePackage[nodisplayskipstretch]{setspace}


%%%%%%  HEADER STYLE  %%%%%%

%%  Defining "POLIheader" pagestyle
\fancypagestyle{POLIheader}{%
	\fancyhf{} % clear all header and footer fields
	\if@twoside%
		\fancyhead[RO,LE]{\small\thepage}
	\else%
		\fancyhead[RO]{\small\thepage}
	\fi%
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}


%%%%%%  MARGIN SETTINGS  %%%%%%

\newgeometry{	offset = 0pt,		%	Offset between layout and page border
				top = 3cm,			%	Top margin
				bottom = 2cm,		%	Bottom margin
				outer = 2cm,		%	Right (outer) margin
				headheight = 14pt,	%	Height of the header
				headsep = 22pt,		%	Separation from text
				ignorehead,
				ignorefoot
}

% Set inner margin and twoside (if necessary) printing
\POLIgeo


%%%%%%  PAGE NUMBERING  %%%%%%

%% Pretextual part?
\newboolean{ABNTinpretext}
\setboolean{ABNTinpretext}{true}

%% After the TOC?
\newboolean{ABNTaftertoc}
\setboolean{ABNTaftertoc}{false}

%% \ABNTBeginOfTextualPart is executed at the start
%% of the first chapter after the TOC
\providecommand*{\ABNTBeginOfTextualPart}{}
\providecommand*{\chaptertitlepagestyle}{}

%% Page numbering settings
% - No page numbering until textual part
% - Page counter starts at `folha de rosto'
\pagestyle{empty}
\renewcommand{\chaptertitlepagestyle}{empty}

%% Numbering schemes
\ifthenelse{\equal{\ABNTpnum}{ABNT}}{
	% ABNT strict
	% Page style is empty until TOC
	\renewcommand{\ABNTBeginOfTextualPart}{
		\renewcommand{\thepage}{\arabic{page}}
		\pagestyle{POLIheader}
		\renewcommand{\chaptertitlepagestyle}{POLIheader}
	}
}{
	% Roman/Arabic
	% Use roman numerals for pretextual part
	% Use arabic numerals for textual part (restart counter)
	\renewcommand{\thepage}{\roman{page}}
	
	\renewcommand{\ABNTBeginOfTextualPart}{
		\setcounter{page}{1}
		\renewcommand{\thepage}{\arabic{page}}
		\pagestyle{POLIheader}
		\renewcommand{\chaptertitlepagestyle}{POLIheader}
	}
}


%%%%%%  LINE SPACING  %%%%%%

%% Define \espaco command: takes "simples", "umemeio", "duplo", or a numerical value
\newcommand{\espaco}[1]{
	\ifthenelse{\equal{#1}{simples}}		% espacamento simples
		{\setstretch{\taxaespacosimples}}{
	\ifthenelse{\equal{#1}{umemeio}}		% espacamento 1.5
		{\setstretch{\taxaespacoumemeio}}{
	\ifthenelse{\equal{#1}{duplo}}			% espacamento duplo
		{\setstretch{\taxaespacoduplo}}{
	\setstretch{#1}}}}						% espacamento dado
}

%% Set line spacing environments
% single spacing
\newenvironment{espacosimples}%
	{\begin{spacing}{\taxaespacosimples}}{\end{spacing}}

% one and a half spacing
\newenvironment{espacoumemeio}%
	{\begin{spacing}{\taxaespacoumemeio}}{\end{spacing}}

% double spacing
\newenvironment{espacoduplo}%
	{\begin{spacing}{\taxaespacoduplo}}{\end{spacing}}

%% Set default spacing and check for hypperref package
\newboolean{ABNThypertoc}
\AtBeginDocument{
	% default spacing (set by class options)
	\espaco{\ABNTespacodefault}%
	\@ifpackageloaded{hyperref}{\setboolean{ABNThypertoc}{true}}%
								{\setboolean{ABNThypertoc}{false}}%
}


%%%%%%  PART/CHAPTER/SECTION STYLE  %%%%%%

%% Font for chapter titles
\newcommand{\ABNTchapterfont}{\bfseries\upshape}
\newcommand{\ABNTtocchapterfont}{\ABNTchapterfont\upshape}

%% Font for section titles
\newcommand{\ABNTsectionfont}{\bfseries}
\newcommand{\ABNTchaptersize}{\Large}
\newcommand{\ABNTcapchapsize}{\Large}
\newcommand{\ABNTtitulosize}{\Large}

%% From the definition of \secdef: stared version admits optional parameter
\def\ABNTsecdef#1#2{\@ifstar{\@dblarg{#2}}{\@dblarg{#1}}}

%% Set chapter type variable for hyperref package
\newcommand*{\chaptertype}{}

%% Chapter
\renewcommand{\chapter}{%
	\cleardoublepage%
	\thispagestyle{\chaptertitlepagestyle}%
	\ifthenelse{\boolean{ABNTinpretext}\and\boolean{ABNTaftertoc}}{%
		% Change to textual part
		\setboolean{ABNTinpretext}{false}%
		\ABNTBeginOfTextualPart%
    }{}%
	\global\@topnum\z@% Prevents figures from going to the top of page
	\@afterindentfalse%
	\secdef\@chapter\@schapter%
}
	
%% Pre-textual chapter
% Same as \chapter*{} without switching to textual part
\newcommand{\pretextualchapter}{%
	\vspace*{-1.1cm}\par%
	\thispagestyle{\chaptertitlepagestyle}%
	\global\@topnum\z@%
	\@afterindentfalse%
	\@schapter%
}

%% \ProximoForaDoSumario
% Does not include next chapter or section in the TOC
\newboolean{ABNTNextOutOfTOC}
\setboolean{ABNTNextOutOfTOC}{false}

\newcommand{\ProximoForaDoSumario}{
	\setboolean{ABNTNextOutOfTOC}{true}
}

%% Reset subcounters (in chapter, part...)
\newcommand{\resetsubcounters}[1]{%
	\begingroup
		\let\@elt\@stpelt
		\csname cl@#1\endcsname
	\endgroup%
}

%% Include item in TOC (or not) 
\newcommand{\ABNTaddcontentsline}[3]{%
	\ifthenelse{\boolean{ABNTNextOutOfTOC}}%
		{\setboolean{ABNTNextOutOfTOC}{false}}%
		{%
		\ifthenelse{\boolean{ABNThypertoc}}%
			{\addtocontents{#1}{\protect\contentsline{#2}{#3}{\thepage}{#2.\csname theH#2\endcsname}}}%
			{\addcontentsline{#1}{#2}{#3}}%
		}%
}

%% \@chapter
\def\@chapter[#1]#2{%
	\ifthenelse{\boolean{ABNThypertoc}}%
		{\renewcommand{\theHchapter}{\chaptertype\thechapter}}{}%
%
	% Chapter numbering
	\ifnum \c@secnumdepth > \m@ne
		\refstepcounter{chapter}%
		\chaptermark{#1}%
		\typeout{\@chapapp\space\thechapter.}%
	\else
		\chaptermark{#1}%
	\fi
%
	% Include in TOC
	\ifthenelse{\boolean{ABNTaftertoc}}%
		{\ABNTaddcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}}{}%
	\if@twocolumn
		\@topnewpage[\@makechapterhead{#2}]%
	\else
		\@makechapterhead{#2}%
		\@afterheading%
	\fi\par%
}

%% \@schapter
\def\@schapter#1{%
	\ifthenelse{\boolean{ABNThypertoc}}%
		{\renewcommand{\theHchapter}{\chaptertype\thechapter}}{}%
	\if@twocolumn
		\@topnewpage[\@makeschapterhead{#1}]%
	\else
		\@makeschapterhead{#1}%
		\@afterheading%
	\fi
	\markboth{#1}{#1}
	% Include in TOC
	\ifthenelse{\boolean{ABNTaftertoc}}
	   {\ABNTaddcontentsline{toc}{chapter}{#1}}
	   {}
	\resetsubcounters{chapter}\par
}%

%% \@part
\def\@part[#1]#2{%
    \ifnum \c@secnumdepth > -2
		\refstepcounter{part}%
		\ABNTaddcontentsline{toc}{chapter}{\partname~\thepart:~\MakeUppercase{#1}}%
    \else
		\resetsubcounters{part}%
		\ABNTaddcontentsline{toc}{chapter}{#1}%
    \fi
    \markboth{}{}%
    {\centering
	\interlinepenalty \@M
	\normalfont
	\ifnum \c@secnumdepth > -2
		\ABNTchapterfont\huge\MakeUppercase{\partname~\thepart}%
		\par%
		\vskip 20\p@%
	\fi
		\ABNTchapterfont\ABNTcapchapsize\MakeUppercase{#2}%
		\par%
	}%
    \@endpart%
}

%% \@spart
\def\@spart#1{%
	\ABNTaddcontentsline{toc}{part}{#1}%
	\markboth{}{}%
    {\centering
	\interlinepenalty \@M
	\normalfont
		\ABNTchapterfont\ABNTcapchapsize\MakeUppercase{#1}%
	\par%
	}%
    \@endpart%
}

%% \@startsection
% The only difference is that it calls \@ssect changing
% the meaning of the first parameter. Now, instead of
% indentation, it gives section for TOC purposes.
\def\ABNTstartsection#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty\addvspace\@tempskipa
  \fi
  \@ifstar
    {\ABNTssect{#1}{#4}{#5}{#6}}% #3 replaced by #1 here
    {\@dblarg{\ABNTsect{#1}{#2}{#3}{#4}{#5}{#6}}}}

%% \@ssect
% Instead of indentation, the first parameter gives the
% section for TOC purposes.
\def\ABNTssect#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{%
         \interlinepenalty \@M \centering
         \ifthenelse{\boolean{ABNTcapsec}}
             {\MakeUppercase{#5}}{#5}\@@par}%
    \endgroup
    \@ifundefined{ABNT#1mark}{}{\csname ABNT#1mark\endcsname{#5}}
     \ABNTaddcontentsline{toc}{#1}{#5}
  \else
    \def\@svsechd{#4{#5}%
      \@ifundefined{ABNT#1mark}{}{\csname ABNT#1mark\endcsname{#5}}
       \ABNTaddcontentsline{toc}{#1}{#5}
    }%
  \fi
  \@xsect{#3}}

%% \@sect
% With changed parameters
\def\ABNTsect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M
          \ifthenelse{\boolean{ABNTcapsec}}
             {\MakeUppercase{#8}}{#8}\@@par}%
    \endgroup
    \@ifundefined{ABNT#1mark}{}{\csname ABNT#1mark\endcsname{#7}}
    \ABNTaddcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec \ifthenelse{\boolean{ABNTcapsec}}
             {\MakeUppercase{#8}}{#8}}%
      \@ifundefined{ABNT#1mark}{}{\csname ABNT#1mark\endcsname{#7}}
      \ABNTaddcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}

%% TOC page numbers style required by NBR 6027
\let\old@dottedtocline\@dottedtocline
\renewcommand{\@dottedtocline}[5]{%
	\ifthenelse{\boolean{ABNTpagenumstyle}}
	{%
	{\renewcommand{\@pnumwidth}{2.5em}%
	\renewcommand{\@tocrmarg}{3.5em}
	\old@dottedtocline{#1}{#2}{#3}{#4}%
	{\ifthenelse{\equal{#5}{}}{}{p.\thinspace#5}}}%
    }%
	{\old@dottedtocline{#1}{#2}{#3}{#4}{#5}}%
}

%% Chapter epigraph (\capepigrafe[width]{quote}{author})
\newcommand\capepigrafe[3][0.5\textwidth]{
	\vspace{-70pt}
	\noindent
	\begin{flushright}
	\begin{minipage}{#1}{
		\vspace{20pt}
		\begin{spacing}{0.9}
		\begin{flushright}
			\small\noindent\textit{#2}
		\end{flushright}
		\end{spacing}
		\vspace{-16pt}
		\begin{flushright}
			-{}- #3
			\vspace{10pt}
		\end{flushright}
	}
	\end{minipage}
	\end{flushright}
	\par\@afterindentfalse\@afterheading
}

%% Header style for \chapter
\def\@makechapterhead#1{%
  {%
  \normalfont\ABNTchaptersize\ABNTchapterfont%
  \espaco{simples}%
  \vspace*{30pt}%
  \noindent%
  \parbox[b]{\textwidth}{%
    \parbox[t]{4ex}{\thechapter}%
    \parbox[t]{\textwidth-4ex-1ex}%
      {\interlinepenalty\@M\raggedright%
       \MakeUppercase{#1}%
      }%
    \vspace*{0cm}
    }\\[2pt]%
  \vspace{50pt}%
  }%
}

%% Header style for \chapter*
\def\@makeschapterhead#1{%
  \vspace*{0pt}\par
  {\centering\normalfont\ABNTchaptersize\ABNTchapterfont%
   \MakeUppercase{#1}%
    \par}%
  \vspace{45pt}%
  \par
}

%% \l@chapter
% Redefining to apply tocnumpageabnt
\renewcommand\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \ifthenelse{\boolean{ABNTpagenumstyle}}
        {\renewcommand{\@pnumwidth}{3.5em}}
        {}
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \normalsize\ABNTtocchapterfont
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak%
      \ifthenelse{\boolean{ABNTpagenumstyle}}
         {%
          \hb@xt@\@pnumwidth{\hss 
            \ifthenelse{\not\equal{#2}{}}{{\normalfont p.\thinspace#2}}{}}\par
         }
         {%
          \hb@xt@\@pnumwidth{\hss #2}\par
         }
      \penalty\@highpenalty
    \endgroup
  \fi}

%% \part
\renewcommand\part{%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \thispagestyle{empty}%
  \if@twocolumn\onecolumn\@tempswatrue\else\@tempswafalse\fi%
  \ifthenelse{\boolean{ABNTinpretext}\and\boolean{ABNTaftertoc}}{
		   % change to textual part
           \setboolean{ABNTinpretext}{false}%
           \ABNTBeginOfTextualPart%
          }{}%
  \null\vfil\secdef\@part\@spart}%

%% \l@part
\renewcommand\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \noindent{\leavevmode
       \ABNTtocchapterfont\large\noindent%
          #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}

%% \section
\renewcommand\section{\ABNTstartsection{section}{1}{\z@}%
                           {-3.5ex \@plus -1ex \@minus -.2ex}%
                           {2.3ex \@plus.2ex}%
                           {\espaco{simples}\normalfont%
                            \ABNTsectionfont\Large}}
							
%% \subsection
\renewcommand\subsection{\ABNTstartsection{subsection}{2}{\z@}%
                           {-3.25ex\@plus -1ex \@minus -.2ex}%
                           {1.5ex \@plus .2ex}%
                           {\espaco{simples}\normalfont%
                            \ABNTsectionfont\large}}

%% \subsubsection
\renewcommand\subsubsection{\ABNTstartsection{subsubsection}{3}{\z@}%
                           {-3.25ex\@plus -1ex \@minus -.2ex}%
                           {1.5ex \@plus .2ex}%
                           {\espaco{simples}\normalfont%
                            \ABNTsectionfont\normalsize}}

%% \paragraph
\renewcommand\paragraph{\ABNTstartsection{paragraph}{4}{\z@}%
                           {3.25ex \@plus1ex \@minus.2ex}%
                           {-1em}%
                           {\espaco{simples}\normalfont%
                            \ABNTsectionfont\normalsize}}

%% \subparagraph
\renewcommand\subparagraph{\ABNTstartsection{subparagraph}{5}{\parindent}%
                           {3.25ex \@plus1ex \@minus .2ex}%
                           {-1em}%
                           {\espaco{simples}\normalfont%
                            \ABNTsectionfont\normalsize}}

%%%%%%  ANNEX AND APPENDIX
\newcommand{\anapchaptername}{}
\newlength{\ABNTanapindent}
\setlength{\ABNTanapindent}{0cm}
\newcommand{\ABNTanapsize}{\LARGE}

%% \@anapchapter
\def\@anapchapter[#1]#2%
{
       \refstepcounter{chapter}%
         \begingroup
         \ifthenelse{\equal{#1}{}}
            {\def\thechapter{\anapchaptername{} \Alph{chapter}}}
            {\def\thechapter{\anapchaptername{} \Alph{chapter}{} -- #1}} 
         \chaptermark{}
         \endgroup
         \if@twocolumn
           \@topnewpage[\@makeanapchapterhead{#2}]%
         \else
           \@makeanapchapterhead{#2}%
           \@afterheading
         \fi
       \ifnum \c@secnumdepth >\m@ne
         \typeout{\@chapapp\space\thechapter.}%
           \ifthenelse{\equal{#1}{}}
              {\ABNTaddcontentsline{toc}{chapter}%
                  {\anapchaptername{} \thechapter}}
              {\ABNTaddcontentsline{toc}{chapter}%
                  {\anapchaptername{} \thechapter{} -- #1}}
       \else
         \ABNTaddcontentsline{toc}{chapter}{#1}
       \fi
       \par
}

%% Header style for \anapchapter
\def\@makeanapchapterhead#1{%
  {%
  \normalfont\ABNTchapterfont\ABNTanapsize
  \espaco{simples}
  \settowidth{\ABNTanapindent}{\MakeUppercase{\anapchaptername}
          \thechapter{} -- }

  \vspace*{30pt}

  \raggedright\espaco{1.2}\par  
  \begin{list}{}{%
       \setlength{\listparindent}{0cm}%
       \setlength{\itemindent}{-\ABNTanapindent}%
       \setlength{\rightmargin}{0cm}%
       \setlength{\leftmargin}{\ABNTanapindent}%
       \setlength{\parsep}{0pt}}%
    \item %
      \ifthenelse{\equal{#1}{}}%
         {\MakeUppercase{\anapchaptername}
          \thechapter \relax}%
         {\MakeUppercase{\anapchaptername}
          \thechapter{} -- \relax%
            \MakeUppercase{#1}%
          }%
  \end{list}%
  \par\vspace{50pt}%
  }%
}

%% \appendix
\renewcommand{\appendix}{
  \setcounter{chapter}{0}
  \resetsubcounters{chapter}
  \gdef\thechapter{\Alph{chapter}}
  \ifthenelse{\boolean{ABNThypertoc}}{\renewcommand{\chaptertype}{appen.}}{}
  \gdef\@chapapp{Apendice}
  \renewcommand{\anapchaptername}{\POLIappendixname}
  \global\let\@chapter\@anapchapter}

%% \annex
\newcommand{\annex}{
  \setcounter{chapter}{0}
  \resetsubcounters{chapter}
  \gdef\thechapter{\Alph{chapter}}
  \ifthenelse{\boolean{ABNThypertoc}}{\renewcommand{\chaptertype}{annex.}}{}
  \gdef\@chapapp{Anexo}
  \renewcommand{\anapchaptername}{\POLIannexname}
  \global\let\@chapter\@anapchapter}

%% Portuguese names
\let\apendice\appendix
\let\anexo\annex


%%%%%%  TOC  %%%%%%
% Same as old \tableofcontents, but redefined to accomodate changes in
% \chapter* (which is used in the original \tableofcontents)

\newboolean{ABNTrestorecol} % new boolean to avoid conflicts

\renewcommand{\tableofcontents}{%
  \ifthenelse{\boolean{@twocolumn}}%
    {\setboolean{ABNTrestorecol}{true}\onecolumn}%
    {\setboolean{ABNTrestorecol}{false}}%
  \if@openright\cleardoublepage\else\clearpage\fi
  \pretextualchapter{\contentsname}
  \@afterheading
  \markboth{\contentsname}{\contentsname}
  \@starttoc{toc}%
  \ifthenelse{\boolean{ABNTrestorecol}}{\twocolumn}{}%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \setboolean{ABNTaftertoc}{true}
}%

%% Portuguese name
\let\sumario\tableofcontents\relax

%% Contents shows up to subsubsection. 
\setcounter{tocdepth}{4}

%% Section number will appear up to \subsubsection
\setcounter{secnumdepth}{3}


%%%%%%  LIST OF FIGURES  %%%%%%
% Same as the old one, but tests for ABNTrestorecol

\renewcommand{\listoffigures}{%
\if@openright\cleardoublepage\else\clearpage\fi%
  \ifthenelse{\boolean{@twocolumn}}%
    {\setboolean{ABNTrestorecol}{true}\onecolumn}%
    {\setboolean{ABNTrestorecol}{false}}%
  \ifthenelse{\boolean{ABNThypertoc}}{\renewcommand{\chaptertype}{listoffigures.}}{}%
  \pretextualchapter{\listfigurename}%
  \ifthenelse{\boolean{ABNThypertoc}}{\renewcommand{\chaptertype}{}}{}%
  \@starttoc{lof}%
  \ifthenelse{\boolean{ABNTrestorecol}}{\twocolumn}{}%
}

%% Portuguese name
\let\listadefiguras\listoffigures\relax


%%%%%%  LIST OF TABLES  %%%%%%
% Same as the old one, but tests for ABNTrestorecol
\renewcommand\listoftables{%
\if@openright\cleardoublepage\else\clearpage\fi%
  \ifthenelse{\boolean{@twocolumn}}%
    {\setboolean{ABNTrestorecol}{true}\onecolumn}%
    {\setboolean{ABNTrestorecol}{false}}%
  \ifthenelse{\boolean{ABNThypertoc}}{\renewcommand{\chaptertype}{listoftables.}}{}%
  \pretextualchapter{\listtablename}%
  \ifthenelse{\boolean{ABNThypertoc}}{\renewcommand{\chaptertype}{}}{}%
  \@starttoc{lot}%
  \ifthenelse{\boolean{ABNTrestorecol}}{\twocolumn}{}%
}

%% Portuguese name
\let\listadetabelas\listoftables\relax


%%%%%%  BIBLIOGRAPHY  %%%%%%

\renewenvironment{thebibliography}[1]%
{%
   \if@openright\cleardoublepage\else\clearpage\fi%
   \thispagestyle{\chaptertitlepagestyle}%
   \global\@topnum\z@%
   \@afterindentfalse%
   \chapter*{\POLIbibliographyname}
   \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth%
         \advance\leftmargin\labelsep%
         \@openbib@code%
         \usecounter{enumiv}%
         \let\p@enumiv\@empty%
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy%
   \espaco{simples}
   \clubpenalty4000%
   \@clubpenalty \clubpenalty%
   \widowpenalty4000%
   \sfcode`\.\@m%
}
{%
   \def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
   \endlist%
}


%%%%%%  INDEX  %%%%%%
% Same as old theindex, but without capital page marks,
% automatically in toc, and balanced colunms

\renewenvironment{theindex}%
{%
   \ifthenelse{\boolean{@twocolumn}}%
     {\setboolean{ABNTrestorecol}{true}\onecolumn}%
     {\setboolean{ABNTrestorecol}{false}}%
   \if@openright\cleardoublepage\else\clearpage\fi%
   \thispagestyle{\chaptertitlepagestyle}%
   \global\@topnum\z@%
   \@afterindentfalse%
   \markboth{\indexname}{\indexname}% 
    \ABNTaddcontentsline{toc}{chapter}{\indexname}
   \@makeschapterhead{\indexname}%
   \@afterheading%
   \begingroup%
   \setlength{\columnsep}{35pt}%
   \setlength{\columnseprule}{0pt}
   \begin{multicols}{2}%
   \espaco{simples}%
   \setlength{\parindent}{0cm}%
   \setlength{\parskip}{.3pt}%
   \let\item\@idxitem%
}
{%
   \end{multicols}
   \endgroup%
   \ifthenelse{\boolean{ABNTrestorecol}}{\twocolumn}{}%
}


%%%%%%  LONG CITATION  %%%%%%
%% Environment citacaoLonga: 4cm indentation, smaller font and simple line spacing

\newenvironment{citacaoLonga}%
{\begin{espacosimples}%
   \small
   \begin{list}{}{%
       \setlength{\listparindent}{0cm}%
       \setlength{\itemindent}{\listparindent}%
       \setlength{\rightmargin}{0cm}%
       \setlength{\leftmargin}{4cm}%
       \setlength{\parsep}{0pt}}%
    \item\relax}%
{\end{list}\end{espacosimples}}






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                       PRE-TEXTUAL ELEMENTS                       %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\newcommand{\fcformat}{\textsf}

\providecommand{\ABNTautordata}{}
\newcommand{\autor}[1]{\renewcommand{\ABNTautordata}{\uppercase{#1}}}
\newcommand{\autorformat}{\large\ABNTsectionfont}

\providecommand{\ABNTorientadordata}{}
\providecommand{\ABNTorientadorname}{}
\newcommand{\orientador}[2][Orientador:\vspace{1mm}\\]%
  {\renewcommand{\ABNTorientadorname}{#1}%
   \renewcommand{\ABNTorientadordata}{#2}}
\newcommand{\orientadornameformat}{}
\newcommand{\orientadorformat}{\large}

\providecommand{\ABNTcoorientadordata}{}
\providecommand{\ABNTcoorientadorname}{}
\newcommand{\coorientador}[2][Co-orientador:\vspace{1mm}\\]%
  {\renewcommand{\ABNTcoorientadorname}{#1}%
   \renewcommand{\ABNTcoorientadordata}{#2}}
\newcommand{\coorientadornameformat}{}
\newcommand{\coorientadorformat}{\large}

\providecommand{\ABNTtitulodata}{}
\providecommand{\ABNTuppercasetitulodata}{}
\newcommand{\titulo}[1]{
\renewcommand{\ABNTtitulodata}{#1}
\renewcommand{\ABNTuppercasetitulodata}{\uppercase{#1}}
}
\newcommand{\tituloformat}{\ABNTtitulosize\ABNTchapterfont}

\providecommand{\ABNTcomentariodata}{}
\newcommand{\comentario}[1]{\renewcommand{\ABNTcomentariodata}{#1}}
\newcommand{\comentarioformat}{}

\newcommand{\PoliDepartamentoData}{}
\newcommand{\departamento}[1]{\renewcommand{\PoliDepartamentoData}{#1}}

\providecommand{\ABNTareaconcdata}{}
\providecommand{\ABNTareaconcname}{}
\newcommand{\areaConcentracao}[2][\'Area de Concentra\c{c}\~ao:\vspace{1mm}\\]%
  {\renewcommand{\ABNTareaconcname}{#1}%
   \renewcommand{\ABNTareaconcdata}{#2}}
\newcommand{\areaconcnameformat}{}
\newcommand{\areaconcformat}{}

\providecommand{\ABNTlocaldata}{}
\newcommand{\local}[1]{\renewcommand{\ABNTlocaldata}{#1}}
\newcommand{\localformat}{}

\providecommand{\ABNTdatadata}{}
\newcommand{\data}[1]{\renewcommand{\ABNTdatadata}{#1}}
\newcommand{\dataformat}{}

\newcommand{\ABNTifnotempty}[2]{\ifthenelse{\not\equal{#1}{}}{#2}{}}


%%%%%%  FRONT PAGE  %%%%%%
% Author, title, place, and date

%% Distance between author(s) and title (adds support for multi-authors)
\newlength{\authorTitleLength}

\newcommand{\capa}{%
  \begin{center} 
    \espaco{1.2}
    {\autorformat \ABNTautordata} \par
	% Distance = 12cm - (margin top) - (authors height)
	\setlength{\authorTitleLength}{12cm - 3.2cm - \totalheightof{\vbox{\autorformat \ABNTautordata}}}
	\vspace{\authorTitleLength}
    {\tituloformat \ABNTuppercasetitulodata}

    % local e data
    \vfill
    \begin{espacosimples} 
      {\localformat\ABNTlocaldata}\\
      {\dataformat\ABNTdatadata}
    \end{espacosimples}
    \if@openright\cleardoublepage\else\clearpage\fi%
  \end{center} 
}


%%%%%%  TITLE PAGE  %%%%%%
% Author, title, comments, area of study, advisor,
% co-advisor (if any), place, and year

\newcommand{\falsafolhaderosto}{%
  \setcounter{page}{1}
  \begin{center} 
    \espaco{1.2}
    {\autorformat \ABNTautordata} \par
	% Distance = 12cm - (margin top) - (authors height)
	\setlength{\authorTitleLength}{12cm - 3.2cm - \totalheightof{\vbox{\autorformat \ABNTautordata}}}
	\vspace{\authorTitleLength}
    {\tituloformat \ABNTuppercasetitulodata}

    % comentário
    \vspace{2cm}
    \hspace{.5\textwidth} % posicionando a minipage 
    \begin{minipage}{.49\textwidth}
      \begin{espacoumemeio}
        \begin{sloppypar}
            {\comentarioformat\ABNTcomentariodata}
            \vspace{0.3cm}
        \end{sloppypar}

      \end{espacoumemeio}
    \end{minipage} 

    % local e data
    \vfill
    \begin{espacosimples} 
      {\localformat\ABNTlocaldata}\\
      {\dataformat\ABNTdatadata}
    \end{espacosimples} 
    \if@openright\cleardoublepage\else\clearpage\fi%
  \end{center}
}


\newcommand{\folhaderosto}{%
  \setcounter{page}{1}
  \begin{center} 
    \espaco{1.2}
    {\autorformat \ABNTautordata} \par
	% Distance = 12cm - (margin top) - (authors height)
	\setlength{\authorTitleLength}{12cm - 3.2cm - \totalheightof{\vbox{\autorformat \ABNTautordata}}}
	\vspace{\authorTitleLength}
    {\tituloformat \ABNTuppercasetitulodata}

    % comentário
    \vspace{2cm}
    \hspace{.5\textwidth} % posicionando a minipage 
    \begin{minipage}{.49\textwidth}
      \begin{espacoumemeio}
        \begin{sloppypar}
            {\comentarioformat\ABNTcomentariodata}
            \vspace{0.3cm}
        \end{sloppypar}

        \ABNTifnotempty{\ABNTareaconcdata}%
          {%
            {\areaconcnameformat\ABNTareaconcname}
            {\areaconcformat\ABNTareaconcdata}\par%\protect\\
          }
				\ABNTifnotempty{\ABNTorientadordata}%
				    {%
					  \vspace{.8cm}
				      {\orientadornameformat\ABNTorientadorname}
				      {\orientadorformat\ABNTorientadordata}\par%\protect\\
				    }
				\ABNTifnotempty{\ABNTcoorientadordata}
					  {%
						\vspace{.8cm}
					    {\coorientadornameformat\ABNTcoorientadorname}
					    {\coorientadorformat\ABNTcoorientadordata}
					  }
      \end{espacoumemeio} 
    \end{minipage} 

    % local e data
    \vfill
    \begin{espacosimples} 
      {\localformat\ABNTlocaldata}\\
      {\dataformat\ABNTdatadata}
    \end{espacosimples} 
    \if@openright\cleardoublepage\else\clearpage\fi%
  \end{center}
}


%%%%%%  COMMENTS (DOCUMENT TYPE)  %%%%%%

\newcommand{\PoliTipoDocData}{}

%% TCC
\newcommand{\tcc}[1]{%
  \renewcommand{\PoliTipoDocData}{Trabalho de Conclusão de Curso}
  \comentario{Trabalho apresentado à Escola
    Politécnica da Universidade de
    São Paulo para obtenção do
    Título de Engenheiro #1.}%
}

%% Dissertação de mestrado
\newcommand{\dissertacao}[1]{%
  \renewcommand{\PoliTipoDocData}{Dissertação (Mestrado)}
  \comentario{Dissertação apresentada à Escola
    Politécnica da Universidade de
    São Paulo para obtenção do
    Título de Mestre em #1.}%
}

%% Tese de doutorado
\newcommand{\teseDOC}[1]{%
  \renewcommand{\PoliTipoDocData}{Tese (Doutorado)}
  \comentario{Tese apresentada à Escola
    Politécnica da Universidade de
    São Paulo para obtenção do
    Título de Doutor em #1.}%
}

%% Tese de livre docência
\newcommand{\teseLD}{%
  \renewcommand{\PoliTipoDocData}{Tese (Livre Docência)}
  \comentario{%
    Tese apresentada à Escola 
    Politécnica da Universidade
    de São Paulo como requisito 
    para obtenção do Título de 
    Professor Livre Docente junto ao
    \PoliDepartamentoData.}%
  \orientador[~]{}%
  \coorientador[~]{}%
}

%% Memorial de livre docência
\newcommand{\memorialLD}{%
  \renewcommand{\PoliTipoDocData}{Memorial (Livre Docência)}
  \comentario{%
    Memorial apresentado à Escola 
    Politécnica da Universidade
    de São Paulo como requisito  
    para obtenção do Título de 
    Professor Livre Docente junto ao 
    \PoliDepartamentoData.}%
  \orientador[~]{}%
  \coorientador[~]{}%
}


%%%%%%  DEDICATION  %%%%%%

\newcommand{\dedicatoria}[1]
{%
\if@openright\cleardoublepage\else\clearpage\fi%
~\\[17cm]
\vspace*{0pt}
\hspace{.6\textwidth}
\begin{minipage}{.39\textwidth}
	\begin{sloppypar}
	\begin{espacosimples}
		{\comentarioformat #1}
	\end{espacosimples}
	\end{sloppypar}
\end{minipage}
}


%%%%%%  ACKNOWLEDGEMENTS  %%%%%%

\newenvironment{agradecimentos}%
  {%
   \if@openright\cleardoublepage\else\clearpage\fi%
   \pretextualchapter{\POLIagradecimentosname}%
   \begin{espacosimples}%
  }%
  {\end{espacosimples}\newpage}


%%%%%%  EPIGRAPH  %%%%%%

\newcommand{\epigrafe}[1]
{%
\if@openright\cleardoublepage\else\clearpage\fi%
~\\
\vfill
\hspace{.55\textwidth}
\begin{minipage}{.44\textwidth}
	\begin{sloppypar}
	\begin{espacosimples}
		{\comentarioformat #1}
	\end{espacosimples}
	\end{sloppypar}
\end{minipage}
}


%%%%%%  ABSTRACT  %%%%%%
% 10 pt font and single line spacing

\newcommand{\ABNTabstractname}{Abstract}
\renewenvironment{abstract}%
  {%
   \if@openright\cleardoublepage\else\clearpage\fi%
   \ifthenelse{\boolean{ABNThypertoc}}{\renewcommand{\chaptertype}{abstract.}}{}%
   \pretextualchapter{\ABNTabstractname}%
   \ifthenelse{\boolean{ABNThypertoc}}{\renewcommand{\chaptertype}{}}{}%
   \begin{espacosimples}%
  }%
  {\end{espacosimples}\newpage}


%%%%%%  RESUMO  %%%%%%
% 10 pt font and single line spacing

\newcommand{\resumoname}{Resumo}
\newenvironment{resumo}%
  {%
   \if@openright\cleardoublepage\else\clearpage\fi%
   \ifthenelse{\boolean{ABNThypertoc}}{\renewcommand{\chaptertype}{resumo.}}{}%
   \pretextualchapter{\resumoname}%
   \ifthenelse{\boolean{ABNThypertoc}}{\renewcommand{\chaptertype}{}}{}%
   \begin{espacosimples}%
  }%
  {\end{espacosimples}\newpage}


%%%%%%  SIGNATURE SHEET  %%%%%%
% width of the line and text under the line
\newlength{\ABNTsignwidth}
\setlength{\ABNTsignwidth}{8cm}

% thickness of the line
\newlength{\ABNTsignthickness}
\setlength{\ABNTsignthickness}{1pt}

% ammount of space left between previous text and th signature line
\newlength{\ABNTsignskip}
\setlength{\ABNTsignskip}{2.5cm}


%% \assinatura for signature
\newcommand{\assinatura}{\@ifstar{\ABNTsign}{\ABNTcsign}}

% \assinatura styling: typesets centralized
\newcommand{\ABNTsign}[1]{%
  \parbox[t]{\ABNTsignwidth}{\espaco{simples}\vspace*{\ABNTsignskip}\centering%
  \rule{\ABNTsignwidth}{\ABNTsignthickness}\\%
  \nopagebreak #1\par}%
}

% \assinatura* styling: no positioning
\newcommand{\ABNTcsign}[1]%
  {\begingroup\par\centering\ABNTsign{#1}\par\endgroup}

%% Environment folhadeaprovacao 
\newenvironment{folhadeaprovacao}%
  {\if@openright\cleardoublepage\else\clearpage\fi\begingroup}%
  {\endgroup\if@openright\cleardoublepage\else\clearpage\fi}


%%%%%%  TIMES FONT  %%%%%%

\ifthenelse{\boolean{ABNTtimesfont}}% if `times' option enabled...
 {\IfFileExists{mathptmx.sty}%  try `mathptmx' first
    {\RequirePackage{mathptmx}}% 
    {\IfFileExists{mathptm.sty}% if not installed, try `mathptm'
       {\RequirePackage{mathptm}}%
       {\IfFileExists{times.sty} % 
         {\RequirePackage{times}}%
         {\renewcommand{\rmdefault}{ptm}}%
       }%
    }%
  \IfFileExists{helvet.sty}% including also Helvetica as sans serif.
    {\RequirePackage{helvet}}%
    {\IfFileExists{helvetic.sty}%
       {\RequirePackage{helvetic}}%
       {\renewcommand{\rmdefault}{phv}}%
    }%
 }%
 {}


%%%%%%  ARBITRARY PRE TEXTUAL SECTION  %%%%%%

\newenvironment{pretextualsection}[1]%
  {%
   \if@openright\cleardoublepage\else\clearpage\fi%
   \pretextualchapter{#1}%
   \begin{espacosimples}%
  }%
  {\end{espacosimples}\newpage}


%%%%%%  POST SECTION INDENTATION  %%%%%%

\ifthenelse{\boolean{ABNTindentfirst}}%
 {\RequirePackage{indentfirst}}%
 {}

% paragraph indentation size and skip
\setlength{\parindent}{.7cm}
\setlength{\parskip}{.25cm}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  End of POLITEX.CLS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput
