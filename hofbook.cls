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
% Note: unicode-math removed due to incompatibility with tcolorbox in LuaLaTeX/TeX Live 2025
% \RequirePackage{unicode-math}

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

% Workaround for tcolorbox 6.9.0 / TeX Live 2025 tagging compatibility
% Provide stub implementations for tagging commands before loading tcolorbox
\ExplSyntaxOn
% Provide stub for tag_suspend:n if not defined
\cs_if_exist:NF \tag_suspend:n
{
  \cs_new_protected:Npn \tag_suspend:n #1 {}
}
% Provide stub for tag_resume:n if not defined
\cs_if_exist:NF \tag_resume:n
{
  \cs_new_protected:Npn \tag_resume:n #1 {}
}
\ExplSyntaxOff

% For boxes and environments
\RequirePackage{tcolorbox}
\tcbuselibrary{skins,breakable,listings}

% Workaround: Define missing tcolorbox internal commands for TeX Live 2025 tagging
% These must be defined AFTER tcolorbox loads (no makeatletter needed in class file)
\providecommand{\tcb@insert@after@upper}{}
\providecommand{\tcb@insert@after@lower}{}
\providecommand{\tcb@insert@after@part}{}

% TikZ for advanced graphics
\RequirePackage{tikz}
\usetikzlibrary{calc,positioning,shapes.geometric,arrows.meta,decorations.pathmorphing,backgrounds,fit,fadings}

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

% Styled table environment (float)
\newenvironment{hoftable}[1][htbp]{%
    \begin{table}[#1]
    \centering
    \rowcolors{2}{tablestripe}{white}
    \renewcommand{\arraystretch}{1.4}
}{%
    \end{table}
}

% Non-floating styled table (for use inside tcolorbox/summary environments)
\newenvironment{hoftable*}{%
    \centering
    \rowcolors{2}{tablestripe}{white}
    \renewcommand{\arraystretch}{1.4}
}{}

% Styled tabular header (use \cellcolor instead of \rowcolor for multi-column support)
\newcommand{\hoftablehead}[1]{%
    \cellcolor{tableheader}\textbf{\sffamily #1}
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
%% TITLE PAGE - STUNNING VISUAL DESIGN
%% ============================================================================

% Title page colors
\definecolor{titlebg}{HTML}{0f172a}           % Deep navy
\definecolor{titlebg2}{HTML}{1e1b4b}          % Deep purple-navy
\definecolor{titlegold}{HTML}{fbbf24}         % Bright gold
\definecolor{titlecyan}{HTML}{22d3ee}         % Bright cyan
\definecolor{titlepurple}{HTML}{a78bfa}       % Light purple
\definecolor{titleblue}{HTML}{3b82f6}         % Bright blue
\definecolor{codegray}{HTML}{374151}          % Code background

\renewcommand{\maketitle}{%
    \begin{titlepage}
        \thispagestyle{empty}
        \begin{tikzpicture}[remember picture, overlay]

            %% ========== BACKGROUND ==========
            % Gradient background
            \fill[titlebg] (current page.south west) rectangle (current page.north east);

            % Subtle gradient overlay
            \shade[top color=titlebg2, bottom color=titlebg, opacity=0.7]
                (current page.south west) rectangle (current page.north east);

            %% ========== FLOATING CODE SNIPPETS (Background) ==========
            % Top-right code snippet
            \node[rotate=-12, opacity=0.08, text=white, font=\ttfamily\small, anchor=north east]
                at ($(current page.north east) + (-1.5cm,-3cm)$) {
                \begin{tabular}{l}
                const compose = (...fns) =>\\
                \quad x => fns.reduceRight(\\
                \quad\quad (acc, fn) => fn(acc), x\\
                \quad );
                \end{tabular}
            };

            % Bottom-left code snippet
            \node[rotate=8, opacity=0.06, text=white, font=\ttfamily\small, anchor=south west]
                at ($(current page.south west) + (0.5cm,2cm)$) {
                \begin{tabular}{l}
                const pipe = (...fns) =>\\
                \quad x => fns.reduce(\\
                \quad\quad (acc, fn) => fn(acc), x\\
                \quad );
                \end{tabular}
            };

            % Middle-left lambda
            \node[opacity=0.04, text=titlegold, font=\fontsize{180}{180}\selectfont, anchor=west]
                at ($(current page.west) + (0.5cm,2cm)$) {λ};

            %% ========== GEOMETRIC DECORATIONS ==========
            % Top decorative circles
            \foreach \i in {1,...,5} {
                \fill[titlecyan, opacity={0.03 + \i*0.01}]
                    ($(current page.north west) + (2cm + \i*1.2cm, -1cm - \i*0.3cm)$)
                    circle ({0.3cm + \i*0.15cm});
            }

            % Bottom decorative circles
            \foreach \i in {1,...,4} {
                \fill[titlepurple, opacity={0.02 + \i*0.01}]
                    ($(current page.south east) + (-3cm - \i*1.5cm, 2cm + \i*0.5cm)$)
                    circle ({0.4cm + \i*0.2cm});
            }

            % Diagonal lines accent
            \foreach \i in {0,...,8} {
                \draw[titlegold, opacity=0.03, line width=0.5pt]
                    ($(current page.north east) + (-\i*0.8cm, 0)$) --
                    ($(current page.north east) + (-\i*0.8cm - 4cm, -4cm)$);
            }

            %% ========== MAIN CONTENT ==========

            % Small "JavaScript" label at top
            \node[anchor=north, font=\sffamily\large\bfseries, text=codegray,
                  fill=titlegold, rounded corners=3pt, inner sep=8pt]
                at ($(current page.north) + (0,-2cm)$) {JAVASCRIPT};

            % Main Title - "Higher-Order"
            \node[anchor=south, font=\sffamily\fontsize{42}{48}\selectfont\bfseries, text=white]
                (title1) at ($(current page.center) + (0,4.5cm)$) {Higher-Order};

            % Main Title - "Functions"
            \node[anchor=north, font=\sffamily\fontsize{52}{58}\selectfont\bfseries, text=titlegold]
                (title2) at ($(current page.center) + (0,4cm)$) {Functions};

            % Decorative line under title
            \draw[titlegold, line width=2pt]
                ($(title2.south west) + (1cm,-0.3cm)$) -- ($(title2.south east) + (-1cm,-0.3cm)$);

            % Subtitle
            \node[anchor=north, font=\sffamily\Large, text=white!80]
                (subtitle) at ($(title2.south) + (0,-1cm)$) {\@booksubtitle};

            %% ========== PIPELINE VISUALIZATION ==========
            \begin{scope}[shift={($(current page.center) + (0,-1.5cm)$)}]
                % Pipeline background
                \fill[codegray, rounded corners=8pt, opacity=0.6]
                    (-6cm,-1.2cm) rectangle (6cm,1.2cm);

                % Data box
                \node[draw=titlecyan, fill=titlebg, rounded corners=4pt,
                      minimum width=1.8cm, minimum height=0.9cm, line width=1.5pt,
                      font=\ttfamily\small, text=titlecyan] (data) at (-4.5cm,0) {[data]};

                % Arrow 1
                \draw[-{Stealth[scale=1.2]}, titlecyan, line width=2pt]
                    (data.east) -- ++(0.6cm,0);

                % map() box
                \node[draw=titlegold, fill=titlebg, rounded corners=4pt,
                      minimum width=1.5cm, minimum height=0.9cm, line width=1.5pt,
                      font=\ttfamily\small\bfseries, text=titlegold] (map) at (-2.2cm,0) {map()};

                % Arrow 2
                \draw[-{Stealth[scale=1.2]}, titlegold, line width=2pt]
                    (map.east) -- ++(0.6cm,0);

                % filter() box
                \node[draw=titlepurple, fill=titlebg, rounded corners=4pt,
                      minimum width=1.5cm, minimum height=0.9cm, line width=1.5pt,
                      font=\ttfamily\small\bfseries, text=titlepurple] (filter) at (0.2cm,0) {filter()};

                % Arrow 3
                \draw[-{Stealth[scale=1.2]}, titlepurple, line width=2pt]
                    (filter.east) -- ++(0.6cm,0);

                % reduce() box
                \node[draw=titleblue, fill=titlebg, rounded corners=4pt,
                      minimum width=1.8cm, minimum height=0.9cm, line width=1.5pt,
                      font=\ttfamily\small\bfseries, text=titleblue] (reduce) at (2.8cm,0) {reduce()};

                % Arrow 4
                \draw[-{Stealth[scale=1.2]}, titleblue, line width=2pt]
                    (reduce.east) -- ++(0.6cm,0);

                % Result box
                \node[draw=white, fill=titlebg, rounded corners=4pt,
                      minimum width=1.5cm, minimum height=0.9cm, line width=1.5pt,
                      font=\ttfamily\small, text=white] (result) at (4.8cm,0) {result};
            \end{scope}

            %% ========== AUTHOR & INFO ==========
            % Author name
            \node[anchor=south, font=\sffamily\LARGE, text=white]
                (author) at ($(current page.center) + (0,-4.5cm)$) {\@author};

            % Decorative dots around author
            \fill[titlegold] ($(author.west) + (-0.5cm,0)$) circle (3pt);
            \fill[titlegold] ($(author.east) + (0.5cm,0)$) circle (3pt);

            %% ========== BOTTOM INFO BAR ==========
            % Version badge
            \node[anchor=south west, font=\sffamily\small, text=white!60,
                  fill=codegray, rounded corners=3pt, inner sep=6pt]
                at ($(current page.south west) + (2cm,2cm)$) {v\@bookversion};

            % Repository link
            \ifx\@bookrepo\empty\else
                \node[anchor=south, font=\ttfamily\small, text=titlecyan!80]
                    at ($(current page.south) + (0,2cm)$) {\@bookrepo};
            \fi

            % Date
            \node[anchor=south east, font=\sffamily\small, text=white!60]
                at ($(current page.south east) + (-2cm,2cm)$) {\@date};

            %% ========== CORNER ACCENTS ==========
            % Top-left corner accent
            \draw[titlegold, line width=3pt]
                ($(current page.north west) + (1cm,-1cm)$) -- ++(2cm,0);
            \draw[titlegold, line width=3pt]
                ($(current page.north west) + (1cm,-1cm)$) -- ++(0,-2cm);

            % Bottom-right corner accent
            \draw[titlecyan, line width=3pt]
                ($(current page.south east) + (-1cm,1cm)$) -- ++(-2cm,0);
            \draw[titlecyan, line width=3pt]
                ($(current page.south east) + (-1cm,1cm)$) -- ++(0,2cm);

        \end{tikzpicture}
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
