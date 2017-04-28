# Ideology
- Erlang/Elixir/Elm inspired but with JavaScript in heart
- minimal syntax
- fully functional but not purelly
- runs in any js enviroment (node, browser) but good browser experience is keyword
- should be interopable without breaking whole whole thing (how clojurescript is doing that?)

# Modules
- module is defined by module keyword
- module should match fiename written in snake_case
- all modules are file agnostic and flat available without imports

```sugar
# example_module.su
module example_module
```
It can be accessed as following
```sugar
list:map()
```
### Exports
- functions are available to use outside module after export
- it's possible to export all functions using :all atom but it's recomended only for development
```sugar
export [fun/2, fun/1] 
export :all
```

# Functions
```sugar
foo([], acc) -> acc
foo([head|tail], acc) -> acc + head
```

## Lambdas
- `fun` keyword
```sugar
fun(a) -> a
```

## Default values
```sugar
add(a, b = 2) -> a + b
```

# Primitives
```sugar
# comment
:atom
10_10_10 # number
10.10111 # number
"string"
[1,2,3,4, "array"] # array
{:some, 12} # tuple
`template ${expression}`
```

# Basic keyword/features

### Operators
```sugar
-
+
/
*
//
++
--
**
==
!=
>=
<=
>
<
||
&&
~=
%
```
### Destructuring
- fail if no match
```sugar
{1, 2} = a
{ok, _} = some_complicated_task()
[head | tail] = [1, 2, 3, 4, 5]
```

### if
It always must have else branch
```sugar
if a == b then
  a
elseif b == 1
  b
else
  1
```

### case ... of
```sugar
case test() of
  1 -> []
  a -> [a]
```

### |> (pipe) operator
```sugar
[1, 2, 3, 4]
  |> list:map(fun(a) -> a + 2)
  |> list:filter(fun(a) -> a > 2)
```

# Standard library
```sugar
sugar/core (apply, call, etc.)
list
debug
string
tuple
math
regexp
object
date
number?
map?
set?
```

# Objects
```sugar
#{a: b,
  c: d}
```

# To be defined
- interop/dom access
- guards
- JS object
- list comprehension if so
- anonymous functions
- DOM/JS, documentation and tests as first class citizen
- can we design process based architecture, does it even make sense for browser?
- failing is common (does it make sens of us?)
