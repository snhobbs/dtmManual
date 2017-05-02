\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{manual}
%\usepackage{indentfirst}
%    ****************************************
%    *               OPTIONS                *
%    ****************************************
%
% 

\newcommand\@masters{}
\DeclareOption{phd}{\renewcommand\@masters{0}}
\DeclareOption{masters}{\renewcommand\@masters{1}}
\DeclareOption{oldmasters}{\renewcommand\@masters{2}}
\ExecuteOptions{phd}

%\newcommand{\logo}[1]{\def \logoName {#1}}


% \FIXME{} is a useful macro for noting things needing to be changed.
% The following definition will also output a warning to the console
\newcommand{\FIXME}[1]{\typeout{**FIXME** #1}\textbf{[FIXME: #1]}}
\newcommand{\NOTE}[1]{\textbf{Note:} #1}
\newcommand{\hypNote}[2]{\href{#2}{#1}\footnote{\url{#2}}}

\newcommand{\memsection}[4]{%
  % define the height of the memsection
  \bytefieldsetup{bitheight=#3\baselineskip}%
  \bitbox[]{10}{%
    \texttt{#1}%      print end address
    \\
    %   do some spacing
    \vspace{#3\baselineskip}
    \vspace{-2\baselineskip}
    \vspace{-#3pt}
    \texttt{#2}%      print start address
  }%
  \bitbox{16}{#4}%    print box with caption
}

\newcommand{\colorbitbox}[3]{%
	\rlap{\bitbox{#2}{\color{#1}\rule{\width}{\height}}}%
	\bitbox{#2}{#3}
}

\newcommand{\memsectioncolor}[5]{%
  % define the height of the memsection
  \bytefieldsetup{bitheight=#3\baselineskip}%
  \bitbox[]{10}{%
    \texttt{#1}%      print end address
    \\
    %   do some spacing
    \vspace{#3\baselineskip}
    \vspace{-2\baselineskip}
    \vspace{-#3pt}
    \texttt{#2}%      print start address
  }%
  \colorbitbox{#4}{16}{#5}%    print box with caption
}


\newcommand\thes@sidedness{-1}
\DeclareOption{oneside}
  {\renewcommand\thes@sidedness{1}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{twoside}
  {\renewcommand\thes@sidedness{2}\PassOptionsToClass{\CurrentOption}{memoir}}

%  Changing the default point size from 10pt to 12pt uses a similar procedure,
%  but it's messier.

\newcommand\thes@ptsize{0}
\DeclareOption{9pt}
  {\renewcommand\thes@ptsize{9}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{10pt}
  {\renewcommand\thes@ptsize{10}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{11pt}
  {\renewcommand\thes@ptsize{11}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{12pt}
  {\renewcommand\thes@ptsize{12}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{14pt}
  {\renewcommand\thes@ptsize{14}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{17pt}
  {\renewcommand\thes@ptsize{17}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{20pt}
  {\renewcommand\thes@ptsize{20}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{25pt}
  {\renewcommand\thes@ptsize{25}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{30pt}
  {\renewcommand\thes@ptsize{30}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{36pt}
  {\renewcommand\thes@ptsize{36}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{48pt}
  {\renewcommand\thes@ptsize{48}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{60pt}
  {\renewcommand\thes@ptsize{60}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{*pt}
  {\renewcommand\thes@ptsize{99}\PassOptionsToClass{\CurrentOption}{memoir}}

% Other options are passed on to the memoir class.

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

% The \ProcessOptions command causes the execution of every option command
% FOO which is declared and for which the user typed the FOO option in his
% \documentclass.  For every undeclared option BAR there will be a warning
% message. (BBF 10/31/94)

\ProcessOptions\relax

% Take care of changed defaults

\ifnum\thes@sidedness<0
  \PassOptionsToClass{oneside}{memoir}
  \renewcommand\thes@sidedness{1}
\fi

\ifnum\thes@ptsize=0
  \PassOptionsToClass{12pt}{memoir}
  \renewcommand\thes@ptsize{12}
\fi

% Now load the memoir class, and configure it appropriately.

\LoadClass{memoir}

\setlrmarginsandblock{1in}{*}{*}
  \@tempdima=1in  \advance\@tempdima 25pt \advance\@tempdima\normalbaselineskip
  \@tempdimb=.75in  \advance\@tempdimb 30pt
\setulmarginsandblock{\@tempdima}{\@tempdimb}{*}

\AtBeginDocument{\checkandfixthelayout}

% The Grad. Division requires that "Placement of page numbers must be
% consistent throughout."

\pagestyle{simple}
\aliaspagestyle{book}{simple}
\aliaspagestyle{part}{simple}
\aliaspagestyle{chapter}{simple}
\aliaspagestyle{title}{simple}

% Issue warnings if the settings are not appropriate for a final copy

\ifnum\thes@sidedness=2\relax
  \ifdraftdoc\else
  \ClassWarningNoLine{manual}{^^J\@spaces
 ****** Use the twoside option only for drafts. \@spaces\@spaces ******}
\fi\fi

\ifnum\thes@ptsize<12\relax
  \ifdraftdoc\else
  \ClassWarningNoLine{manual}{^^J\@spaces
 ****** Use the \thes@ptsize pt option only for drafts. \@spaces\@spaces
 ******^^J\@spaces
 ****** The Graduate Division requires 12-point type ******^^J\@spaces
 ****** or larger for the final version.\space\@spaces\@spaces\@spaces
 ******}
\fi\fi

% For some environments we switch back to single-spacing, also
% provides \dsp in case you need double-spacing where single-spacing
% is otherwise used.

\newcommand\ssp{\SingleSpacing}
\newcommand\dsp{\setSpacing{1.5}}

% Table of contents, lists of figures, and lists of tables should always
% be single-spaced.  If one wants them to be double-spaced instead (in a
% double-spaced document), the original macros are available as
% \memoirtableofcontents, \memoirlistoffigures, and \memoirlistoftables.

\let\memoirtableofcontents=\tableofcontents
\renewcommand\tableofcontents{\begin{SingleSpace}\memoirtableofcontents
  \end{SingleSpace}}

\let\memoirlistoffigures=\listoffigures
\renewcommand\listoffigures{\begin{SingleSpace}\memoirlistoffigures
  \end{SingleSpace}}

\let\memoirlistoftables=\listoftables
\renewcommand\listoftables{\begin{SingleSpace}\memoirlistoftables
  \end{SingleSpace}}

%  draft option (this is where the draft option is actually implemented)
%
\ifnum\@masters>1			% if oldmasters
  \ifdraftdoc \else
    \dsp				% Set to double spacing
  \fi
\fi

% \smallssp is used to produce tabular environments in the small font.
% This is required because single-spacing requires a change in font size.
% \scriptsizessp is a still smaller version of the same thing.
% Removed 09/2011

% \def\smallssp{\small\SingleSpacing}
% \def\scriptsizessp{\scriptsize\SingleSpacing}


%  Masters theses may not be called dissertations
%

\newcommand\@dissertation{\ifnum\@masters=0
  dissertation
\else
  thesis
\fi}


% PREPARING A FOREIGN LANGUAGE VERSION:
%
% This document class is for documents prepared in the English language.
% To prepare a version for another language, various English words must
% be replaced.  Many of the English words that require replacement are
% indicated in the documentation for the memoir class, currently in
% Section 18.20, Words and Phrases.
%
% Other English words that need replacement can be found in the macros
% supporting the title and approval pages.
%

% acknowledge environment:
\newcommand\acknowledgename{Acknowledgments}

%    ****************************************
%    *             FRONT MATTER             *
%    ****************************************
%


% The alwayssingle environment ensures that front matter is always
% single column even in a double-column document.

\newenvironment{alwayssingle}
  {\if@twocolumn\@restonecoltrue\onecolumn \else \@restonecolfalse\newpage \fi}
  {\if@restonecol \twocolumn \else \newpage \fi}

% \maketitle outputs the complete titlepage.  It requires all the
% above macros.  It is probably not correct for joint (e.g. UCSD/SDSU) degrees.

% Set the font that will be used in the front matter headings
\def\fmfont{\fontsize\@xiipt{14.5}\selectfont}
\def\fmsmallfont{\fontsize\@xiipt{14pt}\selectfont}

%\********************************************************************************
% Definition of front page
%\********************************************************************************
%Front Page
%\makeatletter
\newlength\drop
\newcommand*{\titleGM}{%
\thispagestyle{empty}
\begingroup% Gentle Madness
% \drop = 0.1\textheight
% \vspace*{\baselineskip}
\vfill
\hbox{%
  \hspace*{0.2\textwidth}%
  \rule{1pt}{\dimexpr\textheight-28pt\relax}%
  \hspace*{0.05\textwidth}% 
  \parbox[b]{0.75\textwidth}{%
    \vbox{%
      \vspace{\drop}
 	  \includegraphics[width = 0.2\paperwidth]{\logoName}\newline \newline
      {\Huge\raggedright\secTitle\par}
      \vspace{0.04\textheight}
      {\Huge\raggedright\@title\par}
      {\Large\raggedright\today\par }
      \vspace{0.2\textheight}
      {\Large\textbf{\edition}\par}
    }% end of vbox
  }% end of parbox
}% end of hbox
\vfill
\endgroup}
%\makeatother


\def\makeTopPage{
{\ssp
\begin{alwayssingle}
    \let\footnotesize\small
    \let\footnoterule\relax
    \thispagestyle{empty}
    \setcounter{page}{1}

    \null\vfil
  \begin{center}
    \fmfont
    \includegraphics[width = 0.2\paperwidth]{\logoName}
        \bigskip
        \par
        \bigskip \medskip
        \par
        \bigskip \medskip
        
    \LARGE{\textbf{\@title}}\par
	\vspace{12ex}
	%\end{center}
	
	{\raggedright\LARGE{\textbf{D}igitizer $\&$ \\ \textbf{T}rigger \\ \textbf{M}odule}\par}
	%\vspace{18ex}
	
	%\begin{center}
    {\vspace{1in}
    \textbf{\edition}
    
     TRIUMF\par
     \smallskip \medskip
    }
  \end{center}
  
    \vfil\null
\end{alwayssingle}

\setcounter{footnote}{0}
}}


%/************************************************************************************************
% Define description page 
%************************************************************************************************/

\def\makeDescriptPage{
{\ssp
\begin{alwayssingle}
    \let\footnotesize\small
    \let\footnoterule\relax
    \thispagestyle{empty}
    \setcounter{page}{1}

    \null\vfil
  \begin{center}
    \fmfont
    \textbf{\@title}\par
    \medskip
    \edition\par
    \bigskip \medskip\par 
    compiled by \par
    \bigskip \medskip
    {\@author} \par
\vspace{6ex}
\vspace{6ex}
    % {\@prevdegrees} \par
% \vspace{6ex}
    \bigskip
    \par
    \bigskip \medskip
    \bigskip \medskip
    \vspace{6ex}
    \vspace{6ex} \par
    {\vspace{1in}
 	TRIUMF	\par
     \smallskip \medskip
    }

  \end{center}
  
    \vfil\null
\end{alwayssingle}
\setcounter{footnote}{0}
}}



% DEDICATION
%
% The dedication environment just makes sure the dedication gets its
% own page.

\newenvironment{dedication}
  {\begin{alwayssingle}}
  {\end{alwayssingle}}

% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered
% "Acknowledgements" label at the top of the page.

\newenvironment{acknowledgements}
  {\begin{alwayssingle}
    \begin{center}
    {\large \bfseries \acknowledgename}
    \end{center}
  }
  {\end{alwayssingle}}

% FRONTMATTER environment
%
% The FRONTMATTER environment makes sure that page numbering is set
% correctly (roman, lower-case, starting at 3) for the front matter
% that follows the abstract.  It also resets page-numbering for
% the remainder of the dissertation (arabic, starting at 1).

\renewenvironment{frontmatter}
  {\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
  {\newpage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}



\endinput
