%% hofbook.cls
%% Document class for "Higher-Order Functions in JavaScript" book
%% Designed for LuaLaTeX compilation
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hofbook}[2024/01/01 Higher-Order Functions Book Class]

%% ============================================================================
%% BASE CLASS AND OPTIONS
%% ============================================================================
\LoadClass[11pt,a4paper,openany]{book}

%% ============================================================================
%% REQUIRED PACKAGES
%% ============================================================================

% Encoding and fonts (LuaLaTeX)
\RequirePackage{fontspec}
\RequirePackage{unicode-math}

% Page layout
\RequirePackage[
    a4paper,
    top=2.5cm,
    bottom=2.5cm,
    left=2.5cm,
    right=2.5cm,
    headheight=14pt,
    headsep=1cm,
    footskip=1.5cm
]{geometry}

% Typography
\RequirePackage{microtype}
\RequirePackage{setspace}
\RequirePackage{parskip}

% Colors
\RequirePackage[table,dvipsnames,svgnames]{xcolor}

% Graphics and floats
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{wrapfig}

% Tables
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{longtable}
\RequirePackage{array}
\RequirePackage{multirow}

% Lists
\RequirePackage{enumitem}

% Math
\RequirePackage{amsmath}
% Note: amssymb not needed with unicode-math (conflicts with \eth and other symbols)

% Headers and footers
\RequirePackage{fancyhdr}

% Hyperlinks
\RequirePackage{hyperref}
\RequirePackage{bookmark}

% Captions
\RequirePackage{caption}

% For boxes and environments
\RequirePackage{tcolorbox}
\tcbuselibrary{skins,breakable,listings}

% Indexing
\RequirePackage{imakeidx}

% Bibliography
\RequirePackage[
    backend=biber,
    style=numeric,
    sorting=none
]{biblatex}

%% ============================================================================
%% FONT CONFIGURATION
%% ============================================================================
\setmainfont{Latin Modern Roman}[
    Ligatures=TeX,
    Numbers=Proportional
]
\setsansfont{Latin Modern Sans}[
    Ligatures=TeX,
    Scale=MatchLowercase
]
\setmonofont{JetBrains Mono}[
    Scale=0.85,
    Contextuals=Alternate,
    Ligatures=TeX
]

% Fallback if JetBrains Mono not available
\IfFontExistsTF{JetBrains Mono}{}{%
    \setmonofont{Fira Code}[Scale=0.85]
    \IfFontExistsTF{Fira Code}{}{%
        \setmonofont{Consolas}[Scale=0.85]
        \IfFontExistsTF{Consolas}{}{%
            \setmonofont{Latin Modern Mono}[Scale=0.85]
        }
    }
}

%% ============================================================================
%% COLOR DEFINITIONS
%% ============================================================================

% Primary colors
\definecolor{hofprimary}{HTML}{2563EB}      % Bright blue
\definecolor{hofsecondary}{HTML}{7C3AED}    % Purple
\definecolor{hofaccent}{HTML}{059669}       % Emerald green

% Code colors (One Dark inspired)
\definecolor{codebg}{HTML}{1E1E2E}          % Dark background
\definecolor{codefg}{HTML}{CDD6F4}          % Light foreground
\definecolor{codecomment}{HTML}{6C7086}     % Muted comment
\definecolor{codestring}{HTML}{A6E3A1}      % Green string
\definecolor{codenumber}{HTML}{FAB387}      % Orange number
\definecolor{codekeyword}{HTML}{CBA6F7}     % Purple keyword
\definecolor{codefunction}{HTML}{89B4FA}    % Blue function
\definecolor{codeoperator}{HTML}{89DCEB}    % Cyan operator
\definecolor{codeclass}{HTML}{F9E2AF}       % Yellow class

% UI colors
\definecolor{tipbg}{HTML}{ECFDF5}
\definecolor{tipborder}{HTML}{10B981}
\definecolor{warningbg}{HTML}{FFFBEB}
\definecolor{warningborder}{HTML}{F59E0B}
\definecolor{notebg}{HTML}{EFF6FF}
\definecolor{noteborder}{HTML}{3B82F6}
\definecolor{dangerbg}{HTML}{FEF2F2}
\definecolor{dangerborder}{HTML}{EF4444}

% Table colors
\definecolor{tableheader}{HTML}{F1F5F9}
\definecolor{tablestripe}{HTML}{F8FAFC}

%% ============================================================================
%% HYPERREF CONFIGURATION
%% ============================================================================
\hypersetup{
    colorlinks=true,
    linkcolor=hofprimary,
    citecolor=hofsecondary,
    urlcolor=hofaccent,
    bookmarksnumbered=true,
    bookmarksopen=true,
    bookmarksopenlevel=1,
    pdfstartview=FitH,
    pdfpagemode=UseOutlines
}

%% ============================================================================
%% PAGE STYLES
%% ============================================================================
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE]{\small\nouppercase{\leftmark}}
\fancyhead[RO]{\small\nouppercase{\rightmark}}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

% Chapter page style
\fancypagestyle{plain}{%
    \fancyhf{}
    \fancyfoot[C]{\thepage}
    \renewcommand{\headrulewidth}{0pt}
}

%% ============================================================================
%% CHAPTER AND SECTION STYLING
%% ============================================================================
\RequirePackage{titlesec}

% Part styling
\titleformat{\part}[display]
    {\centering\Huge\bfseries\sffamily}
    {\color{hofprimary}Part \thepart}
    {20pt}
    {\color{hofprimary}\Huge}

% Chapter styling
\titleformat{\chapter}[display]
    {\normalfont\huge\bfseries\sffamily}
    {\color{hofprimary}\chaptertitlename\ \thechapter}
    {20pt}
    {\Huge\color{black}}
\titlespacing*{\chapter}{0pt}{-20pt}{40pt}

% Section styling
\titleformat{\section}
    {\normalfont\Large\bfseries\sffamily\color{hofprimary}}
    {\thesection}
    {1em}
    {}

\titleformat{\subsection}
    {\normalfont\large\bfseries\sffamily\color{hofsecondary}}
    {\thesubsection}
    {1em}
    {}

\titleformat{\subsubsection}
    {\normalfont\normalsize\bfseries\sffamily}
    {\thesubsubsection}
    {1em}
    {}

%% ============================================================================
%% TABLE OF CONTENTS STYLING
%% ============================================================================
\RequirePackage{titletoc}

\titlecontents{part}[0em]
    {\addvspace{2em}\bfseries\large\sffamily}
    {\color{hofprimary}Part \thecontentslabel\quad}
    {}
    {\hfill\contentspage}

\titlecontents{chapter}[1.5em]
    {\addvspace{1em}\bfseries\sffamily}
    {\color{hofprimary}\contentslabel{1.5em}}
    {\color{hofprimary}}
    {\titlerule*[0.5pc]{.}\contentspage}

\titlecontents{section}[3.8em]
    {\sffamily}
    {\contentslabel{2.3em}}
    {}
    {\titlerule*[0.5pc]{.}\contentspage}

\titlecontents{subsection}[6.1em]
    {\small\sffamily}
    {\contentslabel{2.3em}}
    {}
    {\titlerule*[0.5pc]{.}\contentspage}

%% ============================================================================
%% LIST CONFIGURATION
%% ============================================================================
\setlist[itemize]{
    topsep=0.5em,
    itemsep=0.3em,
    parsep=0pt,
    leftmargin=2em
}

\setlist[enumerate]{
    topsep=0.5em,
    itemsep=0.3em,
    parsep=0pt,
    leftmargin=2em
}

\setlist[description]{
    topsep=0.5em,
    itemsep=0.3em,
    parsep=0pt,
    leftmargin=2em,
    font=\bfseries\sffamily\color{hofprimary}
}

%% ============================================================================
%% TABLE STYLING
%% ============================================================================
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}

% Styled table environment
\newenvironment{hoftable}[1][htbp]{%
    \begin{table}[#1]
    \centering
    \rowcolors{2}{tablestripe}{white}
    \renewcommand{\arraystretch}{1.4}
}{%
    \end{table}
}

% Styled tabular header
\newcommand{\hoftablehead}[1]{%
    \rowcolor{tableheader}
    \textbf{\sffamily #1}
}

%% ============================================================================
%% CAPTION STYLING
%% ============================================================================
\captionsetup{
    font={small,sf},
    labelfont={bf,color=hofprimary},
    labelsep=colon,
    skip=10pt
}

%% ============================================================================
%% CUSTOM COMMANDS
%% ============================================================================

% Inline code
\newcommand{\code}[1]{\texttt{\small\colorbox{gray!10}{#1}}}

% Keyboard key
\newcommand{\key}[1]{%
    \tikz[baseline=(key.base)]{
        \node[
            draw=gray!50,
            fill=gray!10,
            rounded corners=2pt,
            inner sep=2pt,
            font=\small\ttfamily
        ] (key) {#1};
    }%
}

% Function name styling
\newcommand{\func}[1]{\texttt{\color{codefunction}#1}}

% Keyword styling
\newcommand{\keyword}[1]{\texttt{\color{codekeyword}#1}}

% Emphasis for concepts
\newcommand{\concept}[1]{\textbf{\color{hofprimary}#1}}

% Arrow for pipelines
\newcommand{\pipeArrow}{\ensuremath{\rightarrow}}

% HOF notation
\newcommand{\hof}[1]{\textsc{#1}}

%% ============================================================================
%% DOCUMENT METADATA COMMANDS
%% ============================================================================
\newcommand{\booksubtitle}[1]{\gdef\@booksubtitle{#1}}
\newcommand{\@booksubtitle}{}

\newcommand{\bookversion}[1]{\gdef\@bookversion{#1}}
\newcommand{\@bookversion}{1.0}

\newcommand{\bookrepo}[1]{\gdef\@bookrepo{#1}}
\newcommand{\@bookrepo}{}

%% ============================================================================
%% TITLE PAGE
%% ============================================================================
\renewcommand{\maketitle}{%
    \begin{titlepage}
        \centering
        \vspace*{2cm}

        {\Huge\bfseries\sffamily\color{hofprimary}\@title\par}

        \vspace{0.5cm}

        \ifx\@booksubtitle\empty\else
            {\Large\sffamily\color{hofsecondary}\@booksubtitle\par}
        \fi

        \vspace{2cm}

        % Decorative element
        {\color{hofprimary}\rule{0.6\textwidth}{2pt}}

        \vspace{2cm}

        {\Large\sffamily\@author\par}

        \vfill

        {\normalsize Version \@bookversion}

        \vspace{0.5cm}

        {\normalsize\@date\par}

        \ifx\@bookrepo\empty\else
            \vspace{0.5cm}
            {\small\color{hofaccent}\href{\@bookrepo}{\@bookrepo}\par}
        \fi
    \end{titlepage}
}

%% ============================================================================
%% EPIGRAPH (CHAPTER QUOTES)
%% ============================================================================
\newcommand{\chapterquote}[2]{%
    \begin{flushright}
        \begin{minipage}{0.7\textwidth}
            \itshape ``#1''
            \vspace{0.3em}

            \normalfont\small --- #2
        \end{minipage}
    \end{flushright}
    \vspace{1em}
}

%% ============================================================================
%% INDEX CONFIGURATION
%% ============================================================================
\makeindex[columns=2, title=Index, intoc]

\endinput
