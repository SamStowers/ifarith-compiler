# Discussion and Reflection


The bulk of this project consists of a collection of five
questions. You are to answer these questions after spending some
amount of time looking over the code together to gather answers for
your questions. Try to seriously dig into the project together--it is
of course understood that you may not grasp every detail, but put
forth serious effort to spend several hours reading and discussing the
code, along with anything you have taken from it.

Questions will largely be graded on completion and maturity, but the
instructors do reserve the right to take off for technical
inaccuracies (i.e., if you say something factually wrong).

Each of these (six, five main followed by last) questions should take
roughly at least a paragraph or two. Try to aim for between 1-500
words per question. You may divide up the work, but each of you should
collectively read and agree to each other's answers.

[ Question 1 ] 

For this task, you will three new .irv programs. These are
`ir-virtual?` programs in a pseudo-assembly format. Try to compile the
program. Here, you should briefly explain the purpose of ir-virtual,
especially how it is different than x86: what are the pros and cons of
using ir-virtual as a representation? You can get the compiler to to
compile ir-virtual files like so: 

racket compiler.rkt -v test-programs/sum1.irv 

(Also pass in -m for Mac)

The three files we wrote are:
q1arith.irv
mathTime.irv
ifnzTest.irv

Q1arith was the only file to give an output. MathTime encountered an error,
most likely due to idiv not working properly. ifnzTest also failed, because
the unconditional jump “jmp 5” does not simply jump to line 5. We could not
figure out how to the jmp call to work.

The pros of using ir-virtual is its simplicity. It is a small subset of
assembly that is much easier to create a compiler for. By swapping registers
on the stack, it is much easier to implement.

The cons of using ir-virtual is that it is not practical. The use of
registers is extremely inefficient, and any large computing task would not
run well on ir-virtual. It is also limited to the very small set of assembly
commands, so writing large ir-virtual programs would be difficult.


[ Question 2 ] 

For this task, you will write three new .ifa programs. Your programs
must be correct, in the sense that they are valid. There are a set of
starter programs in the test-programs directory now. Your job is to
create three new `.ifa` programs and compile and run each of them. It
is very much possible that the compiler will be broken: part of your
exercise is identifying if you can find any possible bugs in the
compiler.

For each of your exercises, write here what the input and output was
from the compiler. Read through each of the phases, by passing in the
`-v` flag to the compiler. For at least one of the programs, explain
carefully the relevance of each of the intermediate representations.

For this question, please add your `.ifa` programs either (a) here or
(b) to the repo and write where they are in this file.

The three files that we wrote are:
letTest.ifa
Q2iflet.ifa
example3.ifa

q2iflet.ifa looks like (let* ([a 10]
       [b -10])
  (if 1 (print (+ a 10)) (print (- b 10)))) it should return -20 by
  going to the else clause like if2.ifa however instead it returns
  4294967276.

letTest.ifa looks like (let* ([a 2]) (let* ([b 3]) (print (+ a b))))
The stacked let*s worked and it correctly returned 5

Example.ifa looks like (print (* (+ 5 6) (+ 7 8))) and correctly
returned 165


[ Question 3 ] 

Describe each of the passes of the compiler in a slight degree of
detail, using specific examples to discuss what each pass does. The
compiler is designed in series of layers, with each higher-level IR
desugaring to a lower-level IR until ultimately arriving at x86-64
assembler. Do you think there are any redundant passes? Do you think
there could be more?

In answering this question, you must use specific examples that you
got from running the compiler and generating an output.

The 6 layers are:
IfArith: A small subset of racket
IfArithTiny: A smaller subset of racket
ANF: Rewriting IfArithTiny to only do a single operation at a time
IR-Virtual: A simplified version of assembly with virtual registers
x86: assembly but with stack allocation
NASM: assembly file to be run by the computer

Each of these passes has its use, however it may be possible to
speed up the process by cutting out some of them. IfArith to ANF
would not be too much more difficult than IfArithTiny to ANF.

One example of the breakdown is included as the q3-1.png
and q3-2.png


[ Question 4 ] 

This is a larger project, compared to our previous projects. This
project uses a large combination of idioms: tail recursion, folds,
etc.. Discuss a few programming idioms that you can identify in the
project that we discussed in class this semester. There is no specific
definition of what an idiom is: think carefully about whether you see
any pattern in this code that resonates with you from earlier in the
semester.

One thing we recognized is that the registers are stored as a set. It folds over the registers used in the instructions to get a set of the registers.

There is also hash tables storing operations as keys in ir-virtual->x86

Much of ifarith->ifarith-tiny is tail recursive. One example is the uop match case, where it recursively checks after the uop to see if it is ifarith-tiny


[ Question 5 ] 

In this question, you will play the role of bug finder. I would like
you to be creative, adversarial, and exploratory. Spend an hour or two
looking throughout the code and try to break it. Try to see if you can
identify a buggy program: a program that should work, but does
not. This could either be that the compiler crashes, or it could be
that it produces code which will not assemble. Last, even if the code
assembles and links, its behavior could be incorrect.

To answer this question, I want you to summarize your discussion,
experiences, and findings by adversarily breaking the compiler. If
there is something you think should work (but does not), feel free to
ask me.

Your team will receive a small bonus for being the first team to
report a unique bug (unique determined by me).

Idiv - doesn’t work.
Mul - doesnt’t work.
Compiler doesn’t really work with negative numbers, tried subtracting 10 from -10 and got 4294967276.


[ High Level Reflection ] 

In roughly 100-500 words, write a summary of your findings in working
on this project: what did you learn, what did you find interesting,
what did you find challenging? As you progress in your career, it will
be increasingly important to have technical conversations about the
nuts and bolts of code, try to use this experience as a way to think
about how you would approach doing group code critique. What would you
do differently next time, what did you learn?

This project was a good introduction to the basics of the layers in a
compiler. Compilers don’t jump from the high level language straight to
assembly or binary, they can go layer by layer to make implementation
significantly easier.

One of the difficulties we had with this project was getting the code
to run in the first place. We found that the directions to get the code
to run were not comprehensive, and we had to do some testing with
Homebrew on Mac and Ubuntu on WSL to get the NASM linker to function
properly. It was also hard to tell if it was working, because the .irv
file we were using had an idiv call which we found out was wrong.

Writing test cases was also not incredibly straightforward, as we had
to ensure that our .ifa files were valid. Let instead of Let* made the
.ifa file not compile. Forgetting to include a print statement also
made it impossible to tell if the code ran correctly.


