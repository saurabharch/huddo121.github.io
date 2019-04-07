---
layout: post
title: "One Year with Haskell"
subtitle: An experience and a half
date: 2019-04-07 14:00:00+10:00
cover:
cover_artist:
cover_link:
tags:
---

About a year ago I started on a bit of a journey…

To set the scene, I’d been on a new team for a few months, and was still coming to grips with everything. The backend services that the team own are written in Scala, with a lot of functional programming concepts thrown in to the mix. There are Kleislis, lenses, and free monads abound! It was a lot to take in, but there weren’t enough opportunities to work on the backend to really come to grips with it all. I found a lot of the things I was seeing both confusing, yet utterly fascinating, and I hadn’t heard of any of it before.

{% capture dog_gif %}
{% include giphy.html image="xDQ3Oql1BN54c" %}
{% endcapture %}

{% include narrow.html content=dog_gif %}


**Authors Note**: I published the original version of this blog internally at work in January, 2019. This post has been modified to redact some details.


Even before I’d joined the team I’d been harbouring an interest in one day trying to figure out what all this “functional programming” stuff was all about. I’d made some half-hearted attempts to learn in the past, and to that end had tried to [pick up]({% link _posts/2017-07-11-on-getting-started-with-phoenix-v1-3-0.markdown %}) [Elixir]({% link _posts/2016-12-31-on-playing-with-elixir.markdown %}), but some of the ergonomics of the language annoyed me, so I dropped it.

{% include tweet.html tweet="940808905260716032" %}

In January 2018 some members of the [Queensland Functional Programming Lab](http://qfpl.io/) made the trip to Sydney to run a three day course, with a course for beginners, and an ‘applied course’ for building web apps. I went the beginners course, with a handful of other people from work. So begins the journey proper…

Haskell’s an interesting language, and going through the [fp-course <i class="fa fa-github"></i>](https://github.com/data61/fp-course) repo as a group was quite fun, especially with people available to explain some of the concepts and help out anyone that got stuck. We ran through basic syntax, language rules, how to read compiler errors, as well as the most fundamental typeclasses. The most satisfying day was the final one, where we finished building up a small parser combinator library and used it to parse some structured data.

Awesome! I’m a card-carrying hardcore functional programmer now, right? Eh, no, not even close. We’d not covered the entire fp-course repo over the three days, and so I had been spending some spare time to try and work through it on my own. I was able to work some stuff out, and sometimes get correct solutions by just following the types and using brute force, but I didn’t feel like I was really understanding any of the content. Filling in type holes is only mildly interesting, and it’s certainly a useful skill to have, but I wasn’t really building anything, and I was just getting stuck on little puzzles that I couldn’t work out. It wasn’t a fun time.

I had intermittently worked on a handful of little projects, and one big one where I definitely bit off more than I could chew. It was really here that I started to come to grips with all the stuff surrounding Haskell; build tooling, IDE tooling, package management, and API docs. At this point I actually was starting to learn a lot of things, and really going down paths on my own. I found I was picking up more as I was trying to solve real problems rather than type puzzles, which I’m sure was mostly because I kept harassing one of my coworkers to teach me stuff whenever I got stuck.

{% include captioned_image.html image="brian_fp_call_to_arms.png" %}

[Brian McKenna <i class="fa fa-twitter"></i>](https://twitter.com/puffnfresh) was in Sydney for LambdaJam, and was going to start a class for running through fp-course. It was only a one hour lesson, and was really just the intro to Haskell syntax, but I got value in hearing things explained to me in a different way. From then on, every Thursday at 8am, I’d hop on to a BlueJeans call where Brian would run through a part of the fp-course. I’d already covered a good chunk of the course, but I stuck with it, because every now and again, even in stuff I’d already completed, Brian would come up with some sort of intuitional way of thinking about something, and things would just click.

{% include tweet.html tweet="1006300349584404480" %}

Pearls like this were reason enough for me to stick to the lessons, and be able to ask questions about things was really helpful, especially as the herd thinned out. We worked through the rest of the course, and finished up by having a crack at the [Tic-Tac-Toe project](https://github.com/data61/fp-course/blob/deb52272e8d6fab18cc5024cabd01c065c7b6d42/projects/TicTacToe/TicTacToe.markdown), which combined a lot of the skills we had built up in the preceding months.

I kept working on random projects following the end of fp-course, and took the time to play around and get some experience with some really cool concepts and libraries. [Servant](https://haskell-servant.readthedocs.io/) has probably been one of my favourite discoveries. With Servant you define your web api as a type, and you can take that type and use it to make all sorts of assertions about your service. “Am i handling all inputs and HTTP methods”? “Am I responding with the right shape of data”? Or my favourite, “is my documentation up to date”? The [documentation](https://haskell-servant.readthedocs.io/en/stable/tutorial/index.html) for servant is pretty good too, and there are some more complete [examples](https://github.com/haskell-servant/servant/blob/master/doc/examples.md) of applications around, which are a real help when getting started.

And that’s where I am today, obviously still learning, but a lot more comfortable with both Haskell and FP.


## Lessons Learnt :eyeglasses:

### *Functional programming is an extremely transferable skill* :truck:
There were some things that I used to see in the fp-heavy code bases at work that I found confusing, and I could only work through my troubles via PR feedback or sitting down with someone. I don’t think this was the best way for me to go about things, I seem to learn the concepts better when I dealing with them in isolation, and when I’m able to build up some sort of intuitive understanding of what I am doing. As an example, after playing around with monad transformers in Haskell, when I revisted the Scala codebases at work there was suddenly more chunks of it that was no longer mysterious to me.

I’m guessing this is because everyone is going to try and represent the maths as best as possible in their language of choice, so within reason, once you learn the concept, it should apply everywhere.

### *Let the types guide you* 🧙
Sometimes you can sketch out a vague outline of your problem and let the compiler tell you what needs to change. This is really handy, because you can use it as a natural way to break down a more complex problem in to smaller and smaller sub problems. Any time I think I need to fold over some data I will habitually write something like `foldr _ Map.empty as` and let the compiler tell me what I need to put in place of the `_`.

Tools like [Hoogle](https://hoogle.haskell.org/) and [Hayoo](https://hayoo.fh-wedel.de/) allow you to search for functions based on type signatures. And you can run Hoogle locally if you want to make functions exposed in your own private libraries available for search. This meshes really well with type holes, because if you have a hole and you think to yourself “Surely someone has written this function before”, you’re probably right, and Hoogle will tell you about it.

Even if you’re trying to smash out a quick solution, wrapping things in `newtype`s and `data` types is really handy. It’s so quick and easy to do in Haskell, and helps you reason about your code when you’re looking at compiler errors. `newtype`s in particular are great, because despite something really just being a String, you’ve just made sure your sleepy head isn’t going to confuse a `userId :: String` and a `creditCardNumber :: String`, and accidentally send the wrong one somewhere you shouldn’t.

### *Don’t get hung up on IDE integration* :grimacing:
When I’d started out with Haskell, I had spent a lot of time trying to get a really good editor setup. I didn’t want much, I just wanted to be able to have some reasonable autocomplete and click-through definitions. This proved to be really difficult to get working reliably, or without some restrictions like “Only works with Stack projects”. I eventually spent a bunch of time to build out a [nix setup](https://github.com/huddo121/haskell-starter-webservice) that starts up [Haskell-Ide-Engine](https://github.com/haskell/haskell-ide-engine), a haskell Language Server, when you open the project in VS Code in a super repeatable way, involving as few impurities as possible.

It crashes sometimes. 🤷‍♂️

I expect HIE to improve over time, but at this point when it crashes I drop in to the nix-shell for the project I’m working on and start up [ghcid](https://github.com/ndmitchell/ghcid) on a separate monitor, which gives me super fast feedback. Matt Parsons' blog post “[ghcid for the win!](https://www.parsonsmatt.org/2018/05/19/ghcid_for_the_win.html)” was what inspired me to turn to ghcid, and it’s got some great tips.

### *Be mindful of the libraries you use* 📚
One problem with the Haskell ecosystem is that there are squillions of libraries, and sometimes it’s really hard to figure out which ones are quality. Some of them are massive mainstays, such as [Aeson](http://hackage.haskell.org/package/aeson), [QuickCheck](http://hackage.haskell.org/package/QuickCheck), and you’ll find a lot of other libraries plug-and-play with them, or have extra packages available to add support. I was using Advent of Code to experiment with libraries (such as [AttoParsec](https://hackage.haskell.org/package/attoparsec), [matrix](https://hackage.haskell.org/package/matrix), and [time](https://hackage.haskell.org/package/time)) and sometimes I had a bit of trouble deciding which one to use. For dealing with times, should I use [time](https://hackage.haskell.org/package/time), [hodatime](http://hackage.haskell.org/package/hodatime), or [hourglass](http://hackage.haskell.org/package/hourglass)? In this case, it doesn’t really matter, it’s toy code for solving toy problems, but you might need to spend more time investigating a library if you plan on deploying it in production.

Even the above mainstays I mentioned have more modern competitors, in [waargonaut](http://hackage.haskell.org/package/waargonaut) and [hedgehog](http://hackage.haskell.org/package/hedgehog). Let a thousand flowers bloom, by all means, but it’s quite overwhelming as a newcomer to the language and ecosystem. Bundles like [magicbane](https://github.com/myfreeweb/magicbane#readme) help, if only you know to look for it. The quality of the documentation also varies. Some libraries have really thorough documentation, and separate sites with great tutorials, but some just have basic haddock documentation. [Haddock](https://www.haskell.org/haddock/doc/html/index.html) itself is great though!

Even well-documented libraries like aeson sometimes leave me wanting more. I have a program that is consuming another API, but that API returns dates in two different formats depending on the timescale you make a request for. But not in a sensible way, it’s a standalone date field that is either returned as %Y%m%d or %Y-%m-%d 🤮. My searches for ways to have an aeson parse fail and try a different parsing method turned up nothing. I could probably use the [Alternative](http://hackage.haskell.org/package/base-4.12.0.0/docs/Control-Applicative.html#t:Alternative) typeclass to do this, but I haven’t had time to play with it. Without using the word “Alternative” in my searches, I couldn’t find anything that seemed promising, but as a beginner wanting to do something simple, if I didn’t know about the Alternative typeclass I’d be out of luck.

I view this as a consequence of functional programming. If you know the abstractions, you have the ability to write really beautiful code. But building up the initial knowledge base of functions and typeclasses and knowing what you need to complete the task at hand takes some time. I feel like it pays off, the earliest abstractions you learn are used constantly, and you can pick up different abstractions progressively as required.

### *Just build shit* 🚀
I’ve learnt the most from having to build something to solve a problem, even a contrived one. I’ve also taken the time to explicitly experiment when I’m trying to build something, using different libraries or ways of constructing programs rather than reaching for the (relatively few) tools I’ve already figured out.

One project I was working on involved accepting Haskell as an input via HTTP, building up a module, running some tests and returning a response to the user about whether their code compiled and passed the tests. It was gnarly, and I was extremely new to Haskell at the time, starting this project about one month after doing the three day course with Data61.

This taught me so much, not only about Haskell as a language, but all the peripheral stuff. It got me comfortable with untangling compiler errors, forced me to seek out a bunch of sources of documentation, and gave me hands on experience dealing with dependencies. It was also the application in question when I was working through my first experience of dockerising a Haskell application.

### *There are traps for young players* 💥
Despite Haskell leaning more towards catching problems at compile time rather than at runtime, there are still some ways you can hurt yourself. The following code snippet defines a data type `MyAPI` that can be constructed using either the `Request1` or `Request2` data constructors. This is done using record syntax, which is sugar for providing getter/setter-like functionality for your data constructors. You’ll notice that `Request1` has an extra field, that returns an `Int`. `attempts` will be a generated getter function that has the type `MyAPI -> Int`, which will accept any value of type `MyAPI`, including values created using the `Request2` data constructor, which doesn’t carry any `attempts` field. I’ve unwittingly introduced a partial function in to my code!

```haskell
data MyAPI = Request1 { name :: String, count :: Int, attempts :: Int }
          |  Request2 { name :: String, count :: Int}

hasMultipleAttempts :: MyAPI -> Bool
hasMultipleAttempts r = attempts r > 1

request = Request2 { name = "Mikey", count = 10 }
```

The above code example will compile happily, but if you try to apply `hasMultipleAttempts` to `request` you will get a `*** Exception: No match in record selector attempts` at runtime. 😵

This is preventable. By using `-Wpartial-fields` and `-Werror` compiler flags you can stop this from compiling, but it’s one of those cases where you realise the safety net might have holes. I think avoiding these sorts of problems is where having an experienced hand nearby would have helped.

There are also some unsafe functions in the standard library that will throw exceptions, such as [head](http://hackage.haskell.org/package/base-4.12.0.0/docs/Prelude.html#v:head). These should obviously be avoided.

### *Don’t fear compiler plugins* 🔌
I’m not really worried about code portability at this point in my Haskell career. Generally speaking, if someone says “Haskell compiler” they mean [GHC](https://www.haskell.org/ghc/), and GHC has a lot of plugins that are deviations from the [Haskell report](https://www.haskell.org/onlinereport/haskell2010/), which defines the language. Some are pretty ubiquitous, like OverloadedStrings, which allows you to put in a literal string in your code which will be converted to a richer type during compilation. One common place I’ve seen this used is to avoid using the inefficient “list of chars” `String` type in favour of Text (see [Data.Text](http://hackage.haskell.org/package/text-1.2.3.1/docs/Data-Text.html)) without having to manually `pack` and `unpack` everywhere. The neat thing is this isn’t a feature locked away for wild compiler-cowboys 🤠, just define an instance of [IsString](http://hackage.haskell.org/package/base-4.12.0.0/docs/Data-String.html#t:IsString) for your type and you’re good to go!

Servant makes use of some pretty wild looking extensions, but thankfully you don’t really have to understand them too much to [use them](https://haskell-servant.readthedocs.io/en/stable/tutorial/Client.html)! Because they use `:<|>` at both the type level and value level, you just need know that if you have a thing with the type `A :<|> B :<|> C` you can pattern match out an `A`, `B`, and a `C` using `a :<|> b :<|> c = thing`. Same operator, but at different levels. Neat!

Sometimes GHC will even tell you if you’re doing something that would probably compile if you enabled an extension. I’ll generally listen to it unless it sounds like a spooky extension, like `UndecidableInstances`.

## Conclusion
I never really understood why people were banging on about Haskell. After having spent a year playing with it, I get it now. I’m converted. My experiences with Haskell are going to inform a lot of the things I want from any programming language I use in the future, both good and bad.

### *Was it worth it?*
_Absolutely_. At this point Haskell is my current favourite language to write in. I’ve gotten to the point where I am at least as productive in it as I would be using Java+Spring at work.

### *Would I recommend someone learn Haskell and FP?* 🤔
I wouldn’t go so far as to make some broad sweeping statement that everyone should pick up Haskell. It has taken me some amount of time and effort to figure out the things I have, and there’s definitely an amount of frustration I had to work through in order to get there. If it’s something that interests you, definitely give it a go, but I’d recommend finding some sort of support network to help you out when you get stuck.

As for FP, the early abstractions really grant you a lot of power for very little investment. For some of the more complex abstractions, it helps (if it’s not a practical requirement) to have a language with a sufficiently expressive type system.

### *What would I even build in Haskell?* 🏚️
I’ve found Haskell to be really great for building web apps, and that’s mostly what I’ve used it for. A coworker has used Haskell to build a little application for walking dependency trees and then querying that tree for specific info. I think if I was building any sort of large parser or interpreter, Haskell would be a fine choice. Gabriel Gonzalez has a [pretty good breakdown](https://github.com/Gabriel439/post-rfc/blob/master/sotu.md) of what he thinks Haskell is good for.

I’d probably avoid Haskell for a bunch of number crunching tasks, I’ve not yet figured out the performance tricks I’d need for it to work out. This was something I also struggled with when trying to learn Elixir, and it bit me when doing Advent of Code for 2018.

### *Tell me more, tell me more!* 🌼
There are a large number of great blogs out there on Haskell, ranging from work-a-day-haskeller to moonlighting-as-a-category-theorist. I personally enjoy Matt Parsons' [blog posts](https://www.parsonsmatt.org/) for his pretty no-nonsense "Gettin' Shit Done" style of writing. I’ll sometimes also jump back to Alexis King’s “[An opinionated guide to Haskell in 2018](http://lexi-lambda.github.io/blog/2018/02/10/an-opinionated-guide-to-haskell-in-2018/)” post for quick breakdowns on language extensions I’m seeing.

I don’t really have any book recommendations, I didn’t really get too far through any of the several I have bought. I do occasionally reach for my copy of Real World Haskell ([available online for free](http://book.realworldhaskell.org/read)) when I want to read about something specific, but I’d advise against getting a physical copy of the book, it has some editorial problems.

For video content, I usually enjoy the more experience-report style talks, such as Kate Miller’s talk “[Haskell is Not For Production and Other Tales](https://www.youtube.com/watch?v=mlTO510zO78)”. My “Watch Later” playlist on YouTube is a wasteland of unwatched conference presentations and dead memes.


{% capture phew_gif %}
{% include giphy.html image="TiIAT3Yrv5rYTkM5hY" %}
{% endcapture %}

{% include narrow.html content=phew_gif %}

Phew! This was a bit longer than I initially expected.
