# Possible syntax

## Primitves

#### Basic primitves
* `Int`, `42` - integer value
* `Float`, `3.14` - floating point value
* `String`, `"bar"` - char array
* `Char`, `'c'` - single character (subject to change)
* `{Type, Type, ... , Type}`, `{1, 3.14}` - tuple
* `[Type]`, `[1,2,3,4,5]` - list
* `Atom`, `:atom` - unique value

## Functions 
#### Assumptions
* Compiler should be able to identify function definition by:
 * arity
 * type declaration
 * pattern matching
* Used function is identified in above order
* Every function is an expression
* Each function should be validated on compile time to prevent run-time errors
* Function definitions should be unique, every duplication should be warned and removed
* Type declarations should be known before definition.
* While declarations can be written gruped by at once in terms of validation, it should be warned to group declarations with coresponding definitions
* Each function definition should be reachable, if any is unreachable it should be warned and removed
* Identifing function by pattern match should happend from top to bottom in given arity and type declaration
* Functions should be written in `snake_case`

#### Function declarations
```sugar
foo(Int, Int) -> Int
foo(Int) -> Int
foo(Int) -> Float
```

#### Function definitions
```sugar
foo(0, 0) -> 1
foo(x, y) -> x + y

foo(x) -> x * 3.14
foo(0) -> 1
```

#### Correct declaration/definition gruping
```sugar
foo(Int, Int) -> Int
foo(0, 0) -> 1
foo(x, y) -> x + y

foo(Int) -> Int
foo(0) -> 1
foo(x) -> x + x

foo(Int) -> Float
foo(x) -> x * 3.14
```

#### Unreachable definition
```sugar
foo(Int) -> Int
foo(0) -> 1
foo(_) -> 1
foo(x) -> x #this definition is unreachable
```

## Pattern matching and destructuring
#### Asumptions
* Pattern matching can be used in function definitions
* Any input should be possible to match
* `_` keyword describes any thing in match
* Pattern matching can be used for destructuring `List` and `Tuples`
* `case of` to processing data diffrent based on pattern
* Any variable can be destructured
* All variables are created by destructuring
* List can be destructured by as many elements as you want. Last element will always be new `List` of all left elements or empty list.
* Any match that can possibly fail will be matched to Maybe monad.

#### Function matching matching

#### `case of` matching

#### Destructuring
```sugar
[head | tail] = [1, 2, 3]
# head => Just 1
# tail => [2, 3]

[head | tail] = [1]
# head => Just 1
# tail => []

{x, _} = {"hello", "world"}
# x => "hello"

x = add(1,2) # also an destructuring
# x => 3
```

## Comments
#### Asumptions
* Comment is defined by `#` character
* Everything from `#` to end of the line is omitted by compiler

#### Example
```sugar
# this is comment
foo(String, String) -> String # this is also comment
```

