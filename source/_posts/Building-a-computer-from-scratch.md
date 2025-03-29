---
title: Computer Architecture from Scrath 
date: 2025-03-28
tags: [hexo, blog]
categories: [Development]
mathjax: true
---

<!-- # Computer Architecture -->

Today, we will try to build as much of a computer as we can, starting with some elementary building blocks. 

When I assembled the parts of a computer for the first time, it felt like I was an expert on computers. I was telling all my school friends about CPUs and GPUs and RAM without knowing much beyond single sentences such as “The CPU is like the brain of the computer.”, or “RAM stands for random access memory”. Random access, that seemed useless why would anyone want that? So today, we will shed some more light on the magic box that I am typing this on.

### Where to start?

As a child I liked to ask “why” in response to any answer I got to my initial question. As an adult, I feel not much different. However, I am more aware of the complexity of things and will need to get over myself and make some assumptions. Otherwise, we would be starting at physics topics I am not really interested in with regards to the current question. Also, this read would become infinitely long.

So let’s start with some assumptions:

1. Electricity works like water in my head. If I turn the tap on, the water runs. If I turn it off, it does not run. For our task, this should be good enough, but please know that there is more to it.
2. We also assume a few fundamental things already exist. Most notably, we will skip over the circuit logic needed to implement the NOT- and AND-Gates.

### Goal 1: Invert inputs.

Let’s start with a simple idea: I get electricity out of my socket. Let’s visualize this:

<p align="center"> {% asset_image image_0.png %}

I decided that when the electricity tap is open, I will mark this with a 1. If there is no electricity running, we mark it by 0. This is important.

Now, I assume that we can have a switch that can turn this electricity off and on.

<p align="center"> {% asset_image image_1.png %}

Not much so far. Let’s introduce a few new things. First up, the NOT-gate.

<p align="center"> <p align="center"> {% asset_image image_2.png %}

We can use this to invert the signal. If the water is flowing, this stops it. If the water is not flowing, this starts flowing. In the case of water, this is essentially magic. We could imagine this as a flood gate with two incoming streams. One visible that we see in the picture and a second one that is always flowing. If our first stream (the one control with the switch) is running, the floodgates stay shut. If that stream dries up, however, we let water run from the infinite second flow. In this triangle symbol, notice the small dot at the end of the triangle. This one will be important later.

<p align="center"> {% asset_image image_3.png %}

I think most won’t need convincing that inversion of inversion does nothing. That is, chaining two NOT-gates together is the same as not having any NOT-gates. In fact, we can generalize this and say that input is only inverted if there is an uneven number of NOT-gates in the system.

<p align="center"> {% asset_image image_4.png %}

## Goal 2: Combine Inputs

Let’s also introduce a second magic item. The AND-gate. This gate takes in two inputs like many other gates we will see. It then answers the question: “Are both inputs on?”, returning the answer as an output. If both are on, the AND-gate gives us 1 as output. Water is flowing. If both inputs are off or only a single one is on, the AND-gate returns 0.

We will use this funny-looking symbol for it. Flat on the input side, round on the output side.

<p align="center"> {% asset_image image_5.png %}

We can write this “logic” down in a so-called truth table:
| | | | | |
| --- | --- | --- | --- | --- |
| Input 1 | 1 | 0 | 0 | 1 |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | **0** | **0** | **0** | **1** |

Similarly, for the Not-gate:
| --- | --- | --- | 
| | | | 
| Input 1 | 0 | 1 |
| Output | 1 | 0 |

## Goal 3: The NAND-Gate

Now that we can combine and invert inputs, let’s play around with it a bit. If we just take a single AND for now, we can combine it with a NOT gate on its output. Can you guess what happens? Which outputs in the above truth will be on (1), which will be off (0)?

In this case, the obvious answer happens to be the correct one: the output is simply inverted. All 0s are replaced with 1s and vice versa. 

<p align="center"> {% asset_image image_6.png %}

With the associated truth table:
| | | | | |
| --- | --- | --- | --- | --- |
| Input 1 | 1 | 0 | 0 | 1 |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 1 | 0 |

We will make this a new component called the NAND- (not-AND) gate. Now, to give it a fun symbol, let’s combine the dot from the NOT-gate and put it on the output side of the AND-gate:

<p align="center"> {% asset_image image_7.png %}

The circle now indicates that the symbol is the same as the one it was based on (AND-gate), but the output is inverted.

## Goal 4: The NOR-gate

Okay, by inverting the output of the AND gates, we can build NAND-gates. But what about inverting the input on the AND gate? That is, what happens if we invert both inputs? (We will invert a single input later, be patient.)

<p align="center"> {% asset_image image_8.png %}

With the truth table:
| | | | | |
| --- | --- | --- | --- | --- |
| Input 1 | 1 | 0 | 0 | 1 |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 0 | 0 | 1 | 0 |

Okay, this reminds me of the AND-gate’s truth table. It seems like the output is only on when both inputs are off. Using only the AND-gate, the output was only on when both inputs were on. Somehow, this is also inverted, but differently.

The symbol of this gate looks like this:

<p align="center"> {% asset_image image_9.png %}

Which really does not make any sense without us first looking at how the gates we discovered relate. Let’s draw the relationship we observe out.

## Goal 5: De Morgan’s Law (1/2)

<p align="center"> {% asset_image image_10.png %}

Starting from the bottom left, we have our AND-gate. If we invert the output, we get the NAND-gate. So far, so good. Green arrows indicate inversion of output. Orange arrows inversion of input. If we invert both inputs on one gate, we travel back and forth along the orange arrows. One NOT-gate at the time. If you remember, the chaining even numbers of NOT-gates has the same effect as no not gates. This also makes sense in the picture below, where I get back to the same gate if I apply the same inversion again.

<p align="center"> {% asset_image image_11.png %}

This is very cool I think, but it seems like there is a gate missing: What happens if I invert the output of the NOR-gate or equivalently invert the input of the NAND-gate?

## Goal 5: OR-gate & De Morgan’s Law (2/2)

The answer is we get the “at-least” GATE, or put more simply the OR-gate:

<p align="center"> {% asset_image image_12.png %}

This is the Gate that I used as a child when my mum told me that I was allowed either chocolate or gummy bears at the supermarket, but I chose both. Clearly, she was unfamiliar with Boolean algebra. Note: Can you draw out the truth table she wanted instead?

Back from my digression, we are able to complete De Morgan’s law now by placing the OR-gate in its slot. 

<p align="center"> {% asset_image image_13.png %}

The OR-gate’s associated truth table is: 
| | | | | |
| --- | --- | --- | --- | --- |
| Input 1 | 1 | 0 | 0 | 1 |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 0 | 1 |

The dot at the end of the NOR gate also makes more sense now. It’s simply the OR-gate but with its output inverted. From what we saw thus far, the order of NOT- and AND-gates matters. Inverting the input to a gate must not be the same as inverting its output.

## Intermezzo: De Morgan’s Law in set theory

All the gates above are already highly exciting I know, but believe it or not we can do even more fun things with them. Each of them can be represented as a selection from some collection of unique elements (i.e., a set). 

If I have the set of S = {choosing gummy bears, choosing chocolate}, then we can display the space of all possible choices in the supermarket in a Venn diagram: Choosing gummy bears (A), choosing chocolate (B), choosing both (C) or choosing none of those options (U). In the below graphics, green = selected (1), purple = not chosen (0).

<p align="center"> {% asset_image image_14.png %}

<p align="center"> {% asset_image image_15.png %}

<p align="center"> {% asset_image image_16.png %}

<p align="center"> {% asset_image image_17.png %}

It becomes a bit clearer what my mum meant: choose A or B but not the intersection A ∩ B. Good to know, maybe a bit late for me but better than never.

## Goal 6: Making mum happy, the XOR gate.

I’ll try to redeem myself by implementing a gate that satisfies what Mum meant. Let’s start the other way around this time. Here is the truth table we want to have:

**Target Truth table:**
| | | | | |
| --- | --- | --- | --- | --- |
| Input 1 | 1 | 0 | 0 | 1 |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 0 | 0 |

We can chain different gates behind each other to exclude and include different parts of the set. My first thought is to start with an OR-gate. Its truth table is very close to what we want, except for the both-1-situation. 

**OR-Gate Truth Table:**
| | | | | |
| --- | --- | --- | --- | --- |
| Input 1 | 1 | 0 | 0 | 1 |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 0 | 1 |

Now we could combine this with a gate that has the opposite behavior. We need to somehow isolate the case where both inputs are 1. The gate we need is the NAND gate.

**NAND-Gate Truth table:**

| | | | | |
| --- | --- | --- | --- | --- |
| Input 1 | 1 | 0 | 0 | 1 |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 1 | 0 |

We want both conditions to be satisfied. Both the condition of the OR-gate and the NAND-gate. As the sentence suggests, we can use the AND-gate to test if both conditions are met:

<p align="center"> {% asset_image image_18.png %}

Great, this is what she was referring to: the exclusive OR-gate: the  XOR-gate.

XOR-Gate Truth table:
| | | | | |
| --- | --- | --- | --- | --- |
| Input 1 | 1 | 0 | 0 | 1 |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 0 | 0 |

What we built makes intuitive sense to me, but it may not be the shortest representation of this logic. If we need to build everything out of NAND and NOT gates, we need 3 NAND gates and 5 not gates:

| | | |
| --- | --- | --- |
|  | NAND gates needed | NOT gates needed |
| AND-gate | 1 | 3 |
| OR-gate | 1 | 2 |
| NAND-gate | 1 | 0 |
| **TOTAL** | **3** | **5** |

We can do better by just using 4 NAND or 5 NOR gates. 

<p align="center"> {% asset_image image_19.png %}

We can represent the same logic in different ways. I am sure the people designing CPU’s are thinking about this a lot. Let’s leave it to them for now.

## Goal 7: Are on/off states actually numbers?

So far we have been working with off and on states only. If we rethink that in terms of numbers, we get only two possible numbers 0 and 1. Let’s see what numbers in base ten (decimal) we are able to represent in this binary (meaning “two together”, “a pair”) system:

| | |
| --- | --- |
| Decimal (0-9) | Binary (0,1) |
| 0 | 0 |
| 1 | 1 |
| 2 | ? |

We can name this single digit binary number a “bit”. I happen to use numbers larger than 1 on a daily basis, so how can we represent them here?

In decimal, we actually have the same problem: We use higher numbers than 9 by just resetting the spot the 9 was in to 0 and incrementing the spot before it: 09, 10, 11, 12, etc. Let’s use the same approach in our binary system:
| | |
| --- | --- |
| Decimal (0-9) | Binary (0,1) |
| 0 | 0 |
| 1 | 1 |
| 2 | 10 |
| 3 | 11 |
| 4 | 100 |
| 5 | 101 |
| 6 | 110 |
| 7 | 111 |
| 8 | 1001 |
| 9 | 1010 |
| 10 | 1011 |
| … | … |

With every extra digit in the decimal system, we can represent 10 times more numbers: with 1 digit we can represent 10 numbers (e.g., 0-9), with 2 digits 100 numbers (e.g., 0-99), with 3 digits 1000 numbers (e.g., 0-999) etc. The formula for how many digits we can represent with $n$ digits is $10^n$. In binary, this works the same, but now we replace the ten with a two: $2^n$. We can cross-check our understanding with the table above. With a single digit, we can represent two numbers: 0, 1. With two digits, we can represent $2^2=4$ numbers: 0,1,2,3 in decimal. Notice how the largest number is one lower than the total numbers that we can represent: With 2 digits, hence 4 numbers we cannot represent 4 if we want to represent 0, 1, 2, and 3. Similarly in decimal, with ten numbers we cannot represent a ten with a single digit. The formula for the largest number that we can represent with $n$ digits is therefore $2^n-1$. 

Now that on and off states are suddenly numbers and not mere categorical states anymore, we can try to think about what we can do with those numbers.

## Goal 7: Half adder

Thinking of the on/off states as numbers gives us some ideas of what we expect to be able to do with those numbers. For example, how could I add two numbers together in this system?

Let’s use an example: 
| | |
| --- | --- |
| Decimal (0-9) | Binary (0,1) |
| 0 + 0 = 0 | 0 + 0 = 0 |
| 0 + 1 = 1 | 0 +   = 1 |
| 1 + 0 = 1 | 1 + 0 = 1 |
| 1 + 1 = 2 | 1 + 1  = 10 |

Alright, so the largest number we can have in binary is unsurprisingly 1. The smallest number that we can add that actually changes the number happens to be 1 too. This seems a bit annoying, but actually makes things very easy. Let’s try to build a small calculator for a single digit. We know the largest number that we can get with two digits in binary is 2, that is 10 in binary. So we know we need two output slots, one for the left-hand number and one for the initial digit on the right-hand side.

Let’s think about how to calculate the right spot first using a familiar tool: the truth table.

| | | | | |
| --- | --- | --- | --- | --- |
| Input 1 | 1 | 0 | 0 | 1 |
| t 2 | 0 | 1 | 0 | 1 |
| Right-hand number output (SUM) | 1 (1+0) | 1 (0+1) | 0 (0+0) | 0 (1+1= 10) |
| Left-hand number output (CARRY) | 0 | 0 | 0 | 1 |

Do you see a familiar pattern? Which logic gate almost magically matches this truth table? The answer is that addition in binary for the right-hand number is the same as the OR-gate. Similarly, the output pattern we need for the left-hand digit matches the AND-gate. We can rename those to match the naming standard we are used to from primary school studies: Sum and Carry. 

Let’s draw up this circuit and have a look at all possible states:

<p align="center"> {% asset_image image_20.png %}

The upper light bulb represents the SUM output, the lower lightbulb the carry output. Seems to work well for a single digit. I think we are ready for the next step. How about we try to impress our coworkers and add digits larger than one and zero?

## Goal 8: Full adder

We would like to chain the above circuits together in such a way that we can compute the value of each digit in our number from the previous digits. Much like in addition to paper, we need to consider both numbers and also the carry from the digit at the position below.

We could try to write down the truth table for this, but then we would need three inputs and two outputs. This would lead to 9 columns, which I cannot be bothered to draw out. Instead, let’s see how far our reasoning can get us.

First, if all values are zero, nothing happens. Secondly, if any of the three input values are 1 but the others are 0 there won’t be any carry. So far, so boring. Thirdly, if two of the three input values is 1, then we will definitely get a carry value because we know that 1+1 does not fit into a single digit (i.e. bit). In this case, those two will make the SUM value 0 + x, where x is the value of the last input.

To simplify the problem, we can just work on one part first: the SUM. 

### Calculating the SUM

We can start a bit silly and just chain two OR-gates. After all, this worked fine for two inputs and I said that the OR-gate is equivalent to Addition.

<p align="center"> {% asset_image image_21.png %}

Thankfully, it's not so simple and a bit more fun is involved. The OR-gate also outputs 1 if both the inputs are on. But now, we only want it if one of them is on. Let’s think back to what we want: Either one or three of the inputs are 1. Let’s simplify the problem even further, let’s assume we know the carry is 0. Then we know the truth table we need:

| | | | | |
| --- | --- | --- | --- | --- |
| Input 1 | 1 | 0 | 0 | 1 |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 0 | 0 |

Which we recognize as the XOR gate:

<p align="center"> {% asset_image image_22.png %}

Great, now we also need to test if either this case happens or (exclusively) the carry is 1. We can do this by chaining a second XOR gate behind the previous one.

<p align="center"> {% asset_image image_23.png %}

### Computing the CARRY

I am thinking about in which cases there will be a carry. If all values are 0 then, there obviously won’t be any carry. A carry can only appear when at least two of the bits we are adding are 1. This makes sense, because 1 is the largest number we can represent with one bit (in our coding scheme). So, for the carry, we will essentially have to answer the question: “Are there at least 2 inputs equal to 1?”. Or phrased differently: “Is there any pair of inputs on?”. 

Finding pairs is not so difficult, we already did this in the very first task using the AND-gate. Let us then make an AND-gate for all possible pairs and then check if any of those are on. This “Any” relationship we are looking for, we can represent with OR-gates. We don’t mind if there are multiple pairs that are turned on, because this only indicates that 3 of the inputs are on and we want a carry in that scenario too.

<p align="center"> {% asset_image image_24.png %}

This looks fun and simple enough, but let us think about it a bit more. Could we maybe reuse some of the logic we used in the SUM part of the adder? We know that the XOR-gate is only active when there is exactly one of its inputs equal to 1. We can limit the problem space again by assuming one of the inputs is off. Then we could use the first XOR-gate to answer the question “Is there only one of the inputs equal to 1?”. We can then check if the carry AND the XOR-output is off to check two pairs at once!

<p align="center"> {% asset_image image_25.png %}

If all three of the inputs are on, the XOR-gate will output 0 and the AND gate above will not activate. We can fix this problem and test the last pair in one go, which we can do as I did in my initial idea. Then we test if either of those two pairs is active using an OR-gate as before. The OR-gate does not care how many inputs are active, so we can happily feed it two active pairs.

<p align="center"> {% asset_image image_26.png %}

Great, we can now add 3 bits together, which is perfect to compute the carry from the bit on the position right before this one. Let’s try to stack these so that we can add numbers with multiple digits together.

## Goal 9: 4-bit adder

This may look a bit messy, but is just the same as we did before. We can now add two numbers, by adding them together position by position. For example, here 1011 and 0001, which in decimal are $11+1=12$. The fun thing here is that we get two carries, one at the second position and another one at the third position. The second observation here is that the first adder is getting a constant 0 input for the carry. This makes sense since there was no previous position. We could actually just replace it with a half adder, but I wanted to keep it consistent. Lastly, the last carry is going into nowhere. We will always have this problem if we restrict the number of digits. We know that for 4 bits like below, there are $2^4=16$ numbers we can represent, with 15 being the largest. If we get a result larger than this, the calculation is not correct. We get integer overflow.

<p align="center"> {% asset_image image_27.png %}

The 8-bit version of this module will be useful later: 

<p align="center"> {% asset_image image_28.png %}

Note that this “Ripple-Carry Adder” ([https://www.sciencedirect.com/topics/computer-science/ripple-carry-adder](https://www.sciencedirect.com/topics/computer-science/ripple-carry-adder)), clearly is not the most efficient. Computing the most significant bit (bit at largest position) needs all previous operations to be completed. The longer the integer we feed into the system, the longer the idle time of components (i.e., processing time grows linearly, $O(N)$). 

Also notice how I added the non-inverting version of the NOT-gate: The non-inverting buffer,

<p align="center"> {% asset_image image_29.png %}

which, for our purposes, will not do anything. It takes the input and simply forwards it.

## Goal 10: Negative numbers

### 10.1 Sign-magnitude representation

There are various ways of expressing negative numbers in binary. The simplest way I can think of is flipping a single bit (let’s take the most significant one) to indicate if a number is negative (1) or not (0 and positive numbers). For example, with a 4-bit integer, we could only use the 3 least significant bits to actually store any information.

$0001 → one$

$1001 → minus\ one$

This is called **sign-magnitude representation**. Can you guess what the problem is now? Which numbers can we represent?

This representation alone is a bit annoying to deal with because now we have two zeros:

$1000→zero$

$0000→zero$

Let’s now try to do addition:

$3 + (-3) = 0011 + 1011 = 1110 = -5$

That’s not very convenient at all if I want to do calculations. I am sure there is a way to resolve this issue, but maybe there is a better approach to this. Now, what do I have to do to make addition intuitive? That is, how can I represent it as a series of bitwise operations that are simple and fast?

### 10.2 One’s complement

Let’s think about how we are used to this in the decimal system. Subtraction is the same as addition but with the second number inverted (by multiplication by -1). For example:

$2-2 = 2 + (-2) = 2 + (-1 * 2) = 0$

Let’s try to define the inversion operation with the bitwise NOT-gate like we are used to. All 1s become 0 and all 0s become 1:

$two = 0010$

$minus\ two = 1101$

Adding both numbers together using the Adder we made before gives us:

$0010 + 1101 = 1\ 0000$

The leading 1 in the result is our carry, which we toss away in our 4-bit adder. The result having a non-zero carry on the most significant bit is called *overflow*. Using this logic, we notice that:

| Decimal | Binary | Inverted Binary |
| --- | --- | --- |
| 0 | 0000 | 1111  |
| 1 | 0001 | 1110 |
| 2 | 0010 | 1101 |
| 3 | 0011 | 1100 |
| 4 | 0100 | 1011 |
| 5 | 0101 | 1010 |
| 6 | 0110 | 1001 |
| 7 | 0111 | 1000 |

Now addition is simple between some numbers but does not really work out how we would want between all. For example:

$one + zero = 0001 + 1111 = 1\ 0000$, which after dropping the leading carry, would just be zero. This obviously makes no sense. We could try fixing the situation by wrapping the last carry around the end to the least significant bit, resulting in $0001$. Still, we would be left with two zeros, a positive zero and a negative zero. This is confusing, to say the least. 

### Two’s complement

We can combine both previous ideas into one. We start with One’s complement, but now instead of wrapping the carry of the largest number around, we just always add 1 after the inversion. 

| Decimal | Binary | Inverted Binary | Inverted + 1 |
| --- | --- | --- | --- |
| 0 | 0000 | 1111 | 0000 |
| 1 | 0001 | 1110 | 11111 (-1) |
| 2 | 0010 | 1101 | 1110 (-2) |
| 3 | 0011 | 1100 | 1101 (-3) |
| 4 | 0100 | 1011 | 1100 (-4) |
| 5 | 0101 | 1010 | 1011 (-5) |
| 6 | 0110 | 1001 | 1010 (-6) |
| 7 | 0111 | 1000 | 1001 (-7) |
| 8 |  |  | 1000 (-8) |

In this system, we notice two things. First, to get more negative numbers, we need to count down from 1111. This leads to the largest negative number being 1000. Secondly, at the cost of having only one zero, we now have one more negative number than positive numbers (i.e., the 8). This system of describing negative numbers is called **two’s complement**. The circuit that implements this inverts all bits of the input individually using NOT-gates and then uses the adder circuit from before to add +1. This “negator” circuit for 8 bytes will be represented as such:

<p align="center"> {% asset_image image_30.png %}

## Goal 11: Tri-state buffer

We will need a new basic magic component for our later implementations. The tri-state buffer. This component sounds more fancy than what it is: A flood gate with a control input.

We already got to know the non-inverting and inverting (NOT-gate) buffers:

<p align="center"> {% asset_image image_31.png %}

The tri-state buffer works similar to the non-inverting buffer but has a second, control input. If the control input is not on, the gate is disconnected and does not send any 1 or 0 signal down the path. Instead, it sends a third (hence tri-state) type of state, the Hi-Z state. This opens the output channel up for other gates to input without short-circuiting the system. We can imagine this as the wire being cut through. Here, the associated truth table:

| | | | | --- |
| --- | --- | --- | --- | --- |
| Data Input | 1 | 0 | 0 | 1 |
| Control Input | 0 | 0 | 1 | 1 |
| **Output** | Hi-Z | Hi-Z | 0 | 1 |

<p align="center"> {% asset_image image_32.png %}

We can obviously chain these tri-state buffers to use a single control bit signal to turn a series of inputs on and off. From now on, I will try to wrap components into more abstract representations that we can use in our computer later. Here the 8-bit tri-state buffer:

<p align="center"> {% asset_image image_33.png %}

I will be highlighting bytewise (e.g., 8-bits at once) with blue fields.

## Goal 12: Data selector (MUX)

We can use this newfound item to build an input selector. That is, a new component called a Multiplexer (i.e. MUX) that will be able to select between two inputs based on a third. We can use our new tri-state buffer for this.

We want one of the tri-state buffers to return Hi-Z while the other one is passing through the input as follows:

<p align="center"> {% asset_image image_34.png %}

Alternatively, we could also have used gates, which does use a bit more space:

<p align="center"> {% asset_image image_35.png %}

Note that we are able to chain these two-input multiplexers behind each other to act as a multi-input selector. For now, let’s create a abstract representation of this block for 8-bit data again:

<p align="center"> {% asset_image image_36.png %}

## Goal 13: Decoders

The MUX can encode which out of $n$ inputs should be selected. Let’s now think about doing the (almost) inverse. We will need to be able to map a state of one or more bits to a single output. For example, if I have 2 inputs, I can represent 4 states. To be able to make decisions based on a state that is made up out of multiple bits we will need to write a decoder.

Let’s start small: With one bit we can have two states. So we need two outputs. One will need to be one when all others (in this case only one other) is off. The NOT-Gate comes to mind:

<p align="center"> {% asset_image image_37.png %}

This is the simplest 1-bit decoder that I can think of. It demonstrates nicely what we want. One state of the input relates to one output outputting one and the rest zero. Now let’s make it a bit larger and do two bits. With two bits we can have 4 states. The truth table that we would like is the following:

| | | | | | | |
| --- | --- | --- | --- | --- | --- | --- |
| Decimal input state index | Input 1 | Input 2 | Output 1 | Output 2 | Output 3 | Output 4 |
| 1 | 0 | 0 | 0 | 0 | 0 | 1 |
| 2 | 0 | 1 | 0 | 0 | 1 | 0 |
| 3 | 1 | 0 | 0 | 1 | 0 | 0 |
| 4 | 1 | 1 | 1 | 0 | 0 | 0 |

From the above 1-bit decoder, I can see a combinatorial problem here. We will need an inverted and non-inverted wire for each input. This gives us 4 wires. We then need to combine each pair of two in some way and pass that to the respective output. Here the idea I am having:

<p align="center"> {% asset_image image_38.png %}

But how to combine each pair of these? We want to only give an input if there is a unique state (e.g., 01) across all inputs. Let’s try to think about state 00 first and maybe we will get an idea. For this state, we need to have both inputs 1 or equivalently both inverted inputs off. Either of the two will do. We can test if both inputs are on using the AND-gate as we did before. Similarly with the 11 state but inverted.

<p align="center"> {% asset_image image_39.png %}

I hope it becomes clear now what I was talking about when I said that I see a combinatorial problem. Concerning the last two inputs, we just map the second two to their respective states.

<p align="center"> {% asset_image image_40.png %}

We will use represent this circuit in a simplified for later:

<p align="center"> {% asset_image image_41.png %}

For a larger decoder, we can simply extend the design downwards. Here a 3-bit version:

You may be able to notice that some of the AND-gates can be used multiple times.

<p align="center"> {% asset_image image_42.png %}

For example, here the 001 state and the 101 state both share the left most state. You can see that we would have been able to save 1 AND-gate in the second row (where 001 is being decoded). We will need this decoder to make sense of multiple inputs and control what our computer will do. Again, we wrap this into a simplified representation for later:

<p align="center"> {% asset_image image_43.png %}

I was sneaky and added a “disable” input as well, which is just another layer of AND-gates with the inverted “disable” input. When the input is turned on, the decoder will be disabled and all outputs will be 0. We will need this in our computer later.

## Goal 14: Saving 1 bit

By now we understand binary inputs as numbers, have a way of selecting inputs and do some arithmetic on these numbers. However, we have now way of storing our inputs and outputs yet. We will definitely need to be able to store intermediate results if we want to do more complex calculations. The alternative would be to always build a new circuit, but without a way to quickly assemble such a circuit on the fly, this does not seem feasible. Let’s start with a single bit.

So far, we have only looked at logic that did not depend on the order of previous operations. It never mattered what configuration of inputs came before the next. If we want to save a bit, we will need to change this, which we can do by connecting the output of a gate back into it.

<p align="center"> {% asset_image image_44.png %}

This is nice, but we also need a way to reset this circuit back to the off state. Let’s try to add a second button and extend our design from above.

<p align="center"> {% asset_image image_45.png %}

This circuit has the same problem. There is no way of turning the circuit off once it is in the on state. We need to invert the output of our OR-gates for this. As a reminder, here is the NOR-gate truth table:

| | | | | |
| --- | --- | --- | --- | --- |
| Input 1 | 1 | 0 | 0 | 1 |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 0 | 0 | 1 | 0 |

I rebuilt this circuit from above using NOR-gates. This works as we want. We can cycle through the sequential states of saving a state:

<p align="center"> {% asset_image image_46.png %}

This gives us the following truth table for the **SR-Latch**:
| | | | | |
| --- | --- | --- | --- | --- |
|  | 1. | 2. | 3. | 4. |
| Reset | 0 | 0 | 1 | 1 |
| Data | 0 | 1 | 0 | 1 |
| Output | nothing changes | Out = 1 | Out = 0 | Invalid state |

It does not make much sense to set both inputs to 1, because then would be telling our circuit two opposing things.  This circuit is called the Set-Reset-Latch or simply SR-latch. Now let’s see if we can modify this input to be a bit more intuitive. I would like a single input and a “save” button. We could imagine that we have some state of a document for example, and then we would like to save that state.

So we want two things: 

1. Single Save Button
2. Single Data input

If we look at the above truth table, we can reason about how we can make that happen. The “save” button should toggle between state 1 where nothing changes and states 2,3 where we can set the new value. We can start by implementing this “save” button using two AND-gates:

Gated S-R latch:

<p align="center"> {% asset_image image_47.png %}

Now we are able to enable and disable the latch by using a third switch. This is nice, part 1 is done. We only need to get rid of the “reset” input now. Looking at the above truth table (again i know), we notice that when the latch is on, we can deduce the state of the Reset button from the state of the data. It is always inverted. If we were to feed the inverted data input to the reset input, we could easily accomplish the same! This also avoids us tapping into the invalid state where both reset and data are 1. 

We arrive at the final result, the **D-latch:**

<p align="center"> {% asset_image image_48.png %}

This is great! We can save the data stream just like we wanted when we press save. We could now also add a load condition that outputs the output to something when a third input is true the same way. 

<p align="center"> {% asset_image image_49.png %}

<p align="center"> {% asset_image image_50.png %}

<p align="center"> {% asset_image image_51.png %}

<p align="center"> {% asset_image image_52.png %}

### 13.1: Saving more bits.

We can tile this just like we did with the 4-bit adder to save as many bits as we want:

<p align="center"> {% asset_image image_53.png %}

And load the stored data:

<p align="center"> {% asset_image image_54.png %}

Again, we can compartmentalize this logic in a block:

<p align="center"> {% asset_image image_55.png %}

I have added a field for the output that will get the output only when load is on like above. However, maybe we want to have a second option and be able to just read the field at any time. For this, I have added a separate output that is only for reading the contents of the register. Again, blue circles refer to byte-wise input and outputs.

## Goal 15: Defining instructions

We would like our computer to be able to take in a list of instructions and give us some output. Let’s think about the instructions. If we want to pass in an instruction, we need to encode it in some input state. We know the circuits we build so far can only work with binary inputs, but generally are expandable as to how many input states there are inserted. Let’s limit ourselves to 8-bit instructions so that the task remains contained.

To do something with an instruction, it needs to have some meaning. Let’s select the two most significant bits to determine that meaning and the rest be the data.

<p align="center"> {% asset_image image_56.png %}

If we think about what sort of things I would like to do with my computer, then I know I would like to take two numbers and combine them in some way and save the result. Just like with a calculator. There are obviously a bunch of other things I would like my computer to do, but these are the simplest that I can think of, given the logic that we have already implemented. We know that our computer will have to work with a set of binary inputs and we also know that these can be understood to be numbers. Now, the next logical step is to build from there and see that we are able to do operations on these numbers. 

Let’s define the instructions that we want and encode them into the two bits we selected:

| | |
| --- | --- |
| 00 |  |
| 01 | Do some calculation. |
| 10 | Copy a value. |
| 11 |  |

I obviously left out two states, but bare with me for now. We will find some more interesting actions that we would like to assign to those states. For now, we know that we will need some registers to save values, something that can do calculations and something that decodes what the instruction means. We can start with just saving and copying values between registers.

I have changed to a bit of a different representation to make it a bit less messy for us. Blue connections will be used to refer to BYTE transfer. A byte is 8 bits. We can imagine such a blue wire as just 8 different wires next to each other. Black wires are single bit wires and green wires are single bit wires with the 1 state. For example, the 8-bit version of the tri-state buffer we discussed before will look like this:

<p align="center"> {% asset_image image_57.png %}

This will be our starting point. We expect that there will be some long string of 0s and 1s that encode the instruction. The instruction address takes a number as input that denotes the index of the byte that we have to read. The output just outputs the bytes. Secondly, we also have separate data input and output streams. These contain the numbers that we perform the operations on. We assume some hidden process here that will provide us with the right numbers at the right time. It could for example be that, much like the program instruction input, the data input just has a long list of numbers that is defined before and is then read into the program. Not very dynamic but good enough for now.

<p align="center"> {% asset_image image_58.png %}

### Goal 15.1 Copying values

I will first decode the byte into its separate bits.

<p align="center"> {% asset_image image_59.png %}

We want to be able to copy between two registers and an input stream and output stream. For this, we obviously need to have some registers, so I will add four to our architecture. Note, that this can be as many as we want.

We will need to define a set of instructions for the copy operation between registers and input and output. Let’s use this convention: Out of the 6 left-most bits in the instruction, we use the three most significant ones to determine the location to copy from and the three least significant ones to determine the location to copy to. 

<p align="center"> {% asset_image image_60.png %}

| Decimal index |  | From | To |
| --- | --- | --- | --- |
| 0 | 000 | Register 0 | Register 0 |
| 1 | 001 | Register 1 | Register 1 |
| 2 | 010 | Register 2 | Register 2 |
| 3 | 011 | Register 3 | Register 3 |
| 4 | 100 | - | - |
| 5 | 110 | Data input | Data output |
| 6 | 111 | - | - |

For example, I would like to copy a value from the input to the output. I know I will need to say “copy” by setting the two most significant bits to the state “01”: 01 000 000. Next, I know that the “from” field should be 110 and the “to” field should be “000”, because these map to the input and register 0 respectively. The correct instruction string then is 01 110 000. 

In a second example, imagine we want to copy from register 2 to register 1. Again we know the prefix is “01” to indicate a copy instruction. Next, we need to look up the fields for the involved registers and come up with 01 010 001.

Let’s try to implement this logic. First, we need to decode all three sets of bits: the two bits indicating the action to be taken, the “copy from” and the “copy to”.

<p align="center"> {% asset_image image_61.png %}

Let’s start with our second example. I would like to copy a value from register 2 to register 1: 01 010 001. For this, I will need to do three things:

1. Connect the output of register 2 to the input of register 1
2. Enable both decoders
3. Set the “load” and “read” fields of the respective registers.

<p align="center"> {% asset_image image_62.png %}

Doing this for registers, as well as the input and output, completes the copy implementation. 

<p align="center"> {% asset_image image_63.png %}

Let’s move on to the second part of the logic we wanted to implement: Computation. 

## Goal 16: Arithmetic and Logic Engine (ALU)

It would be useful to integrate all the operations that we have learned to implement so far into a single block. We could then pass the data as well as a selection input to the block and let it spit out the result. This block could be split up into two parts: One that does all the logic operations (or, nand, nor, and) and one that does all arithmetic (addition) operations. This time, let’s start with the abstract representation. There should be two inputs and one output. Additionally, there should be one input that decides the operation we would like to have:

<p align="center"> {% asset_image image_64.png %}

The “opcode” field decides which operation we would like to do. Let’s associate some numbers to the operations:

| Opcode | Binary Opcode | Operation |
| --- | --- | --- |
| 0 | 001 | OR |
| 1 | 010 | NAND |
| 2 | 011 | NOR |
| 3 | 100 | AND |
| 4 | 101 | ADD |
| 5 | 110 | SUBTRACT |

We should add this to our instruction as well. We can use the three least significant bits of our instruction to encode the type of computation when the most significant bit are set to the “computation mode” (01) as such:

$01 000 000 = OR$

$01000010 = NAND$

$01000011 = NOR$

$01 000 100 = AND$

$01 000 101 = ADD$

$01000110 = SUBTRACT$

For this exercise, I will be using the byte variants of the basic logic gates to make the illustration a bit clearer. These can simply be understood as doing the operation of the gate for each input bit. Following De Morgan’s laws from earlier, we know that the operations we want are all related and can be encoded in terms of one of the gates in the diagram combined with inversion of input or output.  We can use the multiplexer (MUX) from before to decide which combination should take place: Should the input be inverted? Should the output be inverted? We are left with the circuit for the “logic” part of the ALU.

<p align="center"> {% asset_image image_65.png %}

Now we need to implement addition and subtraction. We know that subtraction is just the same as addition of a number with a negative number. We can use the negator we discovered earlier to invert the second number and pass that to our 8-bit adder.

<p align="center"> {% asset_image image_66.png %}

You may notice that I added an extra AND- and OR-gate to select the input of the MUX. Naturally, we could have used the decoder we built earlier instead of decoding the state with those two gates. 

Next, we can wire up the ALU to do computations between fixed registers. Here we stand before the decision as to which registers to do the computation with. We could add additional logic to our instruction code to determine the registers, but do not have enough bits. I chose to just fix the registers that we can do the computations with. This effectively forces the programmer to move the to-be-computed data into the correct registers before the computation. We could do better, but this does not limit the amount of possible computations in any way, but computation may take more operations. I determine that computations must happen with Input 1 coming from register 1, input 2 from register 2 and output is loaded into register 3. Lastly, let’s add an 8-bit tri-state buffer to enable and disable the module.

<p align="center"> {% asset_image image_67.png %}

Let’s add the circuit to our computer. For this, we need to make sure to enable when in use and also add an extra OR-gate for the load operation on Register 3, since now there are multiple ways of loading a value into this register. 

<p align="center"> {% asset_image image_68.png %}

## Goal 16: Program Counter

When we set out to build this computer, we decided that the input should come as one large string of bits, with us selecting 8 at the time and forwarding these to the splitter. However, we need to provide an index of which 8-bit block to select and forward. Currently, there is no input to the program block, so we will always be reading the first index. We should think about what we want. When I read a recipe, the instructions are provided in order: 1. Boil water 2. Clean potato. 3. Peel potato, etc. The index increments by one with every completed step, just like a counter would. We need one!

For a counter, we will need to store data. Let’s start with a known building block from when we built our 1-bit register in chapter 14: the SR-latch. 

<p align="center"> {% asset_image image_69.png %}

Previously, we then extended to this intermediate representation with an “enable” input. 

<p align="center"> {% asset_image image_70.png %}

with the associated truth table:

| Enable | 1 | 1 | 1 | 1 | 0 |
| --- | --- | --- | --- | --- | --- |
| Reset | 0 | 0 | 1 | 1 | any |
| Data | 0 | 1 | 0 | 1 | any |
| Output | nothing changes | Out = 1 | Out = 0 | Invalid state | nothing changes |

We went on to replace the “reset” button with the inversion of the data input to form the D-latch. This time, we won’t do that and introduce something else instead. The problem with the S-R-Latch was that we could hit an invalid state when all three inputs are one. In this case, we are telling the latch to latch high (1) and latch low (reset, 0) at the same time. This leads to race between both inputs to determine the output - not ideal to say the least. We can think about what this state should encode from looking at the above truth table. We have a way to do nothing, set output 1, set output 2, but no way to do the opposite of doing nothing: doing whatever action possible that would change the state of the system, a toggle between states. We can implement this by chaining another AND-gate behind the existing AND-gates and feed back the output of the opposing side. As it turns out, this preserves the logic of the SR-latch but adds the wanted behavior for the 11 state:

<p align="center"> {% asset_image image_71.png %}

Unfortunately, if we leave the enable input there out, the latch will jump back and forth between the two states. This is not good. We will need an element that gives us a strong but also very brief charge increase from state 0 to 1 back to 0. Turns out this is where the clock of the computer comes in. The clock will do something very simple, it will continuously flip the switch for us.

### 16.1 Clock

Over time, the clock we just thought of will be flipping between the two states 0 and 1. 

<p align="center"> {% asset_image image_72.png %}

I would like to add a bit more nuance here. Technically, the states 0 and 1 do not exist in the way I drew them out but represent a difference in voltage. The clock continuously flips between high and low voltage states, creating the pattern we observe above. The associated symbol is:

<p align="center"> {% asset_image image_73.png %}

You may now wonder how this is helpful at all to us, since the phase for each state is still long. For this, we will add a circuit behind the clock that looks like this:

<p align="center"> {% asset_image image_74.png %}

We know that each component is built up of transistors. These can only *almost* instantaneously pass on the signal, but there is a small delay. In this case, it takes the signal longer to pass through the NOT-gate than through the unobstructed wire. When the clock switches from low to high, for a very brief moment, both inputs to the AND-gate are high and the AND-gate forwards this. We have built a method to detect low-to-high cycle changes, a **rising edge detector**. We will use the combination of clock and rising edge detector to pass the signal through our computer. The output of this combination gives us the following waveform.

<p align="center"> {% asset_image image_75.png %}

A short note on clock speed. Before this chapter, we have always assumed that the signal passes instantly. However, as we know now, each component has a cost of time associated with them. The computer that we are building has components that are very complex and need the signal to pass through others first. Take the Ripple-carry-adder for example. There, we can only start adding the next larger bit when the previous position is finished. In practice, this means that we would need to have a slower clock speed for our computer to ensure that all computation paths can be passed in a single cycle. This is particularly bad if the operation we want does not take very long at all, but since the clock is stepping ahead at a constant speed, we have to wait. Which raises an interesting challenge where we try to find ways to avoid waiting for previous components and move onto the next computation sooner, being able to increase the clock speed of the computer and its computation speed. I also find it interesting to think about the alternative, where we may not try to do a full computation in one cycle. Instead, we could try to break it up into smaller operations such that a single operation may take multiple cycles. This would have no impact on larger operations in terms of time, but since we know that the longest an operation could possibly need in the computer is much shorter, we are able to increase the clock speed. Lastly, if the computer has some means of predicting how long an operation may take, it would be able to adjust the clock speed dynamically, while still guaranteeing correctness of output. In our computer, we will put all of that aside and just use a slow enough clock speed.

### 16.2 J-K-flip flop & Ripple counter

We can now complete our circuit called the J-K-flip flop from before:

<p align="center"> {% asset_image image_76.png %}

Which has the associated truth table:

| Clock/ enable | 1 | 1 | 1 | 1 | 0 |
| --- | --- | --- | --- | --- | --- |
| Reset | 0 | 0 | 1 | 1 | any |
| Data | 0 | 1 | 0 | 1 | any |
| Output | nothing changes | Out = 1 | Out = 0 | toggle | nothing changes |

We can wrap this circuit into modules again as such,

<p align="center"> {% asset_image image_77.png %}

and combine into a counter. In this counter, we use the inverted output of the JK-flip flop as the clock signal for the next flip-flop. Going from left to right, each clock signal will toggle the first JK-flip flop between outputs 0 and 1. The inverted output will obviously be the other binary digit. This makes it so that the next JK-flip flop will flip only when the inverted input is 1. This happens every other pulse. A falling edge/ transition from 1 to 0 will not trigger a toggle of the next flip-flop. The third flip flop will be dependent on the one before, etc. This leads the nth JK-flip flop to be toggled after $1/2^{(n-1)}$ flips of the first flip-flop. Effectively counting up. Also note how the output of this counter has the most significant bit on the farthest to the right position. 

<p align="center"> {% asset_image image_78.png %}

Similar to our ripple-carry adder design, the computation speed of this ripple counter increases linearly with the number of digits in the counter. There are fun ways to improve this, but let’s not get too sidetracked. Instead, we should think about what we do if we want to do more than just move to the next instruction.

### 16.3 Condition instruction

If we want to repeat the same operation multiple times in our current design, we would need to provide it multiple times to the instruction set. This is not only very dumb, bloats the program, but also restricts some of the operations that we can do. Branching is completely impossible. That is, if we want different instructions to be executed based on the result of previous computation or we cannot do this. We should, therefore, add a “condition” instruction to our instruction set:
| | |
| --- | --- |
| 00 |  |
| 01 | Do some calculation. |
| 10 | Copy a value. |
| 11 | Condition |

We know two things will be needed to implement this: First, a block that decides on the new position to be passed with associated instructions. Secondly, we need to be able to override the counter with the new value. After that, it should continue counting from that new value onwards. We need a “set value” button.

Seeing we are currently working on the program counter anyway, let’s avoid shifting focus and start with the second problem. For this we can try to add a second control path to our counter. 
For example, to set a flip-flop to 1, feed `J = 1` and `K = 0` when Load is active. Similarly, to set it to 0, feed `J = 0` and `K = 1`. Since we will be sharing the inputs, we need to make sure to not short circuit the whole thing. I have created a two bit version of the design we would need below.

<p align="center"> {% asset_image image_79.png %}

But since I am the one writing this text, I can do whatever I want - and I want something a bit simpler. Let’s take a step back and evaluate what we need. 

1. Increment with every clock cycle
2. Storing input bits.
3. Returning input bits.

Now, painfully obvious, we could have accommodated the second two requirements with our 8-bit register from earlier. Incrementing is just adding by 1 and we have also designed an adder before. Can introduce the clock by just using the gated S-R latch from 13.1 and replacing the enable input with the clock.

Counter V2:

<p align="center"> {% asset_image image_80.png %}

Much simpler to read for me. Adding the enable logic is almost trivial now compared to designing an entirely new circuit, because there is only a single input loop that we need to protect with tri-state buffers. 

<p align="center"> {% asset_image image_81.png %}

I am very happy about this! Let’s make it a module and wire it up to the rest of the computer:

<p align="center"> {% asset_image image_82.png %}

Similar to when we implemented calculations with the ALU, I made the decision that the input override value can only come from a specific register. This time, I chose Register 0. Notably, we are still missing the block that makes the override dependent on the data. In the current setup, the condition instruction would always override the counter value with the value in register 0. Let’s have a look at that next.

<p align="center"> {% asset_image image_83.png %}

## Goal 17: Condition Engine

When the instruction code is 11, we decided that conditional branching should happen. This means we need to compare two values. For simplicity, let's compare the three least significant bits from register 3 against zero. The type of comparison done by the condition engine will be determined by the three least significant bits in the instruction. The output of the engine will be 1 if the condition is met and 0 otherwise.

| Opcode | Mode |
| --- | --- |
| 000 | Output is 0 |
| 001 | Input = 0 |
| 010 | Input < 0 |
| 011 | Input ≤ 0 |
| 100 | Output is 1 |
| 101 | Input  **≠ 0** |
| 110 | Input ≥ 0 |
| 111 | Input > 0 |

Modes 100 and 000 do not do any comparison but allow us to just directly output a value we want. Let’s start with the simple parts, testing if a number is negative and if a number is 0. We can use our knowledge of two’s complement for this. If we add a number to itself, we know that we can only have a carry if the number was negative. For any number larger or equal to zero, we will be getting an even number, which will not result in a carry. Even when we try to create overflow, we can only get even numbers out. The largest number we can get with overflow is -2. This is because, if you remember, we added +1 after the bitwise bit-flipping of a positive number to get a negative number. In the below illustration, this is encoded by the bottom adder.

Secondly,  the adder that has the output of the bitwise NOT-gate as input tests if the number is equal to zero. It only does this if the Opcode is 1, otherwise the output of the carry will always be zero. We know that the only number that can result in zero if a carry is added (via the opcode) is -1. Again, applying our knowledge of two’s complement, the output of this adder only has a carry if there the input was 0. 

### First Adder

Case 1: When OFF

- Output is always zero

Case 2: When ON

- If value equals zero → returns 1

### Second Adder

- For positive values → no carry → outputs 0
- For zero → no carry → outputs 0
- For negative values → carry → outputs 1

Now the OR- and XOR-gate in the circuit exploit symmetries in the opcode that allow us to cover the rest of the cases. It’s a bit easier to show than to explain. Let’s go through the cases together:

To test if the value is smaller or equal to zero , we only need to check if the value is smaller or equal to zero. The OR-gate handles this naturally.

To test if the value is unequal to zero, we check if the value is equal to zero and the most significant bit in the 3-bit opcode is on. If it is on, we know that we cannot be in any of the equal, smaller or smaller and equal situations. If the value is equal to zero, then the XOR-gate will return zero. If the value is negative, the bottom adder may return one, but this signal is blocked by the AND-gate.

To test if a value is larger or equal to zero, we check if that the value is not negative first. This test is executed by the adder, AND and XOR-gate. We are basically going on the assumption that the value is larger or equal to zero, then test if it is negative with the bottom adder. The upper adder is effectively turned off without a carry input.

To test if a value is strictly larger zero, we turn on all the tests to evaluate ≤ 0 on as before. If none of them pass, the XOR-gate does not get a second one as input and outputs one. 

Finally, I would like to note that the second half of the circuit could be replaced with a full adder and only taking the sum output. My initial design did not include adders at all, but I will save you from it this time.

<p align="center"> {% asset_image image_84.png %}

Plus a compact version again for our computer 

<p align="center"> {% asset_image image_85.png %}

### 17.1 Integrating the condition engine

Let’s add the condition engine to our computer to allow for conditional code execution! As we previously discussed, we take the instruction as a condition, the value from register 3. If we are then in condition mode AND the condition is satisfied, we forward the value to the program counter override.

<p align="center"> {% asset_image image_86.png %}

## Goal 18: RAM

We still have a possible instruction left for which I have two ideas.

 Idea nr. 1 is that we introduce a read operation from a specific memory location in RAM. That is, we could just tell the computer that we need to read from a specific address in RAM. RAM would then just be a large block of memory with an index that we can provide to get a specific address. We could then also provide where to load this into. 

<p align="center"> {% asset_image image_87.png %}

Which we could hook up like this, not forgetting to turn on the decoder for reading into the correct register:

<p align="center"> {% asset_image image_88.png %}

With possible opcodes structured like this:
| | |
| --- | --- |
| 00 | Load from RAM |
| 01 | Do some calculation. |
| 10 | Copy a value. |
| 11 | Condition |

Just as with the copy instruction, we can use the existing logic for the register “save to?” selection, leaving us the three least significant bits to read the index in the RAM. Now, 2^3=8 addresses is really not much, but enough to give us an idea of what could be possible.

Annoyingly, we do not have enough bits to store a write to ram operation. But we can still reason what this would entail. We would need to turn the output of the register to read from on and then read from the common wire (i.e., the Bus). We then would need to enable write on the RAM and provide an index/ address to write to.

## Goal 19: Immediate values

My second idea was that we use so-called immediate values with the opcode 00.
| | |
| --- | --- |
| 00 | Immediate |
| 01 | Do some calculation. | 
| 10 | Copy a value. |
| 11 | Condition |

Since the opcode happens to be 00, the byte is preserved in the number it represents in the 6 least significant bits. We could just load this directly into a register - effectively saving us a few copy operations from the data input into the register we want. 

For this, we need to pass the byte value directly to the bus and add an OR-gate to the load operation of a fixed register (e.g., Register 0).

<p align="center"> {% asset_image image_89.png %}

## Goal 20: CPU

We have finished the computer! We can now compute whatever we want, copy values, understand negative numbers, add them, subtract them, conditionally execute code based on data and pass values directly from the program into the register. To those missing multiplication and division in the circuit, don’t worry. We can represent these in our instruction as a series of repeated addition or subtraction. But you do have a point. We have not implemented everything you may expect. Modern CPUs have multiple registers, caches of decreasing size to operate faster on data that is likely needed, are able to predict branching and add additional, optimized circuits for common operations like multiplication, division, fused-multiply-add etc. There is much more to design and implement here. Depending on the use case of our computer, different components may be relevant. 

## Sources

- Inside the Machine: An Illustrated Introduction to Microprocessors and Computer Architecture
- [https://riscv.org/](https://riscv.org/)
- [https://www.youtube.com/watch?v=wRIys1pzCMA](https://www.youtube.com/watch?v=wRIys1pzCMA)
- [https://www.youtube.com/watch?v=PVNAPWUxZ0g](https://www.youtube.com/watch?v=PVNAPWUxZ0g)
- [https://www.youtube.com/watch?v=PVNAPWUxZ0g](https://www.youtube.com/watch?v=PVNAPWUxZ0g)
- [https://www.youtube.com/watch?v=F1OC5e7Tn_o](https://www.youtube.com/watch?v=F1OC5e7Tn_o)
- [https://turingcomplete.game/](https://turingcomplete.game/)
- [https://www.youtube.com/watch?v=CRVpoTZ8mn4](https://www.youtube.com/watch?v=CRVpoTZ8mn4)
- [https://www.youtube.com/watch?v=sJXTo3EZoxM](https://www.youtube.com/watch?v=sJXTo3EZoxM)
- [https://www.youtube.com/@BitMerge](https://www.youtube.com/@BitMerge)





<!-- ----------------- -->

<!-- ---
OLD stuff

 Alternatively, we could try to split the space in the middle by assigning all numbers on the upper half of the $2^n$ numbers to positive numbers and the lower half to negative numbers. For example like:

$0000→negative\ eight$

$0001→negative\ seven$

…

$0111 → negative\ one$

$0001 → zero$

$0010 → positive\  one$

…

$1111 → positive\ seven$

I also added a zero to our method, but now we are missing one of the positive numbers! Seems like there is no way of generating an even amount of positives and negatives if we want a zero as well. But this system, you might agree, is a bit confusing. Why can’t zero just map to $0000$ only. What do we have to do to make that happen?

Let’s go back and think about what we want. 

1. $0000→zero$
2. Arithmetic should be simple.

The answer is **two’s complement.** We adapt our second approach but this time let’s combine it with our first. We still use the most significant bit as an indicator of (1) negative and (0) non-negative. This makes sure that $0000$ maps to zero in decimal. Now, the only problem we are left with is the second zero $1000$. What value do we have to assign for this to make sense?

We would also li

- still would like to have a continuous number space where nearby binary numbers excluding the sign bit are also near in
- math’s now very simple

## 

## 

## Counter

Legal RISC-V instructions

[https://learning.edx.org/course/course-v1:LinuxFoundationX+LFD111x+1T2024/block-v1:LinuxFoundationX+LFD111x+1T2024+type@sequential+block@7b88b9ba824c4b97a201330c55074857/block-v1:LinuxFoundationX+LFD111x+1T2024+type@vertical+block@5443695770284485b9fccb813406d134](https://learning.edx.org/course/course-v1:LinuxFoundationX+LFD111x+1T2024/block-v1:LinuxFoundationX+LFD111x+1T2024+type@sequential+block@7b88b9ba824c4b97a201330c55074857/block-v1:LinuxFoundationX+LFD111x+1T2024+type@vertical+block@5443695770284485b9fccb813406d134)

l all instructions are 32 bits

RISC-V diagram

https://learning.edx.org/course/course-v1:LinuxFoundationX+LFD111x+1T2024/block-v1:LinuxFoundationX+LFD111x+1T2024+type@sequential+block@6ad4eaf3dacc4d6b91dbbf22d3525800/block-v1:LinuxFoundationX+LFD111x+1T2024+type@vertical+block@753da4bde1264bd39b9c543c20817723

- 
- logic is fun and all but what if we want to do some maths?
    - wait it’s the same in binary?
    - let’s just implement something for additon
        - half adder
        - full adder
        - 8 bit adder
    - ALU

Notice, how we are avoiding something I personally always found very annoying: In the decimal system, carry can be larger than 1, when the teacher decided it was time to confuse us. Here, we do not have that problem, we can either have a carry of zero, which does nothing; or we can have a carry of 1 which can only have two effects: Either the next digit will be 1 or 0. Easy. We can still have the “avalanche-like” effect of how two ca

- storage
    - delay line
    - 1 bit storage
    - 8 bit storage
    - etc
        - why memory gone if turn electricity off
- add some
- Why? I need to be able to add numebrs and stuff to make decisions. I would like for my computer to count things and we will see how else we can use this logic for more general use cases.
- add some sources

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 0 | 0 |

<p align="center"> {}

<p align="center"> {% asset_image image_91.png %}

<p align="center"> {% asset_image image_92.png %}

[https://www.notion.so](https://www.notion.so)

[https://www.notion.so](https://www.notion.so)

<p align="center"> {% asset_image image_93.png %}

<p align="center"> {% asset_image image_94.png %}

<p align="center"> {% asset_image image_95.png %}

<p align="center"> {% asset_image image_96.png %}

<p align="center"> {% asset_image image_97.png %}

<p align="center"> {% asset_image image_98.png %}

| Reset | 0 | 0 | 1 | 1 |
| --- | --- | --- | --- | --- |
| Data | 0 | 1 | 0 | 1 |
| Output | nothing changes | Out = 1 | Out = 0 | Invalid state |

<p align="center"> {% asset_image image_99.png %}






 -->














<!-- ---
title: My Blog Post
date: 2025-03-28
tags: [hexo, blog]
categories: [Development]
mathjax: true
---

# Computer Architecture

Today, we will try to build as much of a computer as we can starting with some elementary building blocks. 

When I assembled the parts of a computer for the first time, it felt like I was an expert on computers. I was telling all my school friends about CPUs and GPUs and RAM without knowing much beyond single sentences such as “The CPU is like the brain of the computer.”, or “RAM stands for random access memory”. Random access, that seemed useless; why would anyone want that? So today, we will shed some more light onto the magic box that I am typing this on.

### Where to start?

As a child I liked to ask “why” in response to any answer I got to my initial question. As an adult, I feel not much different. However, I am more aware of the complexity of things and will need to get over myself and make some assumptions. Otherwise, we would be starting at physics topics I am not really interested in with regards to the current question. Also, this read would become infinitely long.

So let’s start with some assumptions:

1. Electricity works like water in my head. If I turn the tap on, the water runs. If I turn it off, it does not run. For our task, this should be good enough, but please know that there is more to it.
2. We also assume a few fundamental things already exist. Most notably, we will skip over the circuit logic needed to implement the NOT- and AND-Gates.

### Goal 1: Invert inputs.

Let’s start with a simple idea: I get electricity out of my socket. Let’s visualize this:

<p align="center"> {% asset_image image_0.png %}

I decided that when the electricity tap is open, I will mark this with a 1. If there is no electricity running, we mark it with 0. This is important.

Now, I assume that we can have a switch, that can turn this electricity off and on.

<p align="center"> {% asset_image image_1.png %}

Not much so far. Let’s introduce a few new things. First up, the NOT-gate.

<p align="center"> <p align="center"> {% asset_image image_2.png %}

We can use this to invert the signal. If the water is flowing, this stops it. If the water is not flowing, this starts flowing. In the case of water, this is essentially magic. We could imagine this as a flood gate with two incoming streams. One visible that we see in the picture and a second one that is always flowing. If our first stream (the one control with the switch) is running, the flood gates stay shut. If that stream dries up however, we let water run from the infinite second flow. In this triangle symbol, notice the small dot at the end of the triangle. This one will be important later.

<p align="center"> {% asset_image image_3.png %}

I think most won’t need convincing that inversion of inversion does nothing. That is, chaining two NOT-gates together is the same as not having any NOT-gates. In fact, we can generalize this and say that input is only inverted if there is an uneven number of NOT-gates in the system.

<p align="center"> {% asset_image image_4.png %}

## Goal 2: Combine Inputs

Let’s also introduce a second magic item. The AND-gate. This gate takes in two inputs like many other Gates we will see. It then answers the question: “Are both inputs on?”, returning the answer as an output. If both are on, the AND-gate gives us 1 as output. Water is flowing. If both inputs are off or only a single one is on, the AND-gate returns 0.

We will use this funny looking symbol for it. Flat on the input side, round on the output side.

<p align="center"> {% asset_image image_5.png %}

We can write this “logic” down in a so-called truth table:

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | **0** | **0** | **0** | **1** |

Similarly for the Not-gate:

| Input 1 | 0 | 1 |
| --- | --- | --- |
| Output | 1 | 0 |

## Goal 3: The NAND-Gate

Now that we can combine and invert inputs, let’s play around with it a bit. If we just take a single AND for now, we can combine it with a NOT gate on its output. Can you guess what happens? Which outputs in the above truth will be on (1), which will be off (0)?

In this case the obvious answer happens to be the correct one: The output is simply inverted. All 0s are replaced with 1s and vice versa. 

<p align="center"> {% asset_image image_6.png %}

With the associated truth table:

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 1 | 0 |

We will make this a new component called the NAND- (not-AND) gate. Now, to give it a fun symbol, let’s combine the dot from the NOT-gate and put it on the output side of the AND-gate:

<p align="center"> {% asset_image image_7.png %}

The circle now indicates that symbol is the same as the one it was based on (AND-gate), but the output is inverted.

## Goal 4: The NOR-gate

Okay, by inverting the output of the AND gates, we can build NAND-gates. But what about inverting the input on the AND gate? That is, what happens if we invert both inputs? (We will invert a single input later, be patient.)

<p align="center"> {% asset_image image_8.png %}

With the truth table:

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 0 | 0 | 1 | 0 |

Okay, this reminds me of the AND-gate’s truth table. It seems like the output is only on when both inputs are off. Using only the AND-gate, the output was only on when both inputs were on. Somehow, this is also inverted, but differently.

The symbol of this gate looks like this:

<p align="center"> {% asset_image image_9.png %}

Which really does not make any sense without us first looking at how the gates we discovered relate. Let’s draw the relationship we observe out.

## Goal 5: De Morgan’s Law (1/2)

<p align="center"> {% asset_image image_10.png %}

Starting from the bottom left, we have our AND-gate. If we invert the output, we get the NAND-gate. So far so good. Green arrows mean inversion of output. Orange arrows mean inversion of input. If we invert the both inputs on one gate, we travel back and forth along the orange arrows. One NOT-gate at the time. If you remember, the chaining even numbers of NOT-gates has the same effect as no not gates. This also makes sense in the picture below, where I get back to the same gate if I apply the same inversion again.

<p align="center"> {% asset_image image_11.png %}

This is very cool I think, but it seems like there is a gate missing: What happens if I invert the output of the NOR-gate or equivalently invert the input of the NAND-gate?

## Goal 5: OR-gate & De Morgan’s Law (2/2)

The answer is we get the “at-least” GATE, or put more simply the OR-gate:

<p align="center"> {% asset_image image_12.png %}

This is the Gate that I used as a child when my mum told me that I was allowed either chocolate or gummy bears at the supermarket, but I chose both. Clearly, she was unfamiliar Boolean algebra. Note: Can you draw out the truth table she wanted instead?

Back from my digression, we are able to complete De Morgan’s law now by placing the OR-gate in it’s slot. 

<p align="center"> {% asset_image image_13.png %}

The OR-gate’s associated truth table is: 

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 0 | 1 |

The dot at the end of the NOR gate also makes more sense now. It’s simply the OR-gate but with its output inverted. From what we saw thus far, the order of NOT- and AND-gates matters. Inverting the input to a gate must not be the same as inverting its output.

## Intermezzo: De Morgan’s Law in set theory

All the gates above are already highly exiting I know, but believe it or not we can do even more fun things with them. Each of them can be represented as a selection from some collection of unique elements (i.e., a set). 

If I have the set of S = {choosing gummy bears, choosing chocolate}, then we can display the space of all possible choices in the supermarket in a Venn diagram: Choosing gummy bears (A), choosing chocolate (B), choosing both (C) or choosing none of those options (U). In the below graphics, green = selected (1), purple = not chosen (0).

<p align="center"> {% asset_image image_14.png %}

<p align="center"> {% asset_image image_15.png %}

<p align="center"> {% asset_image image_16.png %}

<p align="center"> {% asset_image image_17.png %}

It becomes a bit clearer what my mum meant: choose A or B but not the intersection A ∩ B. Good to know, maybe a bit late for me but better than never.

## Goal 6: Making mum happy, the XOR gate.

I’ll try to redeem myself by implementing a gate that satisfies what Mum meant. Let’s start the other way around this time. Here is the truth table we want to have:

**Target Truth table:**

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 0 | 0 |

We can chain different gates behind each other to exclude and include different parts of the set. My first thought is to start with an OR-gate. Its truth table is very close to what we want, except for the both-1-situation. 

**OR-Gate Truth Table:**

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 0 | 1 |

Now we could combine this with a gate that has the opposite behavior. We need to somehow isolate the case where both inputs are 1. The gate we need is the NAND gate.

**NAND-Gate Truth table:**

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 1 | 0 |

We want both conditions to be satisfied. Both the condition of the OR-gate and the NAND-gate. As the sentence suggests, we can use the AND-gate to test if both conditions are met:

<p align="center"> {% asset_image image_18.png %}

Great, this is what she was referring to: the exclusive OR-gate: the  XOR-gate.

XOR-Gate Truth table:

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 0 | 0 |

What we built makes intuitive sense to me, but it may not be the shortest representation of this logic. If we need to build everything out of NAND and NOT gates, we need 3 NAND gates and 5 not gates:

|  | NAND gates needed | NOT gates needed |
| --- | --- | --- |
| AND-gate | 1 | 3 |
| OR-gate | 1 | 2 |
| NAND-gate | 1 | 0 |
| **TOTAL** | **3** | **5** |

We can do better by just using 4 NAND or 5 NOR gates. 

<p align="center"> {% asset_image image_19.png %}

This is fun, we can represent the same logic in different ways. I am sure the people designing CPU’s are thinking about this a lot. Let’s leave it to them for now.

## Goal 7: Are on/off states actually numbers?

So far we have been working with off and on states only. If we rethink that in terms of numbers, we get only two possible numbers 0 and 1. Let’s see what numbers in base ten (decimal) we are able to represent in this binary (meaning “two together”, “a pair”) system:

| Decimal (0-9) | Binary (0,1) |
| --- | --- |
| 0 | 0 |
| 1 | 1 |
| 2 | ? |

We can name this single digit binary number a “bit”. I happen to use numbers larger than 1 on a daily basis, so how can we represent them here?

In decimal, we actually have the same problem: We use higher numbers than 9 by just resetting the spot the 9 was in to 0 and incrementing the spot before it: 09, 10, 11, 12 etc. Let’s use the same approach in our binary system:

| Decimal (0-9 | Binary (0,1) |
| --- | --- |
| 0 | 0 |
| 1 | 1 |
| 2 | 10 |
| 3 | 11 |
| 4 | 100 |
| 5 | 101 |
| 6 | 110 |
| 7 | 111 |
| 8 | 1001 |
| 9 | 1010 |
| 10 | 1011 |
| … | … |

With every  extra digit in the decimal system, we can represent 10 times more numbers: with 1 digit we can represent 10 numbers (e.g., 0-9), with 2 digits 100 numbers (e.g., 0-99), with 3 digits 1000 numbers (e.g., 0-999) etc. The formula for how many digits we can represent with $n$ digits is $10^n$.  In binary, this is works the same, but now we replace the ten with a two: $2^n$. We can cross-check our understanding with the table above. With a single digit, we can represent two numbers: 0, 1. With two digits, we can represent $2^2=4$ numbers: 0,1,2,3 in decimal. Notice how the largest number is one lower than the total numbers that we can represent: With 2 digits, hence 4 numbers we cannot represent 4 if we want to represent 0, 1, 2, and 3. Similarly in decimal, with ten numbers we cannot represent a ten with a single digit. The formula for the largest number that we can represent with $n$ digits, is therefore $2^n-1$. 

Now that on and off states are suddenly numbers and not mere categorical states anymore, we can try to think about what we can do with those numbers.

## Goal 7: Half adder

Thinking of the on/off states as numbers gives us some ideas of what we expect to be able to do with those numbers. For example, how could I add two numbers together in this system?

Let’s use an example: 

| Decimal (0-9 | Binary (0,1) |
| --- | --- |
| 0 + 0 = 0 | 0 + 0 = 0 |
| 0 + 1 = 1 | 0 +   = 1 |
| 1 + 0 = 1 | 1 + 0 = 1 |
| 1 + 1 = 2 | 1 + 1  = 10 |

Alright, so the largest number we can have in binary is unsurprisingly 1.  The smallest number, that we can add that actually changes the number happens to be 1 too. This seems a bit annoying, but actually makes thing very easy. Let’s try to build a small calculator for a single digit. We know the largest number that we can get with two digits in binary is 2, that is 10 in binary. So we know we need two output slots, one for the left-hand number and one for the initial digit on the right-hand side.

Let’s think about how to calculate the right spot first using a familiar tool: the truth table.

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| Right-hand number output (SUM) | 1 (1+0) | 1 (0+1) | 0 (0+0) | 0 (1+1= 10) |
| Left-hand number output (CARRY) | 0 | 0 | 0 | 1 |

Do you see a familiar pattern? Which logic gate almost magically matches this truth table? The answer is that addition in binary for the right-hand number is the same as the OR-gate. Similarly, the output pattern we need for the left-hand digit is matches the AND-gate. We can rename those to match the naming standard we are used to from primary school studies: Sum and Carry. 

Let’s draw up this circuit and have a look at all possible states:

<p align="center"> {% asset_image image_20.png %}

The upper lightbulb represents the SUM output, the lower lightbulb the carry output. Seems to work well for a single digit. I think we are ready for the next step. How about we try to impress our coworkers and add digits larger than one and zero?

## Goal 8: Full adder

We would like to chain the above circuits together in such a way that we can compute the value of each digit in our number from the previous digits. Much like in addition on paper, we need to consider both numbers and also the carry from the digit at the position below.

We could try to write down the truth table for this but then we would need three inputs and two outputs. This would lead to 9 columns which I cannot be bothered to draw out. Instead, let’s see how far our reasoning can get us.

First, all values are zero nothing happens. Secondly, if any of the three input values is 1 but the others are 0 there won’t be any carry. So far, so boring.  Thirdly, if two of the three input values is 1, then we will definitely get a carry value because we know that 1+1 does not fit into a single digit (i.e. bit). In this case, those two will make the SUM value 0 + x, where x is the value of the last input.

To simplify the problem, we can just work on one part first: the SUM. 

### Calculating the SUM

We can start a bit silly and just chain two OR-gates. Afterall, this worked fine for two inputs and I said that the OR-gate is equivalent to Addition.

<p align="center"> {% asset_image image_21.png %}

Thankfully, its not so simple and a bit more fun is involved. The OR-gate also outputs 1 if both the inputs are on. But now, we only want it if one of them is on. Let’s think back to what we want: Either one or three of the inputs are 1. Let’s simplify the problem even further, let’s assume we know the carry is 0. Then we know the truth table we need:

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 0 | 0 |

Which we recognize as the XOR gate:

<p align="center"> {% asset_image image_22.png %}

Great, now we also need to test if either this case happens or (exclusively) the carry is 1. We can do this by chaining a second XOR gate behind the previous one.

<p align="center"> {% asset_image image_23.png %}

### Computing the CARRY

I am thinking about in which cases there will be a carry. If all values are 0 then, there obviously won’t be any carry. A carry can only appear when at least two of the bits we are adding are 1. This makes sense, because 1 is the largest number we can represent with one bit (in our coding scheme). So, for the carry, we will essentially have to answer the question: “Are there at least 2 inputs equal to 1?”. Or phrased differently: “Is there any pair of inputs on?”. 

Finding pairs is not so difficult, we already did this in the very first task using the AND-gate. Let us then make an AND-gate for all possible pairs and then check if any of those are on. This “Any” relationship we are looking for, we can represent with OR-gates. We don’t mind if there are multiple pairs that on, because this only indicates that 3 of the inputs are on and we want a carry in that scenario too.

<p align="center"> {% asset_image image_24.png %}

This looks fun and simple enough, but let us think about it a bit more. Could we maybe reuse some of the logic we used in the SUM part of the adder? We know that the XOR-gate is only active when there is exactly one of its input equal to 1. We can limit the problem space again, by assuming the one of the inputs is off. Then we could use the first XOR-gate to answer the question “Is there only one of the inputs equal to 1?”.  We can then check if the carry AND the XOR-output is off to check two pairs at once!

<p align="center"> {% asset_image image_25.png %}

If all three of the inputs are on, we the XOR-gate will output 0 and the AND gate above will not activate. We can fix this problem and test the last pair in one go, which we can do as I did in my initial idea. Then we test if either of those two pairs is active using and OR-gate as before. The OR-gate does not care how many inputs are active, so we can happily feed it two active pairs.

<p align="center"> {% asset_image image_26.png %}

Great, we can now add 3 bits together, which is perfect to compute the carry from the bit on the position right before this one. Let’s try to stack these so that we can add numbers with multiple digits together.

## Goal 9: 4-bit adder

This may look a bit messy, but is just the same as we did before. We can now add two numbers, buy adding them together position by position. For example here 1011 and 0001 which in decimal are $11+1=12$. The fun thing here is that we get two carries, one at the second position and another one at the third position. The second observation here, is that the first adder is getting a constant 0 input for the carry. This makes sense since there was no previous position. We could actually just replace it with a half adder, but I wanted to keep it consistent. Lastly, the last carry is going into nowhere. We will always have this problem if we restrict the number of digits. We know that for 4 bits like below, there are $2^4=16$ numbers we can represent, with 15 being the largest. If we get a result larger than this, the calculation is not correct. We get integer overflow.

<p align="center"> {% asset_image image_27.png %}

The 8-bit version of this module will be useful later: 

<p align="center"> {% asset_image image_28.png %}

Note that this “Ripple-Carry Adder” ([https://www.sciencedirect.com/topics/computer-science/ripple-carry-adder](https://www.sciencedirect.com/topics/computer-science/ripple-carry-adder)), clearly is not the most efficient. Computing the most significant bit (bit at largest position) needs all previous operations to be completed. The longer the integer we feed into the system, the longer the idle time of components (i.e., processing time grows linearly, $O(N)$). 

Also notice how I added the non-inverting version of the NOT-gate: The non-inverting buffer,

<p align="center"> {% asset_image image_29.png %}

which for our purposes will not do anything. It takes the input and simply forwards it.

## Goal 10: Negative numbers

### 10.1 Sign-magnitude representation

There are various ways of expressing negative numbers in binary. The simplest way I can think of is flipping a single bit (let’s take the most significant one) to indicate if a number is negative (1) or not (0 and positive numbers).  For example, with a 4-bit integer we could only use the 3 least significant bits to actually store any information.

$0001 → one$

$1001 → minus\ one$

This is called **sign-magnitude representation**. Can you guess what the problem is now? Which numbers can we represent?

This representation alone is a bit annoying to deal with because now we have two zeros:

$1000→zero$

$0000→zero$

Let’s now try to do addition:

$3 + (-3) = 0011 + 1011 = 1110 = -5$

That’s not very convenient at all if I want to do calculations. I am sure there is a way to resolve this issue, but maybe there is a better approach to this. Now, what do I have to do to make addition intuitive. That is, how can I represent it as a series of bitwise operations that are simple and fast?

### 10.2 One’s complement

Let’s think about how we are used to this in the decimal system. Subtraction is the same as addition but with the second number inverted (by multiplication by -1). For example:

$2-2 = 2 + (-2) = 2 + (-1 * 2) = 0$

Let’s try to define the inversion operation with the bitwise NOT-gate like we are used to. All 1s become 0 and all 0s become 1:

$two = 0010$

$minus\ two = 1101$

Adding both numbers together using the Adder we made before gives us:

$0010 + 1101 = 1\ 0000$

The leading 1 in the result is our carry, which we toss away in our 4-bit adder. The result having a non-zero carry on the most significant bit is called *overflow*. Using this logic, we notice that:

| Decimal | Binary | Inverted Binary |
| --- | --- | --- |
| 0 | 0000 | 1111  |
| 1 | 0001 | 1110 |
| 2 | 0010 | 1101 |
| 3 | 0011 | 1100 |
| 4 | 0100 | 1011 |
| 5 | 0101 | 1010 |
| 6 | 0110 | 1001 |
| 7 | 0111 | 1000 |

Now addition is simple between some numbers but does not really work out how we would want between all. For example:

$one + zero = 0001 + 1111 = 1\ 0000$, which after dropping the leading carry would just be zero. This obviously makes no sense. we could try fixing the situation by wrapping the last carry around the end to the least significant bit, resulting in $0001$. Still, we would be left with two zeros, a positive zero and a negative zero. This is confusing to say the least. 

### Two’s complement

We can combine both previous ideas into one. We start with One’s complement, but now instead of wrapping the carry of the largest number around, we just always add 1 after the inversion. 

| Decimal | Binary | Inverted Binary | Inverted + 1 |
| --- | --- | --- | --- |
| 0 | 0000 | 1111 | 0000 |
| 1 | 0001 | 1110 | 11111 (-1) |
| 2 | 0010 | 1101 | 1110 (-2) |
| 3 | 0011 | 1100 | 1101 (-3) |
| 4 | 0100 | 1011 | 1100 (-4) |
| 5 | 0101 | 1010 | 1011 (-5) |
| 6 | 0110 | 1001 | 1010 (-6) |
| 7 | 0111 | 1000 | 1001 (-7) |
| 8 |  |  | 1000 (-8) |

In this system, we notice two things. First, to get more negative numbers we need to count down from 1111. This leads to the largest negative number being 1000. Secondly, at the cost of having only one zero, we now have one more negative number than positive numbers (i.e., the 8). This system of describing negative numbers is called **two’s complement**. The circuit that implements this inverts all bits of the input individually using NOT-gates and then uses the adder circuit from before to add +1. This “negator” circuit for 8 bytes will be represented as such:

<p align="center"> {% asset_image image_30.png %}

## Goal 11: Tri-state buffer

We will need a new basic magic component for our later implementations. The tri-state buffer. This component sounds more fancy than what it is: A flood gate with a control input.

We already got to know the non-inverting and inverting (NOT-gate) buffers:

<p align="center"> {% asset_image image_31.png %}

The tri-state buffer works similar to the non-inverting buffer but has a second, control input. If the control input is not on, the gate is disconnected and does not send any 1 or 0 signal down the path. Instead, it sends a third (hence tri-state) type of state the Hi-Z state. This opens the output channel up for other gates to input without short-circuiting the system. We can imagine this as the wire being cut through. Here the associated truth table:

| Data Input | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Control Input | 0 | 0 | 1 | 1 |
| **Output** | Hi-Z | Hi-Z | 0 | 1 |

<p align="center"> {% asset_image image_32.png %}

We can obviously chain these tri-state buffers to use a single control bit signal to turn a series of inputs on and off. From now on, I will try to wrap components into more abstract representations that we can use in our computer later. Here the 8-bit tri-state buffer:

<p align="center"> {% asset_image image_33.png %}

I will be highlighting bytewise (e.g., 8-bits at once) with blue fields.

## Goal 12: Data selector (MUX)

We can use this new-found item to build an input selector. That is, a new component called a Multiplexer (i.e. MUX) that will be able to select between two inputs based on a third. We can use our new tri-state buffer for this.

We want one of the tri-state buffers to return Hi-Z while the other one is passing through the input as follows:

<p align="center"> {% asset_image image_34.png %}

Alternatively, we could also have used gates, which does use a bit more space:

<p align="center"> {% asset_image image_35.png %}

Note that we are able to chain these two-input multiplexers behind each other to act as a multi-input selector. For now, let’s create a abstract representation of this block for 8-bit data again:

<p align="center"> {% asset_image image_36.png %}

## Goal 13: Decoders

The MUX can encode which out of $n$ inputs should be selected. Let’s now think about doing the (almost) inverse. We will need to be able to map a state of one or more bits to a single output. For example, if I have 2 inputs, I can represent 4 states. To be able to make decisions based on a state that is made up out of multiple bits we will need to write a decoder.

Let’s start small: With one bit we can have two states. So we need two outputs. One will need to be one when all others (in this case only one other) is off. The NOT-Gate comes to mind:

<p align="center"> {% asset_image image_37.png %}

This is the simplest 1-bit decoder that I can think of. It demonstrates nicely what we want. One state of the input relates to one output outputting one and the rest zero. Now let’s make it a bit larger and do two bits. With two bits we can have 4 states. The truth table that we would like is the following:

| Decimal input state index | Input 1 | Input 2 | Output 1 | Output 2 | Output 3 | Output 4 |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | 0 | 0 | 0 | 0 | 0 | 1 |
| 2 | 0 | 1 | 0 | 0 | 1 | 0 |
| 3 | 1 | 0 | 0 | 1 | 0 | 0 |
| 4 | 1 | 1 | 1 | 0 | 0 | 0 |

From the above 1-bit decoder, I can see a combinatorial problem here. We will need a inverted and non-inverted wire for each input. This gives us 4 wires. We then need combine each pair of two in some way and pass that to the respective output. Here the idea I am having:

<p align="center"> {% asset_image image_38.png %}

But how to combine each pair of these? We want to only give an input if there is a unique state (e.g., 01) across all inputs. Let’s try to think about state 00 first and maybe we will get an idea. For this state, we need to have both inputs 1 or equivalently both inverted inputs off. Either of the two will do. We can test if both inputs are on using the AND-gate as we did before. Similarly with the 11 state but inverted.

<p align="center"> {% asset_image image_39.png %}

I hope it becomes clear now what I was talking about when I said that I see a combinatorial problem. For the last two inputs we just map the second two to their respective states.

<p align="center"> {% asset_image image_40.png %}

We will use represent this circuit in a simplified for for later:

<p align="center"> {% asset_image image_41.png %}

For a larger decoder, we can simply extend the design downwards. Here a 3-bit version:

You may be able to notice that some of the AND-gates can be used multiple times.

<p align="center"> {% asset_image image_42.png %}

For example, here the 001 state and the 101 state both share the left most state. You can see that we would have been able to save 1 AND-gate in the second row (where 001 is being decoded). We will need this decoder to make sense of multiple inputs and control what our computer will do. Again, we wrap this into a simplified representation for later:

<p align="center"> {% asset_image image_43.png %}

I was sneaky and added a “disable” input as well which is just another layer of AND-gates with the inverted “disable” input. When the input is turned on, the decoder will be disabled and all outputs will be 0. We will need this in our computer later.

## Goal 14: Saving 1 bit

By now we understand binary inputs as numbers, have a way of selecting inputs and do some arithmetic on these numbers. However, we have now way of storing our inputs and outputs yet. We will definitely need to be able to store intermediate results if we want to do more complex calculations. The alternative would be to always build a new circuit, but without a way to quickly assemble such a circuit on the fly, this does not seem feasible. Let’s start with a single bit.

So far, we have only looked at logic that did not depend on order of previous operations. It never mattered what configuration of inputs came before the next. If we want to save a bit, we will need to change this, which we can do by connecting the output of a gate back into it.

<p align="center"> {% asset_image image_44.png %}

This is nice, but we also need a way to reset this circuit back to the off state. Let’s try to add a second button and extend our design from above.

<p align="center"> {% asset_image image_45.png %}

This circuit has the same problem. There  is no way of turning the circuit off once it is in the on state. We need to invert the output of our OR-gates for this. As a reminder, here is the NOR-gate truth table:

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 0 | 0 | 1 | 0 |

I rebuild this circuit from above using NOR-gates. This works as we want. We can cycle through the sequential states of saving a state:

<p align="center"> {% asset_image image_46.png %}

This gives us the following truth table for the **SR-Latch**:

|  | 1. | 2. | 3. | 4. |
| --- | --- | --- | --- | --- |
| Reset | 0 | 0 | 1 | 1 |
| Data | 0 | 1 | 0 | 1 |
| Output | nothing changes | Out = 1 | Out = 0 | Invalid state |

It does not make much sense to set both inputs to 1, because then would be telling our circuit two opposing things.  This circuit is called the Set-Reset-Latch or simply SR-latch. Now let’s see if we can modify this input to be a bit more intuitive. I would like a single input and a “save” button. We could imagine that we have some state of a document for example and then we would like to save that state.

So we want two things: 

1. Single Save Button
2. Single Data input

If we look at the above truth table, we can reason about how we can make that happen. The “save” button should toggle between state 1 where nothing changes and states 2,3 where we can set the new value. We can start by implementing this “save” button using two AND-gates:

Gated S-R latch:

<p align="center"> {% asset_image image_47.png %}

Now we are able to enable and disable the latch by using a third switch. This is nice, part 1 is done. We only need to get rid of the “reset” input now. Looking at the above truth table (again i know), we notice that when the latch is on, we can deduce the state of the Reset button from the state of the data. It is always inverted. If we were to feed the inverted data input to the reset input, we could easily accomplish the same! This also avoids us tapping into the invalid state where both reset and data are 1. 

We arrive at the final result, the **D-latch:**

<p align="center"> {% asset_image image_48.png %}

This is great! We can save the data stream just like we wanted when we press save. We could now also add a load condition that outputs the output to something when a third input is true the same way. 

<p align="center"> {% asset_image image_49.png %}

<p align="center"> {% asset_image image_50.png %}

<p align="center"> {% asset_image image_51.png %}

<p align="center"> {% asset_image image_52.png %}

### 13.1: Saving more bits.

We can tile this just like we did with the 4-bit adder to save as many bits as we want:

<p align="center"> {% asset_image image_53.png %}

And load the stored data:

<p align="center"> {% asset_image image_54.png %}

Again, we can compartmentalize this logic in a block:

<p align="center"> {% asset_image image_55.png %}

I have added a field for the output that will get the output only when when load is on like above. However, maybe we want to have a second option and be able to just read the field at any time. For this, I have added a separate output that is only for reading the contents of the register. Again, blue circles refer to byte-wise input and outputs.

## Goal 15: Defining instructions

We would like our computer to be able to take in a list of instructions and give us some output. Let’s think about the instructions. If we want to pass in an instruction, we need to encode it in some input state. We know the circuits we build so far can only work with binary inputs, but generally are expandable as to how many input states there are inserted.  Let’s limit ourselves to 8-bit instructions so that the task remains contained.

To do something with an instruction, it needs to have some meaning. Let’s select the two most significant bits to determine that meaning and the rest be the data.

<p align="center"> {% asset_image image_56.png %}

If we think about what sort of things I would like to do with my computer, then I know I would like to be take two numbers and combine them in some way and save the result. Just like with a calculator. There are obviously a bunch of other things I would like my computer to do, but these are the simplest that I can think of given the logic that we have already implemented. We know that our computer will have to work with a set of binary inputs and we also know that these can be understood to be numbers. Now, the next logical step is to build from there and see that we are able to do operations on these numbers. 

Let’s define the instructions that we want and encode them into the two bits we selected:

| 00 |  |
| --- | --- |
| 01 | Do some calculation. |
| 10 | Copy a value. |
| 11 |  |

I obviously left out two states, but bare with me for now. We will find some more interesting actions that we would like to assign to those states. For now, we know that we will need some registers to save values, something that can do calculations and something that decodes what the instruction means. We can start with just saving and copying values between registers.

I have changed to a bit of a different representation to make it a bit less messy for us. Blue connections will be used to refer to BYTE transfer. A byte are 8 bits. We can imagine such a blue wire as just 8 different wires next to each other. Black wires are single bit wires ad green wires are single bit wires with the 1 state. For example, the 8-bit version of the tri-state buffer we discussed before will look like this:

<p align="center"> {% asset_image image_57.png %}

This will be our starting point. We expect that there will be some long string of 0s and 1s that encode the instruction. The instruction address takes a number as input that denotes the index of the byte that we have to read. The output just outputs the bytes. Secondly, we also have separate data input and output streams. These contain the numbers that we perform the operations on. We assume some hidden process here, that will provide us with the right numbers at the right time. It could for example be that, much like the program instruction input, the data input just has a long list of numbers that is defined before and is then read into the program. Not very dynamic but good enough for now.

<p align="center"> {% asset_image image_58.png %}

### Goal 15.1 Copying values

I will first decode the byte into its separate bits.

<p align="center"> {% asset_image image_59.png %}

We want to be able to copy between two registers and an input stream and output stream. For this, we obviously need to have some registers, so I will add four to our architecture. Note, that this can be as many as we want.

We will need to define a set of instructions for the copy operation between registers and input and output. Let’s use this convention: Out of the 6 left-most bits in the instruction, we use the three most significant ones to determine the location to copy from and the three least significant to determine the location to copy to. 

<p align="center"> {% asset_image image_60.png %}

| Decimal index |  | From | To |
| --- | --- | --- | --- |
| 0 | 000 | Register 0 | Register 0 |
| 1 | 001 | Register 1 | Register 1 |
| 2 | 010 | Register 2 | Register 2 |
| 3 | 011 | Register 3 | Register 3 |
| 4 | 100 | - | - |
| 5 | 110 | Data input | Data output |
| 6 | 111 | - | - |

For example, I would like to copy a value from the input to the output. I know I will need to say “copy” by setting the two most significant bits to the state “01”: 01 000 000. Next, I know that the “from” field should be 110 and the “to” field should be “000”, because these map to the input and register 0 respectively. The correct instruction string then is 01 110 000. 

In a second example, imagine we want to copy from register 2 to register 1. Again we know the prefix is “01” to indicate a copy instruction. Next, we need to look up the fields for the involved registers and come up with 01 010 001.

Let’s try to implement this logic. First, we need to decode all three sets of bits: the two bits indicating the the action to be taken, the “copy from” and the “copy to”.

<p align="center"> {% asset_image image_61.png %}

Let’s start with our second example. I would like to copy a value from register 2 to register 1: 01 010 001. For this, I will need to do three things:

1. Connect the output of register 2 to the input of register 1
2. Enable both decoders
3. Set the “load” and “read” fields of the respective registers.

<p align="center"> {% asset_image image_62.png %}

Doing this for registers as well as the input and output results completes the copy implementation. 

<p align="center"> {% asset_image image_63.png %}

Let’s move on to the second part of the logic we wanted to implement: Computation. 

## Goal 16: Arithmetic and Logic Engine (ALU)

It would be useful to integrate all of the operations that we have learned to implement so far into a single block. We could then pass the data as well as a selection input to the block and let it spit out the result. This block could be split up into two parts: One that does all the logic operations (or, nand, nor, and) and one that does all arithmetic (addition) operations. This time, let’s start with the abstract representation. There should be two inputs and one output. Additionally, there should be one input that decides the operation we would like to have:

<p align="center"> {% asset_image image_64.png %}

The “opcode” field decides which operation we would like to do. Let’s associate some numbers to the operations:

| Opcode | Binary Opcode | Operation |
| --- | --- | --- |
| 0 | 001 | OR |
| 1 | 010 | NAND |
| 2 | 011 | NOR |
| 3 | 100 | AND |
| 4 | 101 | ADD |
| 5 | 110 | SUBTRACT |

We should add this to our instruction as well. We can use the three least significant bits of our instruction to encode the type of computation when the most significant bit are set to the “computation mode” (01) as such:

$01 000 000 = OR$

$01000010 = NAND$

$01000011 = NOR$

$01 000 100 = AND$

$01 000 101 = ADD$

$01000110 = SUBTRACT$

For this exercise, I will be using the byte variants of the basic logic gates to make the illustration a bit clearer. These can simply be understood as doing the operation of the gate for each input bit. Following De Morgan’s laws from earlier, we know that the operations we want are all related and can be encoded in terms of one of the gates in the diagram combined with inversion of input or output.  We can use the multiplexer (MUX) from before to decide which combination should take place: Should the input be inverted? Should the output be inverted? We are left with the circuit for the “logic” part of the ALU.

<p align="center"> {% asset_image image_65.png %}

Now we need to implement addition and subtraction. We know that subtraction is just the same as addition of a number with a negative number. We can use the negator we discovered earlier invert the second number and pass that to our 8-bit adder.

<p align="center"> {% asset_image image_66.png %}

You may notice that I added an extra AND and OR gate to select the input of the MUX. Naturally, we could have used the decoder we built earlier instead of decoding the state with those two gates. 

Next, we can wire up the ALU to do computations between fixed registers. Here we stand before the decision as to which registers to do the computation with. We could add additional logic in our instruction code to determine the registers, but do not have enough bits. I chose to just fix the registers that we can do the computations with. This effectively forces the programmer to move the to-be-computed data into the correct registers before the computation. We could do better, but this does not limit the amount of possible computations in any way, but computation may take more operations. I determine that computations must happen with Input 1 coming from register 1, input 2 from register 2 and output is loaded into register 3. Lastly, let’s add a 8-bit tri-state buffer to enable and disable the module.

<p align="center"> {% asset_image image_67.png %}

Let’s add the circuit to our computer. For this, we need to make sure to enable when in use and also add an extra OR-gate for the load operation on Register 3, since now there are multiple ways of loading a value into this register. 

<p align="center"> {% asset_image image_68.png %}

## Goal 16: Program Counter

When we set out to build this computer, we decided that the input should come as one large string of bits, with us selecting 8 at the time and forwarding these to the splitter. However, we need to provide an index of which 8-bit block to select and forward. Currently, there is no input to the program block, so we will always be reading the first index. We should think about what we want. When I read a recipe, the instructions are provided in order: 1. Boil water 2. Clean potato. 3. Peel potato etc. The index increments by one with every completed step, just like a counter would. We need one!

For a counter, we will need to store data. Let’s start with a known building block from when we built our 1-bit register in chapter 14: the SR-latch. 

<p align="center"> {% asset_image image_69.png %}

Previously, we then extended to this intermediate representation with an “enable” input. 

<p align="center"> {% asset_image image_70.png %}

with the associated truth table:

| Enable | 1 | 1 | 1 | 1 | 0 |
| --- | --- | --- | --- | --- | --- |
| Reset | 0 | 0 | 1 | 1 | any |
| Data | 0 | 1 | 0 | 1 | any |
| Output | nothing changes | Out = 1 | Out = 0 | Invalid state | nothing changes |

We went on to replace the “reset” button with the inversion of the data input to form the D-latch. This time, we won’t do that and introduce something else instead. The problem with the S-R-Latch was that we could hit an invalid state when all three inputs are one. In this case, the we are telling the latch to both latch high (1) and latch low (reset, 0). This leads to race between both inputs to determine the output - not ideal to say the least. We can think about what this state should encode from looking at the above truth table. We have a way to do nothing, set output 1, set output 2, but no way to do the opposite of doing nothing: doing whatever action possible that would change the state of the system, a toggle between states. We can implement this by chaining another AND-gate behind the existing AND-gates and feed back the output of the opposing side. As it turns out, this preserves the logic of the SR-latch but adds the wanted behavior for the 11 state:

<p align="center"> {% asset_image image_71.png %}

Unfortunately, if we leave the enable input there out, the latch will jump back and forth between the two states. This is not good. We will need an element that gives us a strong but also very brief charge increase from state 0 to 1 back to 0. Turns out this is where the clock of the computer comes in. The clock will do something very simple, it will continuously flip the switch for us.

### 16.1 Clock

Over time, the clock we just thought of will be flipping between the two states 0 and 1. 

<p align="center"> {% asset_image image_72.png %}

I would like to add a bit more nuance here. Technically, the states 0 and 1 do not exist in the way I drew them out but represent a difference in voltage. The clock continuously flips between high and low voltage states, creating the pattern we observe above. The associated symbol is:

<p align="center"> {% asset_image image_73.png %}

You may now wonder how this is helpful at all to us, since the phase for each state is still long. For this, we will adding a circuit behind the clock that looks like this:

<p align="center"> {% asset_image image_74.png %}

We know that each component is built up of transistors. These can only *almost* instantaneously pass on the signal, there is a small delay. In this case takes the signal longer to pass through the NOT-gate than through the unobstructed wire. When the clock switches from low to high, for a very brief moment, both inputs to the AND-gate are high and the AND-gate forwards this. We have built a method to detect low-to-high cycle changes, a **rising edge detector**. We will use the combination of clock and rising edge detector to pass the signal through our computer. The output of this combination gives us the following waveform.

<p align="center"> {% asset_image image_75.png %}

A short note on clock speed. Before this chapter, we have always assumed that the signal passes instantly. However, as we know now, each component has a cost of time associated with them. The computer that we are building has components that are very complex and need the signal to pass through others first. Take the Ripple-carry-adder for example. There, we can only start adding the next larger bit when the previous position is finished. In practice, this means that we would need to have a slower clock speed for our computer to ensure that all computation paths can be passed in a single cycle. This is particularly bad if the operation we want does not take very long at all, but since the clock is stepping ahead in a constant speed, we have to wait. Which raises an interesting challenge where we try to find ways to avoid waiting for previous components and move onto the next computation sooner, being able to increase the clock speed of the computer and its computation speed. I also find it interesting to think about the alternative, where we may not try to do a full computation in one cycle. Instead, we could try to break it up into smaller operations such that a single operation may take multiple cycles. This would have no impact on larger operations in terms of time, but since we know that the longest an operation could possibly need in the computer is much shorter, we are able to increase the clock speed. Lastly, if the computer has some means of predicting how long an operation may take, it would be able to adjust the clock speed dynamically, while still guaranteeing correctness of output. In our computer, we will put all of that aside and just use a slow enough clock speed.

### 16.2 J-K-flip flop & Ripple counter

We can now complete our circuit called the J-K-flip flop from before:

<p align="center"> {% asset_image image_76.png %}

Which has the associated truth table:

| Clock/ enable | 1 | 1 | 1 | 1 | 0 |
| --- | --- | --- | --- | --- | --- |
| Reset | 0 | 0 | 1 | 1 | any |
| Data | 0 | 1 | 0 | 1 | any |
| Output | nothing changes | Out = 1 | Out = 0 | toggle | nothing changes |

We can wrap this circuit into modules again as such,

<p align="center"> {% asset_image image_77.png %}

and combine into a counter. In this counter, we use the inverted output of the JK-flip flop as the clock signal for the next flip flop. Going from left to right, each clock signal will toggle the first JK-flip flop between outputs 0 and 1. The inverted output will obviously be the other binary digit. This makes it so that the next JK-flip flop will flip only when the inverted input is 1. This happens every other pulse. A falling edge/ transition from 1 to 0 will not trigger a toggle of the next flip flop. The third flip flop will be dependent on the one before etc. This leads the nth JK-flip flop to be toggled after $1/2^{(n-1)}$ flips of the first flip flop. Effectively counting up. Also note how the output of this counter has the most significant bit on the farthest to the right position. 

<p align="center"> {% asset_image image_78.png %}

Similar to our ripple-carry adder design, the computation speed this ripple counter increases linearly with the number of digits in the counter. There are fun ways to improve this, but let’s not get too sidetracked. Instead, we should think about what we do if we want to do more than just move to the next instruction.

### 16.3 Condition instruction

If we want to repeat the same operation multiple times in our current design, we would need to provide it multiple times to the instruction set. This is not only very dumb, bloats the program but also restricts some of the operations that we can do. Branching is completely impossible. That is, if we want different instructions to be executed based on the result of previous computation or we cannot do this. We should, therefore, add a “condition” instruction to our instruction set:

| 00 |  |
| --- | --- |
| 01 | Do some calculation. |
| 10 | Copy a value. |
| 11 | Condition |

We know two things will be needed to implement this: First, a block that decides on the new position to be passed with associated instructions. Secondly, we need to be able to override the counter with the new value. After that, if should continue counting from that new value onwards. We need a “set value” button.

Seeing we are currently working on the program counter anyways, let’s avoid shifting focus and start with the second problem. For this we can try to add a second control path to our counter. 
For example, to set a flip-flop to 1, feed `J = 1` and `K = 0` when Load is active. Similarly, to set it to 0, feed `J = 0` and `K = 1`.  Since we will be sharing the inputs, we need to make sure to not short circuit the whole thing. I have created a two bit version of the design we would need below.

<p align="center"> {% asset_image image_79.png %}

But since I am the one writing this text, I can do whatever I want - and I want something a bit simpler. Let’s take step back and evaluate what we need. 

1. Increment with every clock cycle
2. Storing input bits.
3. Returning input bits.

Now, painfully obvious, we could have accommodated the second two requirements with our 8-bit register from earlier.  Incrementing is just adding by 1 and we have also designed an adder before. Can introduce the clock by just using the gated S-R latch from 13.1 and replacing the enable input with the clock.

Counter V2:

<p align="center"> {% asset_image image_80.png %}

Much simpler to read for me. Adding the enable logic is almost trivial now compared to designing an entirely new circuit, because there is only a single input loop that we need to protect with tri-state buffers. 

<p align="center"> {% asset_image image_81.png %}

I am very happy about this! Let’s make it a module and wire it up to the rest of the computer:

<p align="center"> {% asset_image image_82.png %}

Similar to when we implemented calculations with the ALU, I made the decision that the input override value can only come from a specific register. This time, I choose Register 0. Notably, we are still missing the block that makes the override dependent on the data. In the current setup, the condition instruction would always override the counter value with the value in register 0. Let’s have a look at that next.

<p align="center"> {% asset_image image_83.png %}

## Goal 17: Condition Engine

When the instruction code is 11, we decided that conditional branching should happen. This means, we need to compare two values. For simplicity, lets compare the three least significant bits from register 3 against zero. The type of comparison done by the condition engine will be determined by the three least significant bits in the instruction. The output of the engine will be 1 if the condition is met and 0 otherwise.

| Opcode | Mode |
| --- | --- |
| 000 | Output is 0 |
| 001 | Input = 0 |
| 010 | Input < 0 |
| 011 | Input ≤ 0 |
| 100 | Output is 1 |
| 101 | Input  **≠ 0** |
| 110 | Input ≥ 0 |
| 111 | Input > 0 |

Modes 100 and 000 do not do any comparison but allow us to just directly output a value we want. Let’s start with the simple parts, testing if a number is negative and if a number is 0. We can use our knowledge of two’s complement for this. If we add a number to itself, we know that that we can only have a carry if the number was negative. For any number larger or equal to zero, we will be getting an even number, which will not result in a carry. Even when we try to create overflow, we can only get even numbers out. The largest number we can get with overflow is -2. This is because, if you remember, we added +1 after the bitwise bit-flipping of a positive number to get a negative number. In the below illustration, this is encoded by the bottom adder.

Secondly,  the adder that has the output of the bitwise NOT-gate as input tests if the number is equal to zero. It only does this if the Opcode is 1, otherwise the output of the carry will always be zero. We know that the only number that can result in zero if a carry is added (via the opcode) is -1. Again, applying our knowledge of two’s complement, the output of this adder only has a carry if there the input was 0. 

### First Adder

Case 1: When OFF

- Output is always zero

Case 2: When ON

- If value equals zero → returns 1

### Second Adder

- For positive values → no carry → outputs 0
- For zero → no carry → outputs 0
- For negative values → carry → outputs 1

Now the OR- and XOR-gate in the circuit exploit symmetries in the opcode that allow us to cover the rest of the cases. It’s a bit easier to show than to explain. Let’s go through the cases together:

To test if the value is smaller or equal zero , we only need to check if the value is smaller or equal to zero. The OR-gate handles this naturally.

To test if the value is unequal to zero, we check if the value is equal to zero and the most significant bit in the 3-bit opcode is on. If it is on, we know that we cannot be in any of the equal, smaller or smaller and equal situations. If the value is equal to zero, then the XOR-gate will return zero. If the value is negative, the bottom adder may return one but this signal is blocked by the AND-gate.

To test if a value is larger or equal to zero, we check if that the value is not negative first. This test is executed by the adder, AND and XOR-gate. We are basically going of the assumption that the value is larger or equal zero, then test if it is negative with the bottom adder. The upper adder is effectively turned off without a carry input.

To test if a value is strictly larger zero, we turn on all the tests to evaluate ≤ 0 on as before. If none of them pass, the XOR-gate does not get a second one as input and outputs one. 

Finally, I would like to note that that the second half of the circuit could be replaced with a full adder and only taking the sum output. My initial design did not include adders at all, but I will save you from it this time.

<p align="center"> {% asset_image image_84.png %}

Plus a compact version again for our computer 

<p align="center"> {% asset_image image_85.png %}

### 17.1 Integrating the condition engine

Let’s add the condition engine to our computer to allow for conditional code execution! As we previously discussed, we take the instruction as a condition, the value from register 3. If we are then in condition mode AND the condition is satisfied, we forward the value to the program counter override.

<p align="center"> {% asset_image image_86.png %}

## Goal 18: RAM

We still have a possible instruction left and I have two ideas.

 Idea nr. 1 is that we could introduce a read operation from a specific memory location in RAM. That is, we could just tell the computer that its reading time, we need to read from a specific address in RAM. RAM would then just be a large block of memory with an index that we can provide to get a specific address. We could then also provide where to load this into. 

<p align="center"> {% asset_image image_87.png %}

Which we could hook up like this, not forgetting to turn on the decoder for reading into the correct register:

<p align="center"> {% asset_image image_88.png %}

With possible opcodes structured like this:

| 00 | Load from RAM |
| --- | --- |
| 01 | Do some calculation. |
| 10 | Copy a value. |
| 11 | Condition |

Just as with the copy instruction, we can use the existing logic for the register “save to?” selection, leaving us the three least significant bits to read the index in the RAM. Now, 2^3=8 addresses is really not much, but enough to give us an idea of what could be possible.

Annoyingly, we do not have enough bits to store a write to ram operation. But we can still reason what this would entail. We would need to turn the output of the register to read from on and then read from the common wire (i.e., the Bus). We then would need to enable write on the RAM and provide an index/ address to write to.

## Goal 19: Immediate values

My second idea was that we use so called immediate values with the opcode 00.

| 00 | Immediate |
| --- | --- |
| 01 | Do some calculation. |
| 10 | Copy a value. |
| 11 | Condition |

Since the opcode happens to be 00, the byte is preserved in the which number it represents in the 6 least significant bits. We could just load this directly into a register - effectively saving us a few copy operations from the data input into the register we want. 

For this, we need to pass the byte value directly to the bus and add an OR-gate to the load operation of a fixed register (e.g., Register 0).

<p align="center"> {% asset_image image_89.png %}

## Goal 20: CPU

We have finished the computer! We can now compute whatever we want, copy values, understand negative numbers, add them, subtract them, conditionally execute code based on data and pass values directly from the program into the register. To those missing multiplication and division in the circuit, don’t worry. We can represent these in our instruction as a series of repeated addition or subtraction. But you do have a point. We have not implemented everything you may expect. Modern CPUs have multiple registers, caches of decreasing size to operate faster on data that is likely needed, are able to predict branching and add additional, optimized circuits for common operations like multiplication, division, fused-multiply-add etc. There is much more to design and implement here. Depending on the use case of our computer, different components may be relevant. 

## Sources

[https://www.youtube.com/watch?v=wRIys1pzCMA](https://www.youtube.com/watch?v=wRIys1pzCMA)

[https://www.youtube.com/watch?v=PVNAPWUxZ0g](https://www.youtube.com/watch?v=PVNAPWUxZ0g)

---

 Alternatively, we could try to split the space in the middle by assigning all numbers on the upper half of the $2^n$ numbers to positive numbers and the lower half to negative numbers. For example like:

$0000→negative\ eight$

$0001→negative\ seven$

…

$0111 → negative\ one$

$0001 → zero$

$0010 → positive\  one$

…

$1111 → positive\ seven$

I also added a zero to our method, but now we are missing one of the positive numbers! Seems like there is no way of generating an even about of positives and negatives if we want a zero as well. But this system, you might agree, is a bit confusing. Why can’t zero just map to $0000$ only. What do we have to do to make that happen?

Let’s go back and think about what we want. 

1. $0000→zero$
2. Arithmetic should be simple.

The answer is **two’s complement.** We adapt our second approach but this time let’s combine it with our first. We still use the most significant bit as indicator of (1) negative and (0) non-negative. This makes sure that $0000$ maps to zero in decimal. Now, the only problem we are left with is the second zero $1000$. What value do we have to assign for this to make sense?

We would also li

- still would like to have a continuous number space where nearby binary numbers excluding the sign bit are also near in
- math’s now very simple

## 

## 

## Counter

Legal RISC-V instructions

[https://learning.edx.org/course/course-v1:LinuxFoundationX+LFD111x+1T2024/block-v1:LinuxFoundationX+LFD111x+1T2024+type@sequential+block@7b88b9ba824c4b97a201330c55074857/block-v1:LinuxFoundationX+LFD111x+1T2024+type@vertical+block@5443695770284485b9fccb813406d134](https://learning.edx.org/course/course-v1:LinuxFoundationX+LFD111x+1T2024/block-v1:LinuxFoundationX+LFD111x+1T2024+type@sequential+block@7b88b9ba824c4b97a201330c55074857/block-v1:LinuxFoundationX+LFD111x+1T2024+type@vertical+block@5443695770284485b9fccb813406d134)

l all instructions are 32 bits

RISC-V diagram

https://learning.edx.org/course/course-v1:LinuxFoundationX+LFD111x+1T2024/block-v1:LinuxFoundationX+LFD111x+1T2024+type@sequential+block@6ad4eaf3dacc4d6b91dbbf22d3525800/block-v1:LinuxFoundationX+LFD111x+1T2024+type@vertical+block@753da4bde1264bd39b9c543c20817723

- 
- logic is fun and all but what if we want to do some maths?
    - wait it’s the same in binary?
    - let’s just implement something for additon
        - half adder
        - full adder
        - 8 bit adder
    - ALU

Notice, how we are avoiding something I personally always found very annoying: In the decimal system, carry can be larger than 1, when the teacher decided it was time to confuse us. Here, we do not have that problem, we can either have a carry of zero, which does nothing; or we can have a carry of 1 which can only have two effects: Either the next digit will be 1 or 0. Easy. We can still have the “avalanche-like” effect of how two ca

- storage
    - delay line
    - 1 bit storage
    - 8 bit storage
    - etc
        - why memory gone if turn electricity off
- add some
- Why? I need to be able to add numebrs and stuff to make decisions. I would like for my computer to count things and we will see how else we can use this logic for more general use cases.
- add some sources

| Input 1 | 1 | 0 | 0 | 1 |
| --- | --- | --- | --- | --- |
| Input 2 | 0 | 1 | 0 | 1 |
| **Output** | 1 | 1 | 0 | 0 |

<p align="center"> {% asset_image image_90.png %}

<p align="center"> {% asset_image image_91.png %}

<p align="center"> {% asset_image image_92.png %}

[https://www.notion.so](https://www.notion.so)

[https://www.notion.so](https://www.notion.so)

<p align="center"> {% asset_image image_93.png %}

<p align="center"> {% asset_image image_94.png %}

<p align="center"> {% asset_image image_95.png %}

<p align="center"> {% asset_image image_96.png %}

<p align="center"> {% asset_image image_97.png %}

<p align="center"> {% asset_image image_98.png %}

| Reset | 0 | 0 | 1 | 1 |
| --- | --- | --- | --- | --- |
| Data | 0 | 1 | 0 | 1 |
| Output | nothing changes | Out = 1 | Out = 0 | Invalid state |

<p align="center"> {% asset_image image_99.png %} -->
