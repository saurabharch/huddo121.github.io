---
layout: post
title:  "On Playing with Elixir"
cover: potion_bottles_petr_kratochvil.jpg
date: 2016-12-31 10:45:00+11
cover_artist: Petr Kratochvil
cover_link: http://www.publicdomainpictures.net/view-image.php?image=47413&picture=potion-bottles
tags:
---

[Elixir](http://elixir-lang.org/) is a language I've been really wanting to toy with for a while. I've only done object oriented software development professionally, though in my readings of functional development some of the tenants have appealed to me. One thing that I've introduced in to my working life is a stronger leaning towards pure functions, which were used in the implementation of a validation and authorisation system. They're easy to read, easy to test and once you've gone to all the effort of getting the data you need they're really easy to reason about.

# Learn You A Thing

Part of my learning has been getting a copy of Programming Elixir. Luckily, when I was finally ready to undertake this journey a new edition (for Elixir 1.3) was being released, so I snapped up that version. It has been an interesting read, and has really helped to clarify some concepts that I was attempting to learn myself through the documentation. I had picked up a vague understanding of pattern matching from the official documentation and some other resources I was looking at, but I've always favoured the simple, more conversational explanations of things. If you simplify something down to an analogy that I can understand and I'll pick it up, quick smart.

One of the interesting points in the book that really had me worried early on was how it mentioned it may be difficult to unlearn some of the skills I developed and have honed over the years in order to become a good dev in Object Oriented languages. Specifically, there was a comment saying that I would have to stop thinking in terms of 'responsibilities of code', which is something I think about a lot, and governs a lot of the structure of the code I work on. It might take a while before it's equally second-nature for me to think in terms of "transformation of data".

{% include captioned_image.html image="sponserberleries.gif" %}

# Solving Sudoku

The first problem I wanted to tackle was solving sudoku puzzles, since I think it's complicated enough to cover a decent amount of the language but not so complicated as to be an intractable or nebulous problem to begin with. That said, in order to not have to learn too much too fast (I've never programmatically solved sudoku puzzles before) I opted for a "training wheels on" approach, by copying an existing implementation. My solution is based off of [Peter Norvig's solver](http://norvig.com/sudoku.html), but doing so presented its own challenges, which I'll cover in a little bit.

Peter's write-up is pretty good at explaining the steps of his solution, but I found I got a lot of value in seeing what some of the expected data is, especially in the early stages when I was still coming to grips with some of the operations and syntax of elixir.

Here's our playing field;

````
A1 A2 A3 | A4 A5 A6 | A7 A8 A9
B1 B2 B3 | B4 B5 B6 | B7 B8 B9
C1 C2 C3 | C4 C5 C6 | C7 C8 C9
---------+----------+---------
D1 D2 D3 | D4 D5 D6 | D7 D8 D9
E1 E2 E3 | E4 E5 E6 | E7 E8 E9
F1 F2 F3 | F4 F5 F6 | F7 F8 F9
---------+----------+---------
G1 G2 G3 | G4 G5 G6 | G7 G8 G9
H1 H2 H3 | H4 H5 H6 | H7 H8 H9
I1 I2 I3 | I4 I5 I6 | I7 I8 I9
````

For us to place a character in **cell** `E4` we would have to check that we haven't broken the rules of sudoku in the other 8 squares it shares a box with, all the cells in row E, and all the cells in column 4. These are the **peers** of cell E4. A set of mutual peers is called a **unit**, so there is a unit for each row, each column, and each box.

When playing with the solver we generate the following lists:

````
# List of row units
[["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9"],
 ["B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9"],
 ["C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9"],
 ["D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9"],
 ["E1", "E2", "E3", "E4", "E5", "E6", "E7", "E8", "E9"],
 ["F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9"],
 ["G1", "G2", "G3", "G4", "G5", "G6", "G7", "G8", "G9"],
 ["H1", "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9"],
 ["I1", "I2", "I3", "I4", "I5", "I6", "I7", "I8", "I9"]]

# List of column units
[["A1", "B1", "C1", "D1", "E1", "F1", "G1", "H1", "I1"],
 ["A2", "B2", "C2", "D2", "E2", "F2", "G2", "H2", "I2"],
 ["A3", "B3", "C3", "D3", "E3", "F3", "G3", "H3", "I3"],
 ["A4", "B4", "C4", "D4", "E4", "F4", "G4", "H4", "I4"],
 ["A5", "B5", "C5", "D5", "E5", "F5", "G5", "H5", "I5"],
 ["A6", "B6", "C6", "D6", "E6", "F6", "G6", "H6", "I6"],
 ["A7", "B7", "C7", "D7", "E7", "F7", "G7", "H7", "I7"],
 ["A8", "B8", "C8", "D8", "E8", "F8", "G8", "H8", "I8"],
 ["A9", "B9", "C9", "D9", "E9", "F9", "G9", "H9", "I9"]]

# List of box units
[["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"],
 ["A4", "A5", "A6", "B4", "B5", "B6", "C4", "C5", "C6"],
 ["A7", "A8", "A9", "B7", "B8", "B9", "C7", "C8", "C9"],
 ["D1", "D2", "D3", "E1", "E2", "E3", "F1", "F2", "F3"],
 ["D4", "D5", "D6", "E4", "E5", "E6", "F4", "F5", "F6"],
 ["D7", "D8", "D9", "E7", "E8", "E9", "F7", "F8", "F9"],
 ["G1", "G2", "G3", "H1", "H2", "H3", "I1", "I2", "I3"],
 ["G4", "G5", "G6", "H4", "H5", "H6", "I4", "I5", "I6"],
 ["G7", "G8", "G9", "H7", "H8", "H9", "I7", "I8", "I9"]]
````

Now, these peers are essentially the neighbours we have to check in order to see if any changes to a cell might break the rules of sudoku. We take these three lists, and transform them to a map such that for any cell we can find all the neighbours for that cell.

````
%{
  ...
  "B8" => ["B1", "B2", "B3", "B4", "B5", "B6", "B7", "B9", "A8", "C8", "D8", "E8", "F8", "G8", "H8", "I8", "A7", "A9", "C7", "C9"]
  ...
  "E3" => ["E1", "E2", "E4", "E5", "E6", "E7", "E8", "E9", "A3", "B3", "C3", "D3", "F3", "G3", "H3", "I3", "D1", "D2", "F1", "F2"]
  "E4" => ["E1", "E2", "E3", "E5", "E6", "E7", "E8", "E9", "A4", "B4", "C4", "D4", "F4", "G4", "H4", "I4", "D5", "D6", "F5", "F6"]
  "E5" => ["E1", "E2", "E3", "E4", "E6", "E7", "E8", "E9", "A5", "B5", "C5", "D5", "F5", "G5", "H5", "I5", "D4", "D6", "F4", "F6"]
  ...
}
````

Cool, we've got all of our lookup data set up now, which I store in [module attributes](http://elixir-lang.org/getting-started/module-attributes.html), so that I only have to evaluate them at compile time. From this point on, looking at Norvig's solution would probably beneficial, since it's explained in a lot greater detail than I would be willing to go in to here, this post is about elixir, not sudoku.

# The Joys of Elixir
Some of the syntax in elixir is a real treat. The pipe operator, `|>`, makes it dead easy to chain together a bunch of functions. My first use of it, to apply a series of transformations to the incoming raw puzzle text to a normalised puzzle string was one of those *"Phwoah yeah! This is awesome!"* moments.

Having `iex` at hand was great. I really appreciate being able to toy with my code in a REPL, and it made those first, difficult steps a bit easier. I'm a long-standing believer in real development speed being best achieved by having a real quick feedback loop, which things like test suites, REPLs and hot-loading all help to achieve.

This was especially true when I was trying to generate new data structures from existing ones. One thing I was really craving was a better UI for seeing my changes. There is some [impressive](https://www.youtube.com/watch?v=buPPGxOnBnk) [stuff](http://lighttable.com/) out there.

Pattern matching on responses from functions is great :ok_hand:. It just makes it so obvious as to what conditional code is doing. I also liked not having to know *every* single possible return value of a function to deal with its results. If something I didn't expect occurs, well, no matching pattern, program bails. This is probably the best possible result, since when compared to a bunch of conditional ifs that may not execute their contained code, leading to the program silently behaving in unexpected ways, it will be very obvious that something unexpected has occurred.

As a general comment, I seemed to be less concerned with writing defensive code, not sure if that's because I'm writing a toy or because I know if my pattern doesn't match the code will abort. No unexpected nulls to worry about here. Reading about Haskell's Option type being used to codify the fact that you may have to deal with a non-value as a possibility seemed like a pretty neat idea, which I might read a bit more in to in the coming months.

# Sometimes Good Medicine Tastes Bad
As expected, throughout my first foray in to functional programming, and a new language, I faced some difficulties.

{% include captioned_image.html image="sucking_at_something.gif" %}

In elixir, the result of the last bit of code that is executed is what is returned. Apparently this is on account of elixir being an expression based language. Another effect of this is that there's no return statement. You can't jump out of the function early, returning a specified value. This made transliterating some of Norvig's sudoku code across somewhat difficult. The [hammer](https://en.wiktionary.org/wiki/if_all_you_have_is_a_hammer,_everything_looks_like_a_nail) I managed to pick up to solve this problem was elixir's [Enum.reduce_while/3](http://elixir-lang.org/docs/stable/elixir/Enum.html#reduce_while/3) function. You can see the somewhat messy results of this in a few places in my solver :sweat_smile:.

Comprehensions were another tricky concept to deal with. I'm somewhat familiar with them, but I've only ever used python for a single course at university, so attempting to translate them to [elixir comprehensions](http://elixir-lang.org/getting-started/comprehensions.html) wasn't trivial. This was certainly not helped by Norvig's use of many single letter variables, some of which were redefinitions from what was passed in at the top of the function. Trying to keep everything straight in my mind while translating was quite tricky there. This did lead me to finding a neat feature of elixir (and python) comprehensions that I wasn't aware of, filters in comprehensions!

````
                                                               # Neato Filter!
searchable_puzzles = for {response, result} <- assign_results, response == :ok, do: result
````

Some of the IDE support could be better. It's all a community effort at the moment, but coming from Java + IntelliJ and C# + Visual Studio it's initially a bit of a shock to the system. This is the sort of thing that requires a lot of time (and maybe even a bit of corporate support) to really develop. I'm not an emacs or a vim native, and it looks like people comfortable with those editors may be in pretty good hands, but I'm not one of them.


# Solving Sudoku... Slowly
So, now we are seemingly able to solve sudoku puzzles, but even the easy ones are taking a few seconds. What's going on? Why is my code so slow?

Running the solver with tracing turned on (`mix profile.fprof`) didn't initially work. It would run for a while and then end with "Killed: 9". Watching the memory usage of the process it was up in the early-mid 30GB range before it died, so I'm guessing there's something going on there.

````
..................................................
.................................................,
..................................................
.................................................,
.........Killed: 9
````

Simply running the solver without tracing on a hard puzzle didn't cause any noticeable memory bloat, even though it was absolutely flogging the CPU, which was sitting pressed up at 100%. Sorting by memory usage I had to do a bit of scrolling to find a process for beam during this test, and the one with the most memory was sitting comfortably at ~38MB the entire time. Running the algorithm with some extra `IO.puts` output to indicate the depth of the search algorithm shows that it was hovering at around 12 - 14 levels deep most times on a hard puzzle, so the low and steady memory usage is in line with my expectations.

Taking the plunge in to elixir profiling is an adventure for next month. For now, [here's the code to the SudokuSolver at time of publishing <i class="fa fa-github"></i>](https://github.com/Huddo121/sudoku_solver/tree/cd6d71c58be5e907f50a91d100b6226a40e351d3). It will require a lot of cleanup, but I'll get to that when I'm making it faster.

# :confetti_ball: Happy New Year! :confetti_ball:
