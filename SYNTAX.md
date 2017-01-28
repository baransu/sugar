# Possible syntax

## Types
#### Assumptions
* Types should be written in PascalCase

Basic members (primitives):
* `Int` - integer value
* `Float` - floating point value
* `String` - char array
* `Char` - single character

## Functions 
#### Assumptions
* Compiler should be able to identify function definition by:
 * arrity
 * type declaration
 * pattern matching
* Used function is identified in above order
* Every function is an expression
* Each function should be validated on compile time to prevent run-time errors
* Function definitions should be unique, every duplication should be warned and removed
* Type declarations should be known before definition.
* While declarations can be written gruped by at once in terms of validation, it should be warned to group declarations with coresponding definitions
* Each function definition should be reachable, if any is unreachable it should be warned and removed
* Identifing function by pattern match should happend from top to bottom in given arrity and type declaration

#### Function declarations
```sugar
foo : Int, Int -> Int
foo : Int -> Int
foo : Int -> Float
```

#### Function definitions
```sugar
foo 0, 0 -> 1
foo x, y -> x + y

foo x -> x * 3.14
foo 0 -> 1
```

#### Correct declaration/definition gruping
```sugar
foo : Int, Int -> Int
foo 0, 0 -> 1
foo x, y -> x + y

foo : Int -> Int
foo 0 -> 1
foo x -> x + x

foo : Int -> Float
foo x -> x * 3.14
```

#### Unreachable definition
```sugar
foo : Int -> Int
foo 0 -> 1
foo _ -> 1
foo x -> x #this definition is unreachable
```
