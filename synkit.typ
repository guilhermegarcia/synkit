#import "lib.typ": *
#import "@preview/fontawesome:0.5.0": *
#import "@preview/phonokit:0.5.4": *
#show: eg-rules

#let myYellow = rgb(247, 140, 70)     // Laval yellow/orange
#let in-pratique = state("in-pratique", false)

#let new(content) = highlight(fill: rgb("#27ae60").lighten(80%))[#content]

#let important(title: "", content) = [
  #in-pratique.update(true)
  #block(
    fill: myYellow.lighten(85%),
    stroke: (left: 3pt + myYellow),
    inset: 1em,
    radius: 0.3em,
    width: 100%,
  )[
    *#title* #content
  ]
  #in-pratique.update(false)
]

// NOTE: Code styling (context-aware for pratique slides)
#show raw.where(block: false): it => context {
  let c = if it.lang == none and it.text.starts-with("#") {
    raw(it.text, lang: "typ")
  } else {
    it
  }
  let size = if it.text.starts-with("#") { 1.15em } else { 1.1em }
  let bg = if in-pratique.get() { myYellow.lighten(70%) } else { rgb("#f0f0f0") }
  box(
    fill: bg,
    inset: (x: 3pt, y: 0pt),
    outset: (y: 4pt),
    radius: 3pt,
    text(
      font: "Berkeley Mono",
      ligatures: true,
      discretionary-ligatures: true,
      historical-ligatures: true,
      size: size,
      fill: blue.darken(10%),
      c,
    ),
  )
}




// Logo:
#let kit = text(font: "Charis", fill: blue.darken(5%))[*#emph[k]it*]
#let logo = text(font: "Charis")[*syn*#kit]

#let phonokit = text(font: "Charis")[*phono*#kit]



// Section tags:
#let new-dot = text(fill: rgb("#27ae60"), size: 1em)[ ●]
#let recent-dot = text(fill: rgb("#f39c12"), size: 1em)[ ●]

#set math.equation(numbering: "(1)")
// #show raw.where(block: false): it => {
//   let content = if it.lang == none and it.text.starts-with("#") {
//     raw(it.text, lang: "typ")
//   } else {
//     it
//   }
//   let size = if it.text.starts-with("#") { 1.1em } else { 1em }
//   box(
//     fill: rgb("#f0f0f0"),
//     inset: (x: 3pt, y: 0pt),
//     outset: (y: 4pt),
//     radius: 3pt,
//     text(font: "Berkeley Mono", size: size, fill: rgb("#c7254e"), content),
//   )
// }
//
// NOTE: Code block
#show raw.where(block: true): it => {
  set text(font: "Berkeley Mono", size: 1em)
  block(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
    width: auto,
    it,
  )
}

// NOTE: Paragraph
#set par(
  first-line-indent: 2em,
  spacing: 1em,
  leading: 1em,
  justify: true,
  hanging-indent: 0em,
)

// #set figure(supplement: "Fig.")
#set figure(gap: 1em)

// NOTE: Text
#set text(font: "Libertinus Serif", size: 10pt, lang: "en", hyphenate: auto, number-type: "old-style")

// NOTE: Margins
#set page(
  // fill: luma(50),
  margin: (
    top: 2cm,
    bottom: 2cm,
    left: 2.5cm,
    right: 2.5cm,
  ),
  numbering: "1 of 1",
  number-align: center,
  footer: context {
    let abspage = locate(here()).page()
    if abspage != 1 {
      align(center, counter(page).display("– 1 –"))
    }
  },
)

// NOTE: Define LaTeX command/logo
#let LaTeX = {
  let A = (
    offset: (
      x: -0.33em,
      y: -0.3em,
    ),
    size: 0.7em,
  )
  let T = (
    x_offset: -0.12em,
  )
  let E = (
    x_offset: -0.2em,
    y_offset: 0.23em,
    size: 1em,
  )
  let X = (
    x_offset: -0.1em,
  )
  [L#h(A.offset.x)#text(size: A.size, baseline: A.offset.y)[A]#h(T.x_offset)T#h(E.x_offset)#text(size: E.size, baseline: E.y_offset)[E]#h(X.x_offset)X]
}

// NOTE: Define LaTeXiT command/logo
#let LaTeXiT = {
  let A = (
    offset: (
      x: -0.33em,
      y: -0.3em,
    ),
    size: 0.7em,
  )
  let T = (
    x_offset: -0.12em,
  )
  let E = (
    x_offset: -0.2em,
    y_offset: 0.23em,
    size: 1em,
  )
  let X = (
    x_offset: -0.1em,
  )
  let I = (
    x_offset: -0.1em,
  )
  [L#h(A.offset.x)#text(size: A.size, baseline: A.offset.y)[A]#h(T.x_offset)T#h(E.x_offset)#text(size: E.size, baseline: E.y_offset)[E]#h(X.x_offset)X#h(I.x_offset)#text(size: E.size, baseline: E.y_offset)[I]#h(T.x_offset)#text(size: A.size, baseline: A.offset.y, weight: 800)[T]]
}

// NOTE: Adjust heading numbering and justification
#set heading(
  numbering: "1.1.",
)

#show heading: it => {
  v(1em)
  it
  v(0.5em)
}

#show figure: it => {
  // Exclude linguistic-subexample from spacing (they're inline in table cells)
  // linguistic-example figures should still get spacing like other figures
  if it.kind == "linguistic-subexample" {
    it
  } else {
    v(1em)
    it
    v(1em)
  }
}

#show grid: it => {
  v(1em)
  it
  v(1em)
}

#let abstract(body) = {
  align(center)[*Abstract*]
  v(0.5em)
  align(center)[
    #block(width: 85%)[
      #align(left)[
        #par(justify: true, leading: 0.8em, first-line-indent: 0pt)[
          #set text(size: 0.9em)
          #body
        ]
      ]
    ]
  ]
  v(1em)
}

// NOTE: Link colors
#show link: set text(fill: blue)
#show ref: set text(fill: rgb(200, 0, 0))

#let version = text(size: 0.8em)[`v 0.0.1`]

// NOTE: Begin doc here
#title([#logo #h(1fr) #version])
_A toolkit to create syntactic representations in Typst_

#grid(
  columns: (1fr, auto),
  [Guilherme D. Garcia #link("https://orcid.org/0000-0003-1412-3856")[#box(baseline: 20%, image("orcid.svg", height: 1em))]\
    #par(leading: 0.8em, first-line-indent: 0pt)[#text(
      size: 0.7em,
    )[Pavillon Charles-De Koninck, 1030, Bureau DKN-3267\
      Département de langues, linguistique et traduction, #smallcaps[Université Laval] \
      Avenue des Sciences-Humaines, Québec QC, Canada\
      #fa-earth-americas() #link("https://gdgarcia.ca")[`gdgarcia.ca`] #fa-github() #link(
        "https://github.com/guilhermegarcia",
      )[`guilhermegarcia`] #fa-envelope() #link(
        "mailto: guilherme.garcia@lli.ulaval.ca",
      )[`guilherme.garcia@lli.ulaval.ca`]]]],
  // [#link("")[#image("zenodo-badge.svg", height: 1em)]
  // ],
)

#v(10em)

#abstract[
  #logo is a Typst package for drawing syntax trees from bracket notation. It supports a wide range of features, including triangles, arrows, movement traces, multidominance, semantic annotation, cross-tree equivalence lines, and formatting options for quick adjustments. Trees can be drawn in four directions (down, up, left, right), and multiple trees can be stacked with shared arrow connections. Besides trees, the package also offers functions for numbered examples and glosses. This document serves as the official documentation for #logo, providing examples and explanations for all available parameters and features.
]

#v(3em)

// #align(center, text(size: 0.85em)[
//   How to keep track of updates? See table of contents on the next page.
//
//   #new-dot = new feature #h(1.5em) #recent-dot = recent update or change])
//
//

// #pagebreak()

#heading(numbering: none, outlined: false)[Questions, suggestions, bugs]

Any questions, comments or suggestions should be posted to the repository below (issues). All the bugs you find will help improve the package! Simply #link("https://github.com/guilhermegarcia/synkit/issues")[open an issue].

#v(2em)

#fa-earth-americas() #link("https://gdgarcia.ca/synkit")[`gdgarcia.ca/synkit`]

#fa-github() #link("https://github.com/guilhermegarcia/synkit")[`guilhermegarcia/synkit`]

#fa-comment() #link("https://github.com/guilhermegarcia/synkit/discussions")[`guilhermegarcia/synkit/discussions`]

#fa-bug() #link("https://github.com/guilhermegarcia/synkit/issues")[`guilhermegarcia/synkit/issues`]

#heading(numbering: none, outlined: false)[Note on development]

#logo was conceived, designed, and directed by the author. The implementation was produced with the assistance of Claude (Anthropic). All linguistic decisions, function design, and package architecture are the author's.

#heading(numbering: none, outlined: false)[Version history]

`0.0.1` - Initial release \


#pagebreak()

#outline(depth: 3, title: "Table of contents")

// #v(1fr)
// #align(right)[
//   #text(fill: gray)[_Last updated on #datetime.today().display("[month repr:long] [day], [year]")_]
// ]


#pagebreak()

= Introduction <sec-intro>

This vignette introduces #logo and its functions. If you haven't used Typst yet and want to follow along, go to #link("https://typst.app")[Typst.app] to use their online editor. You may want to check their own #link("https://typst.app/docs/tutorial/")[tutorial] too (I have an introductory YouTube series #link("https://www.youtube.com/playlist?list=PL3Qku9eEGkK25vbfHx_YUpvNNogYAqt3N")[here]). This is *not* an introduction to Typst, but see @app-editor and @app-packages in the appendix for some useful info. The GitHub repository for the package can be found at `guilhermegarcia/synkit`. Comments and suggestions are welcome, as are bug reports (open an issue in the package's repository). As with #phonokit, the main goals of #logo are to #smallcaps("minimize effort") and #smallcaps("maximize quality"). In a nutshell, we want more intuitive and parsimonious code than #LaTeX without compromising the quality of what is created.

There are at least two fantastic packages for #LaTeX to build syntax trees: `tikz-qtree` @tikz-qtree and `forest` @forest. For Typst, some options also exist: `syntree`, by Lynn (see #link("https://typst.app/universe/package/syntree")[here]) and `arborly`, by Max Pearce Basman (see #link("https://typst.app/universe/package/arborly")[here]). Both Typst options are indeed easier to use than anything we have for #LaTeX, but they're also more limited. Thus, as of March 2026, we don't really have a syntax package that ticks enough boxes for people to consider migrating to Typst from #LaTeX. This is the gap that #logo addresses. My main goal here is to be as intuitive as possible while keeping the key features of packages used in #LaTeX. Eventually, #logo should be able to cover everything that you need in syntax (which will likely be a subset of what the #LaTeX packages in question can do). I have some opinions about how an intuitive function should work, so a lot of what follows is subjective --- this is also something I've applied to my other package, #phonokit. I realize that linguists can't simply migrate to Typst without enough coverage, and that coverage must include things like syntax trees, of course.

I am not a syntactician myself. Thus, if this package ends up being adopted by enough linguists, it would be ideal to have more people in syntax to join the project to maintain the existing functions and features.

== Installation <sec-installation>

Typst packages are always loaded the same way: using the `#import` function at the top of your `typ` document, as shown in @code-import1. Replace `X.X.X` with the version you wish to import. The `*` simply states that we want to import all functions from the package in question. See the package's page on Typst's website #link("https://typst.app/universe/package/synkit")[here].

#figure(
  caption: [Loading a package in Typst using the official repository],
  supplement: "Code",
  kind: "code",
  ```typst
  #import "@preview/synkit:X.X.X": *
  ```,
) <code-import1>


Alternatively, if you want the most up-to-date version and this version is ahead of the published version, download/clone the repository #link("https://github.com/guilhermegarcia/synkit")[here] and load the package locally. This is shown in @code-import2. You simply need to import the `lib.typ` file, which is present in any package.

#figure(
  caption: [Loading a package in Typst using a local package],
  supplement: "Code",
  kind: "code",
  ```typst
  #import "synkit/lib.typ": *
  ```,
) <code-import2>

You may need to create a symlink depending on how you structure your files. See @app-packages for more information on Typst packages in general, as they work slightly differently from what you may be used to if you use #LaTeX.


= Basic trees

Let's begin with a simple tree, following the steps of David Chiang's excellent tutorial on `tikz-qtree` @tikz-qtree, which you can find #link("https://ctan.org/pkg/tikz-qtree")[here]. The function we'll be using is `#tree()`, and by the end of this manual, I hope that all of its parameters will be familiar. The main parameter of the function is the tree itself (`input`), which is a string, as can be seen in @code-tree-1. The first thing to notice is that the spaces between `[]` are not a deal breaker.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-1 (spaces are very flexible)],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree("[S [NP] [VP]]")
        #tree("[S[NP][VP]]")
        #tree("[ S [ NP ] [ VP ] ]")
        ```
      ] <code-tree-1>
    ],
    [
      #figure(
        caption: [The basics],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree("[ S [ NP ] [ VP ] ]", terminal-branch: true)
      ] <fig-tree-1>
    ],
  )
]

Next, let's complete the tree following the example in Chiang's tutorial. In @fig-tree-2 (left), no terminal branch is drawn. This is the default behavior of `#tree()`. If you wish to produce these branches, simply add `terminal-branch: true` to the function.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-2],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree("[S [NP [Det the] [N cat]] [VP[V sat][PP[P on] [NP [Det the] [N mat]]]]]")
        ```
      ] <code-tree-2>
    ],
    [
      #figure(
        caption: [The basics: terminal branches deactivated by default (left)],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree("[S [NP [Det the] [N cat]] [VP[V sat][PP[P on] [NP [Det the] [N mat]]]]]")
        #tree("[S [NP [Det the] [N cat]] [VP[V sat][PP[P on] [NP [Det the] [N mat]]]]]", terminal-branch: true)
      ] <fig-tree-2>
    ],
  )
]

What about adding a roof for a given XP? You can let the function decide for you whether a triangle is needed _or_ you can add it yourself via the parameter `triangle`, which we'll discuss shortly. Examine @code-tree-3: the sequence `[NP the cat]` automatically triggers a triangle because we go from phrase to content without intermediate nodes. This works because the function uses regular expressions to search for a given pattern. Of course, time will tell how reliable this is, but thus far it's been working as it should.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-3],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree("[S [NP the cat] [VP[V sat][PP[P on] [NP the mat]]]]")
        ```
      ] <code-tree-3>
    ],
    [
      #figure(
        caption: [The basics: automatic triangles],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree("[S [NP the cat] [VP[V sat][PP[P on] [NP the mat]]]]")
      ] <fig-tree-3>
    ],
  )
]

How can we manually add triangles? If the function is successful, you will likely never need to do this. But the option is there, and it will help us understand a key element in #logo, namely, _labels_. To demonstrate how this works, let's pretend we want to have a triangle under the head `N` (for whatever reason), which is not a context that triggers the automatic drawing just seen. The parameter `triangle` allows you to tell the function which location in the tree should be designed with a triangle. The key here is that labels exist the moment you create a node in the tree: you never have to set labels yourself. In @fig-tree-4, for example, we want a triangle under `N`. This is the first `N` from the top that we see in the tree (well, the only one here). Thus, we must simply state `"n1"` and the `triangle` parameter will target the correct location. This is shown in @code-tree-4. As already mentioned, you should never need to use the `triangle` parameter, but it's there anyway. The notion of automatic labelling is essential for when we discuss arrows, naturally.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-4],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree("[S [N the cat] [VP[V sat][PP[P on] [NP the mat]]]]", triangle: ("N1",))
        ```
      ] <code-tree-4>
    ],
    [
      #figure(
        caption: [The basics: custom triangles (`N`)],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree("[S [N the cat] [VP[V sat][PP[P on] [NP the mat]]]]")
        #tree("[S [N the cat] [VP[V sat][PP[P on] [NP the mat]]]]", triangle: ("N1",))
      ] <fig-tree-4>
    ],
  )
]




= Arrows <sec-arrows>

The example below comes from #cite(<carnie2013syntax>, supplement: "p. 261", form: "prose"). Arrows are added with the `arrows` parameter, which allows the user to specify `from` and `to` for any given arrow (this uses the automatically created labels already discussed). On top of that, the user can choose `color`, `line-width`, `dash`, and decide whether or not to curve the arrow. By default, arrows are rectangular (see gray dotted arrow in @fig-tree-7) --- multiple rectangular arrows have their heights adjusted automatically to avoid overlapping lines. This can be changed with the parameter `curved: true` (outside `arrows`). But if the user provides `bend` and `shift` inside `arrows`, `curved` will be assumed to be `true`. This is what we see in @fig-tree-7.

You will notice that some labels in @code-tree-7 have a numeric suffix: `trace3-198`. That suffix is optional: it lets the user define exactly _where_ the arrow should depart from (or arrive at, when it's used in `to`). Imagine an invisible ellipse surrounding each node's text. The numeric suffix represents a position on that ellipse in degrees, following standard trigonometric convention: 0° is east (right), 90° is north (up), 180° is west (left), and 270° is south (down). For example, `trace3-198` means "start the arrow from the 198° position around the `trace3` node" — slightly south of due west. Without a degree suffix, arrows use a default exit point in the tree's growth direction (typically below the text for downward trees), as can be seen in the gray dotted arrow once again --- see first line inside `arrows` in @code-tree-7. This gives the user a higher level of control overall.

The parameters `shift` and `bend` are easy to interpret, and allow the user to adjust the curve of each arrow independently. Both parameters have default values, which are implemented when `curved: true` and no values are provided for `bend` or `shift`. The advantage of not specifying `curved`, which is a global parameter within the function, is that both rectangular and curved arrows can coexist in the same tree.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-7],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree(
            "[ CP [] [ C' [ C Ø_{[+Q]}+T+Mangez ]
                  [ TP [ DP vous ] [ T' [ T t_i ]
                    [ VP [ t_DP ] [ V' [V t_i ] [DP des pommes] ] ] ] ] ] ]",
            arrows: (
              (from: "trace1", to: "C1", dash: "dotted", color: gray, line-width: 1.70),
              (from: "trace3-198", to: "T1", dash: "solid", bend: 0.2, shift: -1),
              (from: "trace2-255", to: "DP1", dash: "dashed", bend: 1, shift: -0.5, color: red),
              (from: "trace1-556", to: "C1", dash: "solid", bend: 1, shift: -1.5),
            ),
          )
        ```
      ] <code-tree-7>
    ],
    [
      #figure(
        caption: [Multiple arrows, adapted from #cite(<carnie2013syntax>, form: "prose")],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree(
          "[ CP [] [ C' [ C Ø_{[+Q]}+T+Mangez ] [ TP [ DP vous ] [ T' [ T t_i ] [ VP [ t_DP ] [ V' [V t_i ] [DP des pommes] ] ] ] ] ] ]",
          arrows: (
            (from: "trace1", to: "C1", dash: "dotted", color: gray, line-width: 1.70),
            (from: "trace3-198", to: "T1", dash: "solid", bend: 0.2, shift: -1),
            (from: "trace2-255", to: "DP1", dash: "dashed", bend: 1, shift: -0.5, color: red),
            (from: "trace1-556", to: "C1", dash: "solid", bend: 1, shift: -1.5),
          ),
        )
      ] <fig-tree-7>
    ],
  )
]

One final option regarding the specific location of arrows involves two other suffixes for labels. Traces are automatically labelled as `trace`, which means `trace3` in @fig-tree-7 will target _t#sub[i]_, not the V node above it, which would be targeted with `v1`. By default, when we target a node `x`, the arrow targets its content, not the node itself. For phrase movements, we'd use a suffix: `xp-up`. The function assumes `-down` automatically, so `xp1` is the same as `xp1-down`. On top of that, we can append degrees to customize where an arrow hits, so `xp1-down-175` would mean "target the _content_ of the first XP in the tree, specifically at 175°."

In summary, arrows have a lot of defaults, so you often end up with minimal code. However, they also allow for a relatively high degree of customization through the use of additional parameters. For reference, @fig-tree-defaults uses all the default values for arrows, thus simplifying the code needed (@code-tree-defaults) --- `curved` is set to `true` here because multiple movements look better with curved arrows.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-defaults],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree(
          "[ CP [] [ C' [ C Ø_{[+Q]}+T+Mangez ] [ TP [ DP vous ] [ T' [ T *t*_i ] [ VP [ *t*_DP ]
           [ V' [V *t*_i ] [DP des pommes] ] ]  ] ] ] ]",
          arrows: (
            (from: "trace3", to: "T1"),
            (from: "trace2", to: "DP1"),
            (from: "trace1", to: "C1"),
          ),
          curved: true,
        )
        ```
      ] <code-tree-defaults>
    ],
    [
      #figure(
        caption: [Multiple arrows, adapted from #cite(<carnie2013syntax>, form: "prose")],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree(
          "[ CP [] [ C' [ C Ø_{[+Q]}+T+Mangez ] [ TP [ DP vous ] [ T' [ T *t*_i ] [ VP [ *t*_DP ] [ V' [V *t*_i ] [DP des pommes] ] ]  ] ] ] ]",
          arrows: (
            (from: "trace3", to: "T1"),
            (from: "trace2", to: "DP1"),
            (from: "trace1", to: "C1"),
          ),
          curved: true,
        )
      ] <fig-tree-defaults>
    ],
  )
]

= Multidominance

Another important parameter in the function is `dominance`, which allows for more complex trees where multiple nodes are connected with curved branches. The example in @fig-tree-dom comes from #cite(<fox2016qr>, form: "prose", supplement: "p. 7").

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-dom],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree(
          "[IP [IP [IP [IP [DP [DP every_2] [NP woman] ] [IP [I] [VP is smiling] ] ] [IP [and] [IP [DP [DP every_2] [NP man] ] [IP [I] [VP is frowning] ] ] ] ] [\\lambda2] ] [QP [Q \\forall] [NP [NP] [CP who came in together] ] ] ]",
          dominance: (
            (from: "NP4", to: "NP1", ctrl: (-4, 4.2)),
            (from: "NP4", to: "NP2", ctrl: (-3, 3.5)),
          ),
          scale: 0.7, // easily scale down tree to fit the document
          line-width: 1.5, // useful when tree is scaled down
          spread-local: ( // adjusts width locally, based on labels
            ("IP3", 0.6), // adjust the spacing for the third IP from the top (sister to lambda)
          ),
        )
        ```
      ] <code-tree-dom>
    ],
    [
      #figure(
        caption: [Multidominance],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree(
          "[IP [IP [IP [IP [DP [DP every_2] [NP woman] ] [IP [I] [VP is smiling] ] ] [IP [and] [IP [DP [DP every_2] [NP man] ] [IP [I] [VP is frowning] ] ] ] ] [\\lambda2] ] [QP [Q \\forall] [NP [NP] [CP who came in together] ] ] ]",
          dominance: (
            (from: "NP4", to: "NP1", ctrl: (-4, 4.2)),
            (from: "NP4", to: "NP2", ctrl: (-3, 3.5)),
          ),
          scale: 0.7,
          line-width: 1.5,
          spread-local: (
            ("IP3", 0.6),
          ),
        )
      ] <fig-tree-dom>
    ],
  )
]

= Semantics

A parameter is dedicated to additional content between a given node and its branches: `annotation`. This allows the user to add semantic derivations, for example. The parameter in question, shown in @code-tree-sem, uses *content blocks*, which means you can mix strings and math mode together with ease (unlike the `input` parameter for tree specification in the function). Math mode in Typst is more minimalistic than math mode in #LaTeX (e.g., no backslashes are needed). Finally, `annotation-size` allows the user to set the font size for the annotations. The example in @fig-tree-sem also comes from #cite(<fox2016qr>, form: "prose", supplement: "p. 7").

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-sem],
        supplement: [Code],
        kind: "code",
      )[
        #text(size: 0.98em)[
          ```typst
          #tree(
            "[DP [D every] [NP [NP [NP woman] [NP [and] [NP man] ] ] [CP who came in together] ] ]",
            annotation: (
              ("DP1", [$lambda Q forall x [x "is a woman+man" and x "came in together"] arrow Q(x)$]),
              ("NP1", [$lambda x x "is a woman+man" and x "came in together"$]),
              ("NP2", [$lambda x x "is woman+man"$]),
              ("CP1", [$lambda x x "came in together"$]),
            ),
          )
          ```
        ]
      ] <code-tree-sem>
    ],
    [
      #figure(
        caption: [Semantic annotation with `annotation`],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree(
          "[DP [D every] [NP [NP [NP woman] [NP [and] [NP man] ] ] [CP who came in together] ] ]",
          annotation: (
            ("DP1", [$lambda Q forall x [x "is a woman+man" and x "came in together"] arrow Q(x)$]),
            ("NP1", [$lambda x x "is a woman+man" and x "came in together"$]),
            ("NP2", [$lambda x x "is woman+man"$]),
            ("CP1", [$lambda x x "came in together"$]),
          ),
        )
      ] <fig-tree-sem>
    ],
  )
]

A final example includes longer annotation, from #cite(<fox2016qr>, form: "prose", supplement: "p. 13"). Here, annotation involves multiple lines, so line breaks are manually added with `\`. You will notice that the code for the tree itself is relatively concise, but each annotation has its own entry, so @code-tree-sem2 becomes longer. As you can see, any symbol can be directly added to a tree (e.g., ‡) --- the symbol is then inherited by default by the label created for a given node, as can be seen in the annotation under DP‡ in @code-tree-sem2.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-sem2],
        supplement: [Code],
        kind: "code",
      )[
        #text(size: 0.98em)[
          ```typst
            #tree(
            "[IP [IP [IP [IP [DP† [D the_2] [\\muP every woman] ] [IP [I] [VP is smiling] ] ]
                [IP [and] [IP [DP‡ [D the_2] [\\muP every man] ] [IP [I] [VP is frowning] ] ] ] ]
                [\\lambda2] ] [QP [Q \\forall ] [\\muP\\* [\\muP] [CP who came in together] ] ] ]",
            annotation: (
              (
                "IP1",
                [$forall$_y_ [_y_ is a woman+man $and$ _y_ came in together] $arrow$ \
                  [the woman part of _y_ is smiling and the man part of _y_ is frowning]],
              ),
              (
                "IP2",
                [$lambda$_x_ : _x_ has a unique maximal woman part \
                  and a unique maximal man part. \ the woman part of x is smiling and \
                  the man part of x is frowning],
              ),
              (
                "QP1",
                [$lambda$_Q_$forall$_y_[_y_ is woman+man \
                  $and$ _y_ came in together] $arrow$ _Q(y)_],
              ),
              (
                "IP3",
                [the woman part of g(2) is smiling \ and the man part of g(2) is frowning],
              ),
              (
                "DP†1",
                [the woman part \ of g(2)],
              ),
              (
                "DP‡1",
                [the man part \ of g(2)],
              ),
            ),
            dominance: (
              (from: "muP4", to: "muP1", ctrl: (-6.1, 8.5)),
              (from: "muP4", to: "muP2", ctrl: (-6, 5)),
            ),
            scale: 0.8,
            spread: 0.8,
            terminal-branch: true,
          )
          ```
        ]
      ] <code-tree-sem2>
    ],
    [
      #figure(
        caption: [Complex tree with multi-line annotation],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree(
          "[IP [IP [IP [IP [DP† [D the_2] [\\muP every woman] ] [IP [I] [VP is smiling] ] ] [IP [and] [IP [DP‡ [D the_2] [\\muP every man] ] [IP [I] [VP is frowning] ] ] ] ] [\\lambda2] ] [QP [Q \\forall ] [\\muP\\* [\\muP] [CP who came in together] ] ] ]",
          annotation: (
            (
              "IP1",
              [$forall$_y_ [_y_ is a woman+man $and$ _y_ came in together] $arrow$ \
                [the woman part of _y_ is smiling and the man part of _y_ is frowning]],
            ),
            (
              "IP2",
              [$lambda$_x_ : _x_ has a unique maximal woman part \
                and a unique maximal man part. \
                the woman part of x is smiling and \
                the man part of x is frowning],
            ),
            (
              "QP1",
              [$lambda$_Q_$forall$_y_[_y_ is woman+man \
                $and$ _y_ came in together] $arrow$ _Q(y)_],
            ),
            (
              "IP3",
              [the woman part of g(2) is smiling \
                and the man part of g(2) is frowning],
            ),
            (
              "DP†1",
              [the woman part \
                of g(2)],
            ),
            (
              "DP‡1",
              [the man part \
                of g(2)],
            ),
          ),
          annotation-size: 0.8,
          dominance: (
            (from: "muP4", to: "muP1", ctrl: (-6.1, 8.5)),
            (from: "muP4", to: "muP2", ctrl: (-6, 5)),
          ),
          scale: 0.8,
          spread: 0.8,
          terminal-branch: true,
        )
      ] <fig-tree-sem2>
    ],
  )
]


= Bilingual trees

In one of the examples found in David Chiang's tutorial on `tikz-qtree` @tikz-qtree, English and Japanese trees are compared in a single figure. This is accomplished here with the function `#garden()`, which allows for multiple trees to be built on top of each other. Because 2 is probably the ideal number of trees for this use case, that is the scenario illustrated in @fig-tree-bi. Here, again, the tree number is referenced by a suffix. For example, if we want to link the second N in tree 1 to the third NP in tree two, we add `("n2-1", "np3-2")`. This is relatively intuitive, and automatic labels allow for @code-tree-bi to be considerably more minimal than what we would need in ~#LaTeX. Finally, to have a "mirror image" of two trees, one of the trees must be upside-down. This is why the `direction` parameter exists, discussed further in @sec-direction. We simply specify `direction: "up"` to flip a tree vertically, as shown in @fig-tree-bi.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-bi],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #garden(
          ( // tree 1
            input: "[S [NP [Det the] [N cat]] [VP [V sat] [PP [P on] [NP [Det the] [N mat]]]]]",
            spread: 1.55, // This ensures that the trees' width is virtually the same
            content-size: 1
          ),
          ( // tree 2
          input: "[S [NP 猫が] [VP [PP [NP [NP マット] [Part の] [NP 上] ] [P に]] [V 土]]]",
          direction: "up",
          content-size: 1
          ),
            // Inter-tree lines (dashed)
          equivalence: (
            ("Det1-1", "NP1-2"), ("P1-1", "P1-2"), ("P1-1", "NP4-2"),
            ("N1-1", "NP1-2"), ("N2-1", "NP3-2"), ("Det2-1", "NP3-2"),
            ("V1-1", "V1-2"),
          ),
          gap: 2.5,
          scale: 0.7
        )
        ```
      ] <code-tree-bi>
    ],
    [
      #figure(
        caption: [Bilingual trees --- example from Chiang's tutorial on `tikz-qtree`],
        supplement: [Tree],
        kind: "tree",
      )[
        #garden(
          (
            input: "[S [NP [Det the] [N cat]] [VP [V sat] [PP [P on] [NP [Det the] [N mat]]]]]",
            spread: 1.55,
            content-size: 1,
          ),
          (
            input: "[S [NP 猫が] [VP [PP [NP [NP マット] [Part の] [NP 上] ] [P に]] [V 土]]]",
            direction: "up",
            content-size: 1,
          ),
          equivalence: (
            ("Det1-1", "NP1-2"),
            ("P1-1", "P1-2"),
            ("P1-1", "NP4-2"),
            ("N1-1", "NP1-2"),
            ("N2-1", "NP3-2"),
            ("Det2-1", "NP3-2"),
            ("V1-1", "V1-2"),
          ),
          gap: 2.5,
          scale: 0.7,
        )
      ] <fig-tree-bi>
    ],
  )
]

#figure(
  caption: [Equivalent code in #LaTeX to produce @fig-tree-bi],
  supplement: "Code",
  kind: "code",
)[
  #align(center)[
    ```tex
    \begin{tikzpicture}
       \begin{scope}[frontier/.style={distance from root=150pt}]
       \Tree [.S [.NP [.Det \node(e1){the}; ]
                 [.N \node(e2){cat}; ] ]
               [.VP [.V \node(e3){sat}; ]
                 [.PP [.P \node(e4){on}; ]
                   [.NP [.Det \node(e5){the}; ]
                     [.N \node(e6){mat}; ] ] ] ] ]
       \end{scope}
       \begin{scope}[xshift=9pt,yshift=-5in,grow'=up,
                 frontier/.style={distance from root=150pt}]
       \tikzset{every leaf node/.style={font=\ja}}
       \Tree [.S [.NP \node(j1){猫が}; ]
               [.VP [.PP [.NP [.NP \node(j2){マット}; ]
                         [.Part \node(j3){の}; ]
                         [.NP \node(j4){上}; ] ]
                     [.P \node(j5){に}; ] ]
                 [.V \node(j6){土}; ] ] ]
       \end{scope}
       \begin{scope}[dashed]
          \draw (e1)--(j1);
          \draw (e2)--(j1);
          \draw (e3)--(j6);
          \draw (e4)--(j4);
          \draw (e4)--(j5);
          \draw (e5)--(j2);
          \draw (e6)--(j2);
       \end{scope}
    \end{tikzpicture}
    ```
  ]
]

By default, stacked trees will use `bottom: true` to ensure that alignment is optimal --- see @fig-tree-bottom in @sec-spacing. Consequently, terminal branches are displayed to avoid empty space between nodes and their content.

// #text(size: 1em)[
//   #tree(
//     "[... [] [CP [t_i] [C' [C0] [AdvP(ModP) [] [AdvP'(Mod') [Adv0(Mod0) fortunately] [TP [t_1] [T' [T0] [vP ran to the store] ] ] ] ]  ] ]]",
//     node-size: 0.8,
//   )
// ]

= In-line movement <sec-inline>

In-line representations also make use of automatic labelling. Every word we add to a sentence is its own label. As a result, we can easily draw an arrow from `who2` to `who1` in @fig-in-line. Because the arrows extend below the text baseline, they may overlap with subsequent content. Setting `protect: true` reserves vertical space below the output to prevent this. By default, `protect` is `false`, which is the correct setting when `#move()` is placed inside a table cell (e.g., in numbered examples with `#eg()`), where extra height would misalign adjacent cells --- see @sec-examples below. Because these representations are almost always used in the context of a numbered example, `protect: false` is favoured.

The examples below demonstrate how to change line styles for arrows and how to delink a given arrow using its position. For example, if `delinks: (0,)`, a delink is added to the first movement arrow added to the code --- see last two examples in @fig-in-line.

#align(center)[
  #figure(
    caption: [In-line movement, traces, arrows and delinks (emojis also work with labels)],
    supplement: "Example",
    kind: "inline",
  )[


    ```typst
    #move("[CP Who do you think [(CP)[TP<who>ate the chocolate?]]]",
      arrows: ((from: "who2", to: "who1"),),
      protect: true,)
    ```
    #move(
      "[CP Who do you think [(CP)[TP<who>ate the chocolate?]]]",
      arrows: (
        (from: "who2", to: "who1"),
      ),
      protect: true,
    )

    ```typst
    #move("[CP Who do you think [(CP)[TP __ ate the chocolate?]]]",
      arrows: ((from: "trace1", to: "who1", dash: "wavy", color: red),),
      protect: true,)
    ```

    #move(
      "[CP Who do you think [(CP)[TP __ ate the chocolate?]]]",
      arrows: (
        (from: "trace1", to: "who1", dash: "wavy", color: red),
      ),
      protect: true,
    )

    ```typst
    #move("[CP Who do you think [(CP)[TP t_i ate the chocolate?]]]",
      arrows: ((from: "trace1", to: "who1", dash: "dashed"),),
      protect: true,)
    ```

    #move(
      "[CP Who_i do you think [(CP)[TP t_i ate the chocolate?]]]",
      arrows: (
        (from: "trace1", to: "who1", dash: "dashed", color: black),
      ),
      protect: true,
    )

    ```typst
    #move("[CP Who do you think [(CP)[TP t_i ate the chocolate?]]]",
      arrows: ((from: "trace1", to: "who1", dash: "dotted"),),
      delinks: (0,), // delink the first (0) arrow
      protect: true,)
    ```

    #move(
      "[CP Who_i do you think [(CP)[TP t_i ate the chocolate?]]]",
      arrows: (
        (from: "trace1", to: "who1", dash: "dotted", color: black),
      ),
      delinks: (0,),
      protect: true,
    )

    ```typst
      #move("[S A simple sentence with multiple 🫠 arrows and multiple delinks and one 🫠]",
        arrows: (
          (from: "simple1", to: "show1", dash: "dotted", color: black),
          (from: "arrows1", to: "a1", dash: "dashed", color: red),
          (from: "🫠1", to: "🫠2", dash: "wavy", color: blue),
          (from: "multiple1", to: "and1", dash: "solid", color: green),
        ),
        delinks: (0, 2),
        protect: true,)
    ```

    #move(
      "[S A simple sentence with multiple 🫠 arrows and multiple delinks and one 🫠]",
      arrows: (
        (from: "simple1", to: "show1", dash: "dotted", color: black),
        (from: "arrows1", to: "a1", dash: "dashed", color: red),
        (from: "🫠1", to: "🫠2", dash: "wavy", color: blue),
        (from: "multiple1", to: "and1", dash: "solid", color: green),
      ),
      delinks: (0, 2),
      protect: true,
    )
  ] <fig-in-line>
]

= Numbered examples <sec-examples>

The examples shown in @fig-in-line are usually placed in numbered examples. This can be accomplished with the function `#eg()`, which is the same implementation found in #phonokit, to keep both packages consistent.

#v(2em)
#important(title: "Important.")[
  To use this function, add this line after importing the package: `#show: eg-rules`
]

The simplest use of `#eg()` is to wrap content directly. The example number is generated automatically:

#grid(
  columns: 1,
  gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    #figure(
      supplement: "Code",
      kind: "code",
      caption: [Single-item numbered example],
    )[
      ```typst
      #eg[#move(
        "[CP Who do you think [(CP)[TP<who>ate the chocolate?]]]",
        arrows: ((from: "who2", to: "who1"),),
      )] <eg-single>
      ```
    ] <code-single>
  ],
  [
    #eg[#move(
      "[CP Who do you think [(CP)[TP<who>ate the chocolate?]]]",
      arrows: ((from: "who2", to: "who1"),),
    )] <eg-single>
  ],
)

For sub-examples, use the list syntax (`-`). Each item is automatically lettered (`a.`, `b.`, etc.). The `labels` argument allows individual sub-examples to be referenced, as in @s-plain and @s-move. The example as a whole can also be referenced, as in @eg-wh.

#grid(
  columns: 1,
  gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    #figure(
      supplement: "Code",
      kind: "code",
      caption: [Sub-examples with labels],
    )[
      ```typst
      #eg(labels: (<s-plain>, <s-move>))[
        - Who do you think saw Mary?
        - #move(
            "[CP Who do you think [(CP)[TP<who>saw Mary]]]",
            arrows: ((from: "who2", to: "who1", dash: "solid", color: black),),
          )
      ] <eg-wh>
      ```
    ] <code-move>
  ],
  [
    #eg(labels: (<s-plain>, <s-move>))[
      - Who do you think saw Mary?
      - #move(
          "[CP Who do you think [(CP)[TP<who>saw Mary]]]",
          arrows: ((from: "who2", to: "who1", dash: "solid", color: black),),
        )
    ] <eg-wh>
  ],
)

Without `labels`, sub-examples are simply not "referenceable" individually --- only the example as a whole can be labeled and referenced. The `title` argument places a title on the same line as the example number, with the content below. Finally, the `caption` argument is only used if you plan to have a table of contents exclusively for examples, which covers both `#eg()` and `#gloss()` (discussed next). In @eg-title, a `caption` has been added, but nothing is printed. In @sec-glosses, an outline is produced where this caption will be useful.

#grid(
  columns: 1,
  gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    #figure(
      supplement: "Code",
      kind: "code",
      caption: [Example with `title` to generate @eg-title],
    )[
      ```typst
      #eg(title: [Wh-movement in English], caption: [Wh-movement in English])[
        - Who do you think saw Mary?
        - #move(
            "[CP Who do you think [(CP)[TP<who>saw Mary]]]",
            arrows: ((from: "who2", to: "who1"),),
          )
      ] <eg-title>
      ```
    ] <code-title>
  ],
  [
    #eg(title: [Wh-movement in English], caption: [Wh-movement in English])[
      - Who do you think saw Mary?
      - #move(
          "[CP Who do you think [(CP)[TP<who>saw Mary]]]",
          arrows: ((from: "who2", to: "who1"),),
        )
    ] <eg-title>
  ],
)

*A note on figure spacing.* This applies to #phonokit as well as to #logo: If your document uses a custom `#show figure` rule to add vertical spacing around figures, you may notice misalignment in sub-example labels. This happens because `#subex-label()` uses figures internally, and added spacing will disrupt table cell alignment. To fix this, exclude `linguistic-subexample` from your spacing rule. For example, a document that adds `1em` vertical spacing before and after each figure should have something along these lines:

#align(center)[
  #figure(
    supplement: "Code",
    kind: "code",
    caption: [Excluding linguistic examples from custom figure spacing specifications],
  )[
    ```typst
    #show figure: it => {
      if it.kind == "linguistic-subexample" {
        it
      } else {
        v(1em)
        it
        v(1em)
      }
    }
    ```
  ] <code-align>
]

= Glosses <sec-glosses>

For numbered examples involving glosses, where alignment is essential, you can use the `#gloss()` function. Its implementation is simple (similar to `#eg()` discussed above): it uses regular expressions to look for spaces, which trigger a split that guarantees alignment across words. Its syntax is also minimal, since it's simply a list. Curly braces can be used to trigger small caps. Both functions (`#gloss()` and `#eg()`) share the same numbering, as expected, since both are numbered examples. See @code-gloss-1, which generates @eg-gloss-1 (note that a `caption` is added here, which will be relevant later in this section).

#align(center)[
  #figure(
    caption: [Code to generate @eg-gloss-1],
    supplement: "Code",
    kind: "code",
  )[
    ```typst
    #gloss(spacing: 1.2em, caption: [An example from Portuguese])[
      - eu gosto de maçã
      - I like-{1sg.prs} of apple
      - 'I like apples.'
    ] <eg-gloss-1>
    ```
  ] <code-gloss-1>
]

#gloss(spacing: 1.2em, caption: [An example from Portuguese])[
  - eu gosto de maçã
  - I like-{1sg.prs} of apple
  - 'I like apples.'
] <eg-gloss-1>

Labels such as `<eg-gloss-1>` seen in @code-gloss-1 are global, but you can also add labels for subglosses (exactly like `#eg()`) with the `labels` argument. Likewise, a `per` argument exists in case you want to have multiple glosses in the same example with a custom number of lines for whatever reason. The reason for `per` is flexibility: if you wanted to have glosses with 5 lines each (line 5 being the translation), you would simply define `per: 5`. @code-gloss-2 shows how @eg-sub-pt is generated. Given that `labels` have been added in @code-gloss-2, we can now refer to @eg-sub-pt1 and @eg-sub-pt2.

#align(center)[
  #figure(
    caption: [Code to generate @eg-sub-pt],
    supplement: "Code",
    kind: "code",
  )[
    ```typst
    #gloss(per: 3, labels: (<eg-sub-pt1>, <eg-sub-pt2>))[
      - eu gosto de maçã
      - I like.{1sg.prs} of apple
      - 'I like apples.'
      - elle aime les pommes
      - she like.{3sg.prs} {def.pl} apple.{pl}
      - 'She likes apples.'
    ] <eg-sub-pt>
    ```
  ] <code-gloss-2>
]

#gloss(per: 3, labels: (<eg-sub-pt1>, <eg-sub-pt2>))[
  - eu gosto de maçã
  - I like.{1sg.prs} of apple
  - 'I like apples.'
  - elle aime les pommes
  - she like.{3sg.prs} {def.pl} apple.{pl}
  - 'She likes apples.'
] <eg-sub-pt>


Let's explore some additional cases. In @gloss-inuktitut, we see an example from Inuktitut #cite(<CLAcanada>, supplement: "p. 275"). This is a situation where we may want to have four lines for a gloss, where a given line simply shows an orthographic form that should not be parsed by the `#gloss()` function. That's why the `escape` argument exists. In @gloss-inuktitut, the first line (number `0`) is "free" from the parsing used elsewhere in the example.

#align(center)[
  #figure(
    caption: [Code to generate @gloss-inuktitut],
    supplement: "Code",
    kind: "code",
  )[
    ```typst
    #gloss(per: 4, escape: (0,), caption: [An example from Inuktitut])[
      - Qasuiirsarvigssarsingitluinarnarpuq
      - Qasu -iir -sar -vig -ssar -si -ngit-luinar -nar -puq
      - tired not cause-to-be place-for suitable find not-completely someone 3.{sg}
      - 'Someone did not find a completely suitable resting place.'
    ] <gloss-inuktitut>
    ```
  ] <code-gloss-3>
]

#gloss(per: 4, escape: (0,), caption: [An example from Inuktitut])[
  - Qasuiirsarvigssarsingitluinarnarpuq
  - Qasu -iir -sar -vig -ssar -si -ngit-luinar -nar -puq
  - tired not cause-to-be place-for suitable find not-completely someone 3.{sg}
  - 'Someone did not find a completely suitable resting place.'
] <gloss-inuktitut>

Here's another case, this time from Turkish @CLAcanada, where we have IPA symbols#footnote[Because Typst has native UTF-8 support, you can simply add whatever symbol you want.] and only two lines (`per: 2`). This is shown in @gloss-turkish.

#align(center)[
  #figure(
    caption: [Code to generate @gloss-turkish],
    supplement: "Code",
    kind: "code",
  )[
    ```typst
    #gloss(per: 2)[
      - [kœj]
      - 'village'
    ] <gloss-turkish>
    ```
  ] <code-gloss-4>
]

#gloss(per: 2)[
  - [kœj]
  - 'village'
] <gloss-turkish>

Finally, a case with a title, also from Turkish @CLAcanada, is shown in @gloss-turkish2.


#align(center)[
  #figure(
    caption: [Code to generate @gloss-turkish2],
    supplement: "Code",
    kind: "code",
  )[
    ```typst
    #gloss(title: [SOV (Turkish)], caption: [Another example])[
      - Hasan œkyz-y al-dɨ
      - Hasan ox-{acc} buy-{pst}
      - 'Hasan bought the ox.'
    ] <gloss-turkish2>
    ```
  ] <code-gloss-5>
]

#gloss(title: [SOV (Turkish)], caption: [Another example])[
  - Hasan œkyz-y al-dɨ
  - Hasan ox-{acc} buy-{pst}
  - 'Hasan bought the ox.'
] <gloss-turkish2>

We can now generate a simple table of contents that targets only the examples for which we set a `caption` above. These include both `#eg()` and `#gloss()`. If you don't add a `caption` for an example, it will not appear in the table of contents generated below (see @code-outline).

#align(center)[
  #figure(
    caption: [Code to create an outline for examples],
    supplement: "Code",
    kind: "code",
  )[
    ```typst
    #outline(
      title: [List of Examples],
      target: figure.where(kind: "linguistic-example"),
    )
    ```
  ] <code-outline>
]

#outline(
  title: [List of Examples],
  target: figure.where(kind: "linguistic-example"),
)

#v(1em)

If you also use #phonokit in your document, the outline above will integrate phonology and syntax examples seamlessly, even though both packages use two different functions, namely `#ex()` and `#eg()`.


= Extras

This section introduces some important parameters to further adjust syntax trees.

== Spacing <sec-spacing>

@table-spacing lists key parameters to understand how spacing works in `#tree()`.


#figure(
  align(center)[
    #table(
      columns: 2,
      align: (left, left),
      stroke: none,
      inset: (y: 0.65em),
      table.hline(stroke: 0.8pt + black),
      [*Parameter*], [*Purpose*],
      table.hline(stroke: 0.4pt + black),
      [`spread`], [Global spacing between sister nodes (horizontal)],
      [`spread-local`], [Local spacing between sister nodes (based on labels)],
      [`drop`], [Global spacing between levels (vertical)],
      [`drop-local`], [Local spacing between levels (based on labels)],
      table.hline(stroke: 0.8pt + black),
    )
  ],
  caption: [Spacing parameters in `#tree()`],
) <table-spacing>

To see these parameters in action, let's examine @fig-tree-spacing-default to @fig-tree-spacing-drop-local. These are all based on the base code shown in @code-tree-spacing. @fig-tree-spacing-default shows what a typical tree looks like without any custom specification for the parameters in @table-spacing. An arrow is added to all trees to show the user how they adjust automatically as we adjust any spacing parameter (since they're based on labels and not on absolute coordinates).

If we want the tree as a whole to have more horizontal separation, `spread` can be used. @fig-tree-spacing-spread, for example, increases the spread by 100% (from `1` to `2`). But we often want to adjust only one sister-to-sister interval; that's why `spread-local` exists, as shown in @fig-tree-spacing-spread-local, which reduces the gap after C (that is, the C-D spacing). The parameter `drop` works on the same direct scale for vertical spacing, as can be seen in @fig-tree-spacing-drop-low to @fig-tree-spacing-drop-local.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-spacing-default through @fig-tree-spacing-drop-local],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree("[ A [ B [C] [D] ] [ E [F] [G] ] ]", arrows: ("C1", "F1"), ......)
        ```
      ] <code-tree-spacing>
    ],
    [
      #grid(
        columns: 3,
        gutter: 1.5em,
        align: center + bottom,
        [#figure(
          caption: [Default],
          supplement: [Tree],
          kind: "tree",
        )[
          #tree("[ A [ B [C] [D] ] [ E [F] [G] ] ]", arrows: ("C1", "F1"))
        ] <fig-tree-spacing-default>],
        [#figure(
          caption: [`spread: 2`],
          supplement: [Tree],
          kind: "tree",
        )[
          #tree("[ A [ B [C] [D] ] [ E [F] [G] ] ]", spread: 2, arrows: ("C1", "F1"))
        ] <fig-tree-spacing-spread>],
        [#figure(
          caption: [`spread-local` (C-D)],
          supplement: [Tree],
          kind: "tree",
        )[
          #tree("[ A [ B [C] [D] ] [ E [F] [G] ] ]", spread-local: ("C1", 0.4), arrows: ("C1", "F1"))
        ] <fig-tree-spacing-spread-local>],

        [#figure(
          caption: [`drop: 0.7`],
          supplement: [Tree],
          kind: "tree",
        )[
          #tree("[ A [ B [C] [D] ] [ E [F] [G] ] ]", drop: 0.7, arrows: ("C1", "F1"))
        ] <fig-tree-spacing-drop-low>],
        [#figure(
          caption: [`drop: 1.2`],
          supplement: [Tree],
          kind: "tree",
        )[
          #tree("[ A [ B [C] [D] ] [ E [F] [G] ] ]", drop: 1.2, arrows: ("C1", "F1"))
        ] <fig-tree-spacing-drop-high>],
        [#figure(
          caption: [`drop-local` (C-F)],
          supplement: [Tree],
          kind: "tree",
        )[
          #tree(
            "[ A [ B [C] [D] ] [ E [F] [G] ] ]",
            drop-local: (
              ("C1", 0.5),
              ("F1", 1.3),
            ),
            arrows: ("C1", "F1"),
          )
        ] <fig-tree-spacing-drop-local>],
      )
    ],
  )
]


Another possible adjustment to spacing involves the vertical alignment of node contents, i.e., the spacing between a node and its content. The parameter `bottom: true` will pull the tree's content down and bottom-align it. This will trigger terminal branches by default, as already mentioned.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-bottom],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree(
          "[S [NP the *cat*] [VP[V sat][PP[P on] [NP the mat]]]]",
          bottom: true,
        )
        #tree(
          "[S [NP [Det The] [N cat] ] [VP[V sat][PP[P on] [NP [Det the] [N mat]]]]]",
          bottom: true,
        )
        ```
      ] <code-tree-bottom>
    ],
    [
      #figure(caption: [Bottom alignment --- looks better without triangles], supplement: [Tree], kind: "tree")[
        #grid(
          columns: 2,
          align: bottom,
          column-gutter: 1em,
          tree("[S [NP the *cat*] [VP[V sat][PP[P on] [NP the mat]]]]", bottom: true),
          tree("[S [NP [Det The] [N cat] ] [VP[V sat][PP[P on] [NP [Det the] [N mat]]]]]", bottom: true),
        )
      ] <fig-tree-bottom>
    ],
  )
]

== Line breaks

Breaking lines is easy with `\\n`. This avoids having phrases that are too wide.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-break],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree(
            "[S [NP the orange cat \\n that lives next door]
              [VP[V sat][PP[P on]
              [NP the new couch \\n we purchased \\n last week]]]]",
          )
        ```
      ] <code-tree-break>
    ],
    [
      #figure(caption: [Breaking lines within phrases], supplement: [Tree], kind: "tree")[
        #grid(
          columns: 2,
          align: bottom,
          column-gutter: 1em,
          tree(
            "[S [NP the orange cat \\n that lives next door] [VP[V sat][PP[P on] [NP the new couch \\n we purchased \\n last week]]]]",
          ),
        )
      ] <fig-tree-break>
    ],
  )
]



== Formatting

Let's now explore some important consequences of using a string as our main input. What if we want to use bold, italics, small caps, Greek letters, etc.? If you have used Typst before, you know that you can simply add whatever symbol you need directly into the document (UTF-8 is natively accepted). But `#tree()` also has some presets to make this easier. @fig-tree-5 shows how to adjust the formatting of strings in the tree. Greek letters are interpretable as long as you use `\\`. For italics, you use `*cat*`; for bold, `**mat**`, for small caps, `@sat@`. You can also strike through text with `~` (see @fig-tree-5). Finally, subscripts and superscripts can be easily added with `_` and `^`, respectively. An additional parameter, `highlight`, exists for drawing a rectangle around any given node (equivalent to `\node[draw]` in `tikz-qtree`)---we refer to `P` as `"p1"` in @code-tree-5 ("first [and only] P from the top of the tree").

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-5],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree("[S [NP_\\omega the *cat*] [VP[V @sat@][PP[P ~on~] [NP^\\phi the **mat**]]]]",
                     highlight: ("P1",))
        ```
      ] <code-tree-5>
    ],
    [
      #figure(
        caption: [The basics: highlight, bold, italics, small caps, super- and subscripts],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree("[S [NP_\\omega the *cat*] [VP[V @sat@][PP[P ~on~] [NP^\\phi the **mat**]]]]", highlight: ("P1",))
      ] <fig-tree-5>
    ],
  )
]

== Direction <sec-direction>

Trees can also change direction with the `direction` parameter. By default, `direction: "down"`, but you can set it to `"up"`, `"left"`, or `"right"`, as shown in @code-tree-6. In addition, you can use the `scale` parameter to increase or decrease the size of your tree. In @fig-tree-6, the tree on the left uses `scale: 1` (default), while the tree on the right uses `scale: 0.6` (60% of its original size).

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-6],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree("[S [NP_\\omega the *cat*] [VP[V @sat@][PP[P on] [NP^\\phi the **mat**]]]]",
                     direction: "left")
        ```
      ] <code-tree-6>
    ],
    [
      #figure(
        caption: [Changing tree direction and size],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree("[S [NP_\\omega the *cat*] [VP[V @sat@][PP[P on] [NP^\\phi the **mat**]]]]", direction: "left")
        #tree(
          "[S [NP_\\omega the *cat*] [VP[V @sat@][PP[P on] [NP^\\phi the **mat**]]]]",
          direction: "up",
          scale: 0.6,
        )
      ] <fig-tree-6>
    ],
  )
]

== Sizing

Sizing and spacing are two key parameters in any tree. By default, the content of each node has 80% of the size of the node itself, but this can be changed with the `content-size` parameter (defaults to `0.8`). @fig-tree-sizing uses `content-size: 1.2` to make the content larger than the nodes. In @code-tree-sizing, you will also find two other parameters: `drop` and `spread`. These help you set vertical and horizontal spacing for the tree. If you wish to change the size of nodes, `node-size` is also available.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-sizing],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree(
          "[S [NP the cat] [VP[V sat][PP[P on] [NP the mat]]]]",
          content-size: 1.2,
          node-size: 0.6,
          drop: 0.8,
          spread: 1.5,
        )
        ```
      ] <code-tree-sizing>
    ],
    [
      #figure(
        caption: [Size and spacing: larger content, smaller nodes],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree(
          "[S [NP the cat] [VP[V sat][PP[P on] [NP the mat]]]]",
          content-size: 1.2,
          node-size: 0.6,
          drop: 0.8,
          spread: 1.5,
        )
      ] <fig-tree-sizing>
    ],
  )
]

== Branch styling

Different parameters exist for styling a tree, most notably `color` and `dash-branches`. @fig-tree-branch uses both parameters. The parameter `color` is flexible and can refer to both branches or text, depending on the parameters passed to it. For example, `color: ("S1", green)` will target a node (S), while `color: ("VP1", "V1")` will target _the relationship_ between nodes, i.e., a branch.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-branch],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree(
          "[S [NP the cat] [VP[V sat][PP[P on] [NP the mat]]]]",
          content-size: 1,
          drop: 0.8,
          spread: 1.5,
          dash-branches: (
            ("VP1", "V1"),
            ("S1", "VP1"),
          ),
          color: (
            ("S1", green.darken(20%)),
            ("NP1", red),
            ("NP2", red),
            ("P1down", blue),
            ("VP1", "V1", orange),
          ),
        )
        ```
      ] <code-tree-branch>
    ],
    [
      #figure(
        caption: [A colourful tree],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree(
          "[S [NP the cat] [VP[V sat][PP[P on] [NP the mat]]]]",
          content-size: 1,
          drop: 0.8,
          spread: 1.5,
          dash-branches: (
            ("VP1", "V1"),
            ("S1", "VP1"),
          ),
          color: (
            ("S1", green.darken(20%)),
            ("NP1", red),
            ("NP2", red),
            ("P1down", blue),
            ("VP1", "V1", orange),
          ),
        )
      ] <fig-tree-branch>
    ],
  )
]


// == Empty trees
//
//
// #align(center)[
//   #grid(
//     columns: 1,
//     gutter: 1em,
//     align: (top, top),
//     [
//       #figure(
//         caption: [Code for @fig-tree-empty],
//         supplement: [Code],
//         kind: "code",
//       )[
//         ```typst
//         #tree("[S [NP ] [VP[V ][PP[P ] [NP [ ... [] ] [ ... [] ]]]]]")
//         ```
//       ] <code-tree-empty>
//     ],
//     [
//       #figure(
//         caption: [Empty tree],
//         supplement: [Tree],
//         kind: "tree",
//       )[
//         #tree(
//           "[S [NP ] [VP[V ][PP[P ] [NP [ ... [] ] [ ... [] ]]]]]",
//         )
//       ] <fig-tree-empty>
//     ],
//   )
// ]
//

== Font

While #logo inherits the document font by default, you can always choose whatever font you prefer for each function. @fig-tree-font illustrates this by setting `font: "Comic Sans MS"`.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-font],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree(
          "[S [NP the 🐈] [VP[V sat][PP[P on] [NP the mat]]]]",
          content-size: 1,
          drop: 0.8,
          spread: 1.5,
          dash-branches: (
            ("VP1", "V1"),
            ("S1", "VP1"),
          ),
          color: (
            ("S1", green.darken(20%)),
            ("NP1", red),
            ("NP2", red),
            ("P1down", blue),
            ("VP1", "V1", orange),
          ),
          font: "Comic Sans MS",
        )
        ```
      ] <code-tree-font>
    ],
    [
      #figure(
        caption: [Changing the font locally (emojis natively supported)],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree(
          "[S [NP the 🐈] [VP[V sat][PP[P on] [NP the mat]]]]",
          content-size: 1,
          drop: 0.8,
          spread: 1.5,
          dash-branches: (
            ("VP1", "V1"),
            ("S1", "VP1"),
          ),
          color: (
            ("S1", green.darken(20%)),
            ("NP1", red),
            ("NP2", red),
            ("P1down", blue),
            ("VP1", "V1", orange),
          ),
          font: "Comic Sans MS",
        )
      ] <fig-tree-font>
    ],
  )
]



= Future work and acknowledgments

The package is in its infancy, so there will be bugs and limitations. That is why comments and suggestions are especially welcome, as they will speed up the process of improving precision and coverage. Simply open an issue in the package's repo. I am not a syntactician, so I've benefitted greatly from the help of my colleague Vincent Rouillard.



#pagebreak()

#bibliography("references.bib", title: "References", style: "apa")

#pagebreak()

#heading(numbering: none, outlined: true)[Appendix]
#counter(heading).update(0)
#set heading(numbering: "A.1.")

= Argument reference <sec-args>

@tbl-args lists all available parameters in `#tree()`.

#text(size: 0.8em)[
  #figure(
    caption: [All arguments in `#tree()`],
    supplement: [Table],
    kind: table,
  )[
    #table(
      columns: (auto, auto, auto, 1fr),
      stroke: none,
      inset: (y: 0.8em),
      align: (left + horizon),
      table.header([*Argument*], [*Type*], [*Default*], [*Description*]),
      table.hline(stroke: 0.75pt),
      [`arrows`],
      [array],
      [`()`],
      [Cross-node arrows. Each entry is `(from, to)` or a dict with keys `from`, `to`, `color`, `bend`, `shift`, `dash`, `line-width`],
      table.hline(stroke: 0.25pt),
      [`scale`], [number], [`1.0`], [Uniform scale factor for the whole tree],
      table.hline(stroke: 0.25pt),
      [`triangle`], [array], [`()`], [Anchor names whose branch renders as a triangle for elided structure],
      table.hline(stroke: 0.25pt),
      [`content-size`], [number], [`0.8`], [Size multiplier for leaf content text],
      table.hline(stroke: 0.25pt),
      [`node-size`], [number], [`1.0`], [Size multiplier for node label text],
      table.hline(stroke: 0.25pt),
      [`curved`], [bool], [`false`], [Draw arrows as Bézier curves instead of rectangular paths],
      table.hline(stroke: 0.25pt),
      [`direction`], [string], [`"down"`], [Growth direction: `"down"`, `"up"`, `"right"`, or `"left"`],
      table.hline(stroke: 0.25pt),
      [`highlight`], [array], [`()`], [Anchor names to draw a box around. Use `"DP1-down"` to box the leaf content],
      table.hline(stroke: 0.25pt),
      [`bottom`], [bool], [`false`], [Align all leaves at the lowest level regardless of depth],
      table.hline(stroke: 0.25pt),
      [`terminal-branch`], [bool], [`false`], [Draw branches from non-terminal nodes to terminal (leaf) nodes],
      table.hline(stroke: 0.25pt),
      [`dash-branches`], [array], [`()`], [Array of `(parent, child)` anchor pairs whose branch is dashed],
      table.hline(stroke: 0.25pt),
      [`delinks`], [array], [`()`], [Anchor names where a delink mark (two bars) is drawn on the arrow shaft],
      table.hline(stroke: 0.25pt),
      [`index`], [array], [`()`], [Coreference subscripts. Array of single-key dicts, e.g. `(("CP1": "i"),)`],
      table.hline(stroke: 0.25pt),
      [`append`], [array], [`()`], [Extra subscript text appended after a node label, e.g. `(("VP1", "θ"),)`],
      table.hline(stroke: 0.25pt),
      [`drop`], [number], [`1.0`], [Multiplier for vertical distance between levels],
      table.hline(stroke: 0.25pt),
      [`drop-local`],
      [array],
      [`()`],
      [Per-level or per-node branch length multipliers, e.g. `(1, 1.5)` or `("IP2", 0.5)`],
      table.hline(stroke: 0.25pt),
      [`spread`], [number], [`1.0`], [Horizontal width per leaf in canvas units],
      table.hline(stroke: 0.25pt),
      [`spread-local`], [array], [`()`], [Per-level or per-node horizontal gap multipliers between sisters],
      table.hline(stroke: 0.25pt),
      [`dominance`],
      [array],
      [`()`],
      [Long-distance dominance lines. Entries: `("from", "to")` or dict with `ctrl`, `color`, `dash`],
      table.hline(stroke: 0.25pt),
      [`color`], [array], [`()`], [Colorize nodes, leaves, or branches. E.g. `("NP1", red)` or `("VP1", "V1", yellow)`],
      table.hline(stroke: 0.25pt),
      [`annotation`],
      [array],
      [`()`],
      [Semantic annotations between node label and branches, e.g. `(("DP1", $lambda$),)`],
      table.hline(stroke: 0.25pt),
      [`annotation-size`], [number], [`0.70`], [Size multiplier for annotation text],
      table.hline(stroke: 0.25pt),
      [`annotation-leading`], [length or `auto`], [`auto`], [Line spacing for multi-line annotations],
      table.hline(stroke: 0.25pt),
      [`numbers`], [array], [`()`], [Circled numbers placed to the left of node labels, e.g. `(("DP1", 2),)`],
      table.hline(stroke: 0.25pt),
      [`numbers-size`], [number], [`0.85`], [Size multiplier for circled numbers relative to node labels],
      table.hline(stroke: 0.25pt),
      [`line-width`], [number], [`1.0`], [Stroke width multiplier for all tree lines],
      table.hline(stroke: 0.25pt),
      [`font`], [string], [`none`], [Font family used in the function (local scope)],
      table.hline(stroke: 0.75pt),
    )
  ] <tbl-args>

]


= How can I use Typst offline? <app-editor>

This vignette assumes that you know about Typst, but you may not be very familiar with it. That's why this section exists. For example, while the online app at #link("https://typst.app")[Typst.app] is very useful and practical, most of us prefer to work offline. *How can you use Typst offline then?*

One of the best IDE options out there is to use VS Code with the extension Tinymist @tinymist --- the extension is therefore available for Positron, which is the successor to RStudio. Tinymist is also available as a plugin for NeoVim users. All these options work extremely well because Tinymist is great, and I haven't had any issues thus far: compilation is instantaneous, and `bib` files also work flawlessly.#footnote[Provided that they are clean and do not have any problems regarding fields, repeated entries, etc.]

= How do packages work in Typst? <app-packages>

If you've used R, Python, #LaTeX, etc., you are used to installing packages and then importing them. This vignette has imported #logo, of course, which in turn imports CeTZ @cetz as a dependency. As you start using Typst, you will notice that it works a bit differently, and this may not be self-evident at first. As seen in @sec-installation, there are basically two ways to load and use a package, both of which require the function `#import` inside your `typ` document --- notice that you don't install a package _per se_. The traditional way is to import a package from the official Typst collection/repository, which means adding `#import "@preview/synkit:0.0.1": *` to your `typ` document if you plan on using #logo (assuming version `0.0.1`). The `@preview` bit indicates that the package comes from Typst's official repository. This is what you should do most of the time. Typst packages are cached once you compile a document with a given package.

Another option is to fork, clone or download a package from GitHub and import its `lib.typ` file instead: `#import "PACKAGE_DIRECTORY/lib.typ": *`. There's only one caveat: Typst restricts imports to files within the compilation root and its subdirectories (i.e., you can't load `lib.typ` if the package is in a parent directory or elsewhere in your system). Thus, you may need to use symlinks (this is the same strategy applied to `bib` files if you don't want to have a local copy of your references).

#figure(
  caption: [Creating a symlink to local package],
  supplement: "Code",
  kind: "code",
  ```bash
  # From your working directory:
  ln -s PATH_TO_PACKAGE_DIRECTORY package_name
  ```,
)

Finally, Typst's repository contains sub-directories to keep track of each version of a given package. When a package is updated, nothing happens to the existing version of the package. Instead, a new directory is added with the updated version. That's why you specify the _version_ of a package upon importing: `#import "@preview/synkit:0.0.1": *`. If you go to Typst's repository on GitHub, you will see that the repository for #logo has one sub-directory for each version of the package. This means that you always know which version of a package you are using. And because previous versions are not removed, backwards compatibility is not an issue. If you are used to #LaTeX and you have the habit of frequently updating your packages, you will appreciate this, as there's no risk of recompiling your document and running into errors because one of the packages you use has been updated with breaking changes.


#pagebreak()

= Additional trees

Example from #cite(<elliott2022and>, form: "prose", supplement: "p. 10") showing the flexibility of labels and the `numbers` argument.

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: (top, top),
    [
      #figure(
        caption: [Code for @fig-tree-numbers],
        supplement: [Code],
        kind: "code",
      )[
        ```typst
        #tree(
          "[<st,t> [\\lambda*p*] [t [<et,t> which employee] [<e,t> [\\lambda*x*]
              [t [<st,t> [<st,<st,t>> C_Q] [<s,t> *p* ] ] [<s,t> [\\lambda*w*]
                  [t [e [<e,e> @sg@ ] [e *x*] ] [<e,t> left_w] ] ] ] ] ] ]",
            color: (
              ("ett1", red),
              ("st1", blue),
            ),
            numbers: ( // labels strip ignore < > and , of nodes
              ("stt1", 5),
              ("t1", 4),
              ("et1", 3),
              ("stt2", 2),
              ("st2", 1),
            ),
            numbers-size: 1.2,
        )
        ```
      ] <code-tree-numbers>
    ],
    [
      #figure(
        caption: [Numbers and flexible labels (example with colors)],
        supplement: [Tree],
        kind: "tree",
      )[
        #tree(
          "[<st,t> [\\lambda*p*] [t [<et,t> which employee] [<e,t> [\\lambda*x*]
      [t [<st,t> [<st,<st,t>> C_Q] [<s,t> *p* ] ]
      [<s,t> [\\lambda*w*] [t [e [<e,e> @sg@ ] [e *x*] ] [<e,t> left_w] ] ] ] ] ] ]",
          // spread-local: (
          //   ("stt2", 1.5),
          //   ("ststt1", 1.8),
          // ),
          color: (
            ("ett1", red),
            ("st1", blue),
          ),
          numbers: (
            ("stt1", 5),
            ("t1", 4),
            ("et1", 3),
            ("stt2", 2),
            ("st2", 1),
          ),
          numbers-size: 1.2,
        )


      ] <fig-tree-numbers>
    ],
  )
]



