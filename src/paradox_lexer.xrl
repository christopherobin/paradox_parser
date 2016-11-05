Definitions.

INT           = -?[0-9]+
FLOAT         = -?[0-9]+(\.[0-9]+)?
DATE          = -?[0-9]+\.[0-9]+\.[0-9]+
STRING        = [\.A-Za-z_0-9][\.\/A-Za-z0-9_]+
QUOTED_STRING = "[^"]*"
WHITESPACE    = [\s\t\n\r\x{FEFF}]
COMMENT       = #[^\n]*

Rules.

{INT}           : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
{FLOAT}         : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{DATE}          : {token, {string, TokenLine, TokenChars}}.
{STRING}        : {token, {string, TokenLine, TokenChars}}.
{QUOTED_STRING} : {token, {string, TokenLine, string:strip(TokenChars, both, $")}}.
\{              : {token, {'{', TokenLine}}.
\}              : {token, {'}', TokenLine}}.
=               : {token, {'=', TokenLine}}.
---             : {token, {undefined, TokenLine}}.
{COMMENT}       : skip_token.
{WHITESPACE}+   : skip_token.

Erlang code.
