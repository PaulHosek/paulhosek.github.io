---
title: Linkage and storage duration
date: 2025-07-04 14:31:22
tags: [Technical, Blog, C++]
categories: [C++]
mathjax: true
---


When I first learned French in school, we were first introduced to the regular verbs. I was thinking: “Alright, this is pretty easy and makes sense. I just need to apply the rules and should be fine.” A month and a lot of irregular verbs later I was not fine, but very frustrated: Why were there so many exceptions to these rules? Why were there so many exceptions on the verbs I actually needed?

C++ can feel strangely reminiscent of that time when it comes to keywords affecting linkage and storage duration. I am specifically talking about:
|   |   |   |
|---|---|---|
| static | extern | consteval |
| thread_local | volatile | constexpr |
| inline | const | constinit |

We could interrogate these from various viewpoints, but here I will only look at how they modify to entity storage duration and linkage. A small disclaimer that this is a guideline based on my current state of knowledge. For specifics and edge-cases, please read the standard and run your own experiments on the compiler of your choice. In an attempt to keep this blog post shorter than the one on building a computer, I will glance over some details here and there (e.g., copy elision, move semantics and similar compiler optimizations) as well.  If you find any mistakes, inaccuracies or have other comments, shoot me a message! Lastly, all things discussed here are using c++23 but mostly apply to earlier revisions too (but pay additional attention concerning pre C++17 inline and constexpr, constinit and consteval). 

Now, because these keywords each depend on the context on how they are used I will structure the post bottom-up. We think about the possible effects there are and try to associate keywords and context to each effect. sMore concretely I structured this post as follows. First, some high-level background about how a C++ program is build. We then cover storage duration and subsequently linkage for variables before moving onto linkage of functions. I also interjected a “how to declare section” in the middle, which clears up some confusion that I had with the topic initially.

## 1. C++ build recap

To make sure we are starting of with the same high-level understanding of how the build process works, here a little refresher.

First, source files are passed through a text processor that copies and pasts the included file wherever the “#include” block was. For example, if I was to include #include <iostream> in an otherwise empty file, the preprocessor would make it around 20.000 lines long. These are then compiled into independent object files. In the last step, the entities that are being referred from a different translation unit must be linked to create a well-formed program.

<p align="center"> {% asset_image image1_cppbuild.png %}

## 2. Storage duration

Storage duration says something about the lifetime of an object. It does, however, not say when an object will be constructed or destructed exactly, but gives a limit as to when an object may be available. There are four general categories of storage duration:

|  | automatic | static | thread | allocated |
| --- | --- | --- | --- | --- |
| **Lifetime** | local scope | program execution | thread execution | dynamically allocated |

The most obvious example on storage duration I can think of is if we want to count how often a function was called:

```cpp
#include <iostream>
void count_calls() {
    int counter = 0;
    counter++;
    std::cout << counter << std::endl;
}

int main() {
    count_calls();
    count_calls();
    return 0;
}
```

Naturally, this does not work. Our “counter” variable has automatic storage duration and does not exist beyond the scope of the “count_calls()” function. We can change that by extending its storage duration to the whole program using the static keyword:

```cpp
#include <iostream>
void count_calls_static() {
    static int counter = 0;
    counter++;
    std::cout << counter << std::endl;
}
```

However, this is not the only way that we can create a variable with static storage duration. Global variables work too:

```cpp
#include <iostream>
int counter = 0; 
void count_calls_static2() {
    counter++;
    std::cout << counter << std::endl;
}
```

Associated with the storage duration are four keywords.

| static | thread_local | extern | mutable |
| --- | --- | --- | --- |

Thankfully, these follow pretty simple rules. If we have a block of code with multiple specifiers, we can simply apply the table below and stop at the first match.

| keyword / scope | block/local scope | global or namespace scope |
| --- | --- | --- |
| thread_local | thread | thread |
| static | static | static |
| extern | static (refers to global) | static (refers to global) |
| (no keyword) or mutable | automatic | static |

Try it out yourself:

```cpp
extern int x;
int y;
static int z;
thread_local static int x;
struct C {
    mutable const int* p;
    int* p2;
};

static mutable extern thread_local int x;
```

And the solution:

```cpp

extern int x; // static 
int y; // static 
static int z; // static 
thread_local static int x; // thread 
extern thread_local int i; // thread
struct C {
    mutable const int* p; // automatic 
    int* p2; // automatic 
    static const int* p3; // static 
};

static mutable extern thread_local int j; // wrong syntax but would be thread
```

So far so good. But what happens if we  apply the static keyword to functions, which do not have storage duration by definition. It turns out that some specifiers can not only affect storage duration but also linkage.

## 2. Linkage concept

As the name suggests, linkage changes something in the linking step of the build process. It describes where an entity (say a data member or function) is exposed to and can be accessed from. An entity can have no, internal, external, external weak linkage¹. 

|  | None | Internal | External | Weak external  |
| --- | --- | --- | --- | --- |
| Available to | local scope | translation unit | all translation units | all translation units |

Specifiers that may affect the type of linkage are not self-explanatory:

*static, extern, inline, constexpr, consteval, const, namespace*

Their effect on linkage may depend on the storage duration of the object (obviously not for functions). Specifically, static and thread storage duration lead to the same linkage rules while automatic storage duration leads to different linkage rules. Note that dynamically allocated memory using new/delete cannot be reasoned about in terms of linkage, because we only ever interact with heap memory using pointers (who’s linkage we can modify using the keywords).

¹ I am explicitly leaving out module linkage because I have not been exposed to modules enough to talk about them.

### 2.1 Automatic storage duration

Entities with automatic storage duration never have linkage. For example, the code below will not build because the variable *counter* is not exposed to anywhere outside of its local scope, it has no linkage. We can prepend *static* and *thread_local* specifiers as much as we want and change the storage duration but linkage remains unaffected.

```cpp
// counter.cpp
void init_counter() {
    thread_local int counter = 0;
}

// main.cpp
#include <iostream>

int main() {
    // does not compile!
    std::cout << counter << std::endl;
    return 0;
}
```

### 2.2 Static or thread storage duration

Global variables have external linkage. This means we can access them from another translation unit. However, we need to tell compiler that the symbol is not missing but can be found in another file. For that, we must declare it in the current scope and indicate that its definition can be found elsewhere using the *extern() keyword:

```cpp
// my_counter.cpp
int counter = 0;
```

```cpp
// main.cpp
#include <iostream>

extern int counter;

int main() {
    std::cout << counter << std::endl;
    return 0;
}
```

Linkage interacts with the One-definition-rule (ODR), where each entity must have exactly one definition in the entire program, though it can have multiple declarations. Naturally, if an entity is not available to a scope it does not violate the ODR. For entities with external linkage, the ODR ensures that only one definition exists across all translation units, and multiple declarations (e.g., via extern) must refer to that single definition. It follows, that entities with internal linkage may be defined multiple times across the program but not within the same translation unit. The linker treats each definition unique to its file. Entities with no linkage, like those with automatic storage duration, are exempt from ODR because their scope is confined and they don’t participate in linking across units.

```cpp
// counter_variable.cpp
int counter = 10;

// foo.cpp
#include "counter_variable.cpp"
void increment_via_foo(){
    counter++;
}

// bar.cpp
#include "counter_variable.cpp"
void increment_via_bar(){
    counter++;
}

// main.cpp
#include <iostream>
#include "counter_variable.cpp"
void increment_via_foo();
void increment_via_bar();

int main() {
    std::cout << counter << std::endl;
     increment_via_foo();
    std::cout << counter << std::endl;
     increment_via_bar();
    std::cout << counter << std::endl;

    return 0;
}
```

This is a violation of the ODR, since the global variable *counter* is redefined in multiple translation units and has external linkage. As expected, we get “Linker error: One or more multiply defined symbols found” and “Linker error: Symbol already defined in object” (in MSVC) for the counter variable. From our exploration of the C++ compilation earlier, we know the #include statements essentially just copy the text in the preprocessing stage. The linker does not know if a variable was copied in via an include or explicitly defined multiple times. We can resolve this by marking the variable *static*, giving it internal linkage:

```cpp
// counter_variable.cpp
static int counter = 10;
// ...
// returns 10 10 10
```

Each file (foo.cpp, bar.cpp, main.cpp) now has its own instance of the counter variable. This can be useful if we want to share functionality but not data. Notice how the statement,

```cpp
*thread_local static int counter{10};*
```

now makes more sense. This is a variable with thread_local storage duration and internal linkage (due to *static*). We will get to the precedence of multiple specifiers later. In our example, however, we probably intended to increment the same counter from different translation units. There are two ways to achieve this: First, we can have a single definition to avoid violation of the ODR together with multiple declarations with external linkage. 

```cpp
// counter_variable.cpp
int counter = 10;

// foo.cpp
~~#include "counter_variable.cpp"~~
extern int counter;
// ...

// bar.cpp
~~#include "counter_variable.cpp"~~
extern int counter;
// ...

// main.cpp
~~#include "counter_variable.cpp"~~
extern int counter;

// ...
// returns 10 11 12
```

Here, the *extern* keyword tells the linker that the definition can be found in a different translation unit with external linkage. If I print the address of counter in bar.cpp and foo.cpp both are the same:

```haskell
bar: 00007FF73193D000
foo: 00007FF73193D000
```

In C++ 17 the *inline* keyword was added which can simplify the code above quite a bit. The *Inline* specifier (in isolation) results in external weak linkage of an entity. External weak linkage works much like external linkage but allows violation of the ODR with the assumption that all provided definitions are the same. The linker will then select one definition to use (e.g., the first one it encounters) and ignore all others. This is great if we are working on a header-only library. A good way to remember this fact is by thinking of what *inline* also does: Hinting towards potentially inlining a the code of a function instead of creating a separate function call. If we assume the compiler always inlines everything that we mark with inline, the selected code becomes local to the scope it is used in. In that case, multiple definitions would not be a problem since the inlined variables would have automatic storage duration. In reality, how much really is inlined depends on the compiler. A quick experiment shows that MSVC barely inlines, Clang inlines a few instances and gcc is the most aggressive about inlining of the three.

```cpp
// counter_variable.cpp
inline int counter = 10;

// the rest remains as in our first example:

// foo.cpp
#include "counter_variable.cpp"
void increment_via_foo(){
    counter++;
}

// bar.cpp
#include "counter_variable.cpp"
void increment_via_bar(){
    counter++;
}

// main.cpp
#include <iostream>
#include "counter_variable.cpp"
void increment_via_foo();
void increment_via_bar();

int main() {
    std::cout << counter << std::endl;
     increment_via_foo();
    std::cout << counter << std::endl;
     increment_via_bar();
    std::cout << counter << std::endl;
// ...
// returns 10 11 12
    return 0;
}
```

Again the addresses of the counter variable match:

```haskell
bar: 00007FF787BAD000
foo: 00007FF787BAD000
```

Variables marked a single const-keyword have internal [linkage](https://timsong-cpp.github.io/cppwp/std23/basic.link#3) (just like *static*). Which only applies if the variable is not a template, not marked volatile, extern, inline or previously declared with different linkage. The code below finds different addresses (although they probably share the same initializer from .rodata which then be copied onto the stack). 

```cpp
// counter_variable.cpp
const int counter = 10;

// foo.cpp
#include "counter_variable.cpp"
void print_address_bar() {
    std::cout << "bar: " << &counter << std::endl;
}

// bar.cpp
#include "counter_variable.cpp"
void print_address_foo() {
    std::cout << "foo: " << &counter << std::endl;
}

// main.cpp
#include <iostream>
#include "counter_variable.cpp"
void print_address_foo();
void print_address_bar();
int main() {
    print_address_bar(); // bar: 00007FF73790AC14
    print_address_foo(); // foo: 00007FF73790AC10

    return 0;
}
```

Similarly, constexpr implies const and constinit for variables. Constinit says something about the compile time behavior of the program only, so the relevant part of constexpr is simply const. The only exception that I could find are static member variables and functions, for which the keyword implies inline. This makes intuitive sense, because static members, both variables and functions, are typically defined in a header file so they can be accessed from multiple translation units. 

Finally, there is a trump card. We can force internal linkage of any variable or function using an unnamed namespace. Any and all specifiers we have mark our functions or variables in an unnamed namespace will have no effect. This is great to use for local objects that we don’t want to accidentally leak outside a translation unit.

## Intermezzo: How to declare?

In the example introducing the *extern* keyword, you may have been surprised that the *extern* keyword was needed for the global variable but not for the free/ global functions. I.e., Why does *int counter;* not work? 

```cpp
// counter_variable.cpp
counter int = 10;

//bar.cpp
extern int counter; // <-- why needed here?
void increment_via_bar(){
    counter++;
}

//main.cpp
void increment_via_bar(); // <-- but not here?
```

Let’s recall the declaration and definition rules.

### I.1 Variables

**Local variables** cannot be declared without defining them. Depending on your compiler warning level, the following may not compile. Even if it does, the compiler will need to allocate memory when pushing the variable onto the stack, making this a definition. If we do not initialize, its value is indeterminate for fundamental types. The only exception that I can think of if is when the variable is unused, in which case it is probably optimized out anyways. I was able to trick the compiler using a reference decayed to a raw pointer into running this code to illustrate:

```cpp
#include <iostream>
void foo(int* k) {
    k++;
}
int main() {
    int k;
    foo(&k);
    std::cout << k << std::endl; //UB, I am getting -858993459
    return 0;
}

```

**Member variables** can be declared if they are static non-const data members. Other variable types with either be zero-initialized or need explicit declaration:

```cpp
#include <iostream>
struct C {
    static int k;
};

int main() {
    int x = C().k;
    // Error	LNK2001	unresolved external symbol "public: static int C::k" (?k@C@@2HA
    std::cout << x << std::endl; /
    return 0;
}
```

For which the documentation says: “There are many ways to get LNK2001 errors. All of them involve a *reference* to a function or variable that the linker can't *resolve*, or find a definition for. The compiler can identify when your code doesn't *declare* a symbol, but not when it doesn't *define* one.” This matches our understanding.

**Global variables** can only be declared without definition by using the keyword *extern* as we established earlier.

### I.2 Functions

**Global functions** and **Member functions** can be declared as I did above.

```cpp
void foo(int arg1, ...);

struct C{
    void bar(int x);
}
```

**Local functions** only exist in the form of lambdas and other function objects (i.e. functors) which cannot be declared. Functors behave like any other local object with regards to their lifetime.

```cpp
#include <iostream>

int main() {
    {
        auto mylamb = []() {return 10; };
    }
    int x = mylamb(); // mylamb is undefined
    std::cout << x << std::endl;
    return 0;
}

```

## 3. Functions

So what is different for functions? Since there is no such thing as storage duration for functions, the whole problem becomes a bit simpler. 

We already discussed that global and member functions have global linkage by default (just like global variables). Here, global variables needed the extern keyword to be declared (and not defined), functions do not. We also already know that constexpr implies inline for functions. We discussed that this would be useful to avoid ODR violations, since the function will likely be placed in the header file. Note that if multiple, but different definitions of the same inline function exist (e.g., one marked consteval) the program is ill-formed.  In the current revision, const only has meaning on member functions, thus is redundant or may even lead to a compiler error if used on global scope. It generally has no effect on linkage of functions.

```cpp
// foo.h
inline const constexpr int foo(int x){ // inline and const are redundant here
    return x;
} 

// main.cpp
#include "foo.h"
int main(){
    std::cout << foo(2) << std::endl; // return 2
}
```

Just as with variables, anonymous namespaces are again are the trump card to beat all other specifiers (forcing internal linkage).

Finally, what about consteval and constinit? We already established that constinit can be thought of as the part of constexpr at compile time. This is not entirely true but a useful to relate the two keywords. Constinit has no effect on linkage. Consteval on the other hand should ideally be an “immediate function”, meaning that it has to be evaluated at compile time and consequently is not included in the object files. The standard does not differentiate between compile-, link- and runtime, so this is not guaranteed behavior. I have observed that in MSVC the function could be referred from other translation units, but would not rely on it.

## 4. Multiple keywords

Below I made an attempt of encoding all the rules outlined above into one big decision tree. Start from the top row and stop until you meet a keyword used. This one determines the linkage.

| keyword/ linkage | No linkage | Internal linkage | External linkage | Weak external linkage |
| --- | --- | --- | --- | --- |
| unnamed namespace or namespace access |  | any |  |  |
| extern |  |  | global function or global variable |  |
| static |  | global function or global variable |  |  |
| inline, constexpr function |  |  |  | any, except local variables and with ODR for inline functions |
| const, constexpr variables |  | global variables if non-volatile, non-template, non-extern |  |  |
| (none) | local variables |  | any, except local variables |  |

Here a ridicules and example with static thread storage duration (*thread_local*) and internal linkage (*unnamed namespace*):

```cpp
namespace {
    static thread_local inline constexpr int x{};
}
```

Unnamed namespace is the first one so we know the linkage will be internal. Without it, the linkage would be the linkage specified by extern which is also internal. Without *extern*, the static would force internal linkage again. Without *static*, inline would lead to external weak linkage. Without *inline*, constexpr implies const for variables which would give internal linkage again. Without any specifier, the linkage would be external. 

## Conclusion

Finally, I would like to stress that this blogpost and the above table specifically are tools to navigate these keywords in most cases. If we apply more strict criteria, I would argue that the C++ standard does not formally define compile-time, link-time, or runtime behaviors for linkage, nor does it recognize "weak external linkage" as a formal category. How the inline concept allows for multiple definitions exactly is a linker-specific concept (e.g., ELF weak symbols) and not guaranteed by the language, making it an oversimplification in the table.
