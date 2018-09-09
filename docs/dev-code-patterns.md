# Developer Code Patterns

`bash` is not a programming language!

- calling a function does not return a value, it sets status code
- piping and error handling is tricky

## Returning Value from Function

### stdout

Pros:

- quite elegant
- output can be piped

Cons:

- error handling can not terminate script from subshell
- stdout can only be used for return value and not logging et al

NB: error messages in function must go to stderr.

```bash
function display_pi() {
    echo "3.141592653589793238462643883"
}

pi="$(display_pi)"
echo "Pi is $pi"

function might_fail() {
    >&2 echo "Uh oh"
    exit 1
}

dummy="$(might_fail)" || echo "Problem detected"

```

### Global

Pros:

- allows termination in error handling

Cons:

- can not call in subshell
- can not directly pass to pipe
- global variables

```bash
g_happy=
g_sad=

function set_happy() {
    g_happy="smile"
}

set_happy
echo "happy value is ${g_happy}"

function set_sad() {
    g_sad=
    echo "Terminating due to problem"
    exit 2
}

set_sad
echo "Not reached: ${g_sad}"

```

## Pipes

The complication with pipes is detecting and displaying errors. The latter problem is partially handled by errors always going to stderr, but subsequent parts of the pipeline will still process the stdout.

```bash
function display_happy() {
    echo "happy"
}

word_count=$(display_happy | wc -w)
echo "Happy count is ${word_count}"

function display_sad() {
    >&2 echo "Uh oh"
    echo "sad"
    return 1
}

word_count=$(display_sad | wc -w)
# $? is 0
echo "Sad count is ${word_count}"
```

### Temporary Variable

Pros:

- simple and explicit

Cons:

- not piping as such, first command finishes before second command starts
- storing full output in variable

```bash
function display_sad() {
    >&2 echo "Uh oh"
    echo "sad"
    return 1
}

if temp="$(display_sad)"; then
  word_count=$(echo "${temp}" | wc -w)
  echo "Happy count is ${word_count}"
else
  echo "Problem detected"
fi
```

### Pipe Status

PIPESTATUS is an array of status code from pipeline. A subshell can only conveniently return one status, but that may match the usage.  

```bash
function display_sad() {
    >&2 echo "Uh oh"
    echo "sad"
    return 1
}

word_count="$(display_sad | wc -w; exit "${PIPESTATUS[0]}")"
if [[ "$?" = 0 ]]; then
  echo "Happy count is ${word_count}"
else
  echo "Problem detected"
fi
```
