# `nvh` Upstream Possibilities

Developer notes on code changes in `nvh` and tradeoffs, to help when considering Pull Requests to offer upstream.

## `cp` to `rsync`

Pros:

- easy to do `--preserve`
- supports symbolic links in destination

Cons:

- new dependency (installed on Mac, but will be extra in some environments,  especially containers)
- risk of changes in behaviour

## Preflight Download Using Command Status (not by parsing output)

Pros:

- feels more appropriate to check status than parse output
- rewrite eliminated need for broken iss_ok

Cons:

- risk of changes in behaviour

Mixed: new approach vulnerable to unreliable status, old approach to changes in output.

## Unify Version Lookup

Pros:

- avoid omissions where not all of run/which/install support an option

## Version Lookup Using `index.tab`

Download `index.tab` instead of scraping user-facing directory listings.

Pros:

- feels more appropriate using file for code, not scraping page for humans
- multiple issues have been reported scraping taobao over the years
- codename included in index.tab, support with less custom code
- sorting done for us (including the extra binary downloads like nightly, rc)
    - delete some complex piping and filtering code
- architectures included in index.tab, support restricting to available versions with less custom code

Mixed: new approach vulnerable to changes in file format, old approach to changes in web page format.

## Display `stderr` for `curl` Commands

Stop suppressing `stderr` when running curl commands.

Pros:

- user gets clues from `curl` about issue, especially proxy related

Cons:

- noisier failures (but more useful)

## Rework GET Error Handling

Rework commands to return an error status as well as display output, and rework calling code to handle them separately.

Pros:

- more accurate failure messages

Cons:

- more care required in routines now responsible for status
- more care required in calling code to handle error

## Follow `shellcheck` Advice

Pros:

- more robust code, such as coping with spaces in paths
- fixes some minor bugs
- makes ongoing development much safer

Cons:

- pervasive changes

## Always Install (even when node version already matches)

## (Add more from CHANGELOG)
