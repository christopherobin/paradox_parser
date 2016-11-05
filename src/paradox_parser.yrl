Nonterminals stmt stmts value number numberlist stringlist key document.
Terminals '{' '}' '=' int float string undefined.
Rootsymbol document.

document -> string stmts : ['$2'].
document -> stmts        : ['$1'].

stmts -> stmt       : ['$1'].
stmts -> stmt stmts : ['$1' | '$2'].

stmt -> key '=' value                        : [scalar, '$1', '$3'].
stmt -> key '=' '{' numberlist '}'           : [numberlist, '$1', '$4'].
stmt -> key '=' '{' stringlist '}'           : [stringlist, '$1', '$4'].
stmt -> key '=' '{' stmts '}'                : [block, '$1', '$4'].
stmt -> key '=' '{' '}'                      : [empty, '$1'].
stmt -> '{' '}'                              : [empty, 'nokey'].

stringlist -> string               : [extract_token('$1')].
stringlist -> undefined            : [undefined].
stringlist -> undefined stringlist : [undefined | '$2'].
stringlist -> string stringlist    : [extract_token('$1') | '$2'].

numberlist -> number            : ['$1'].
numberlist -> number numberlist : ['$1' | '$2'].

value -> int       : extract_token('$1').
value -> float     : extract_token('$1').
value -> string    : extract_token('$1').
value -> undefined : undefined.

number -> int   : extract_token('$1').
number -> float : extract_token('$1').

key -> string   : extract_token('$1').
key -> int      : list_to_binary(integer_to_list(extract_token('$1'))).

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.
