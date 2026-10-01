# Code style

These apply to every project and every language, unless a project's own
CLAUDE.md or the surrounding file says otherwise — existing local convention
always wins over a preference here.

## Language and dates

- **British English** throughout: prose, comments, documentation, commit
  messages, identifiers and user-facing copy. Colour, behaviour, optimise,
  serialise, licence (noun) / license (verb).
- **British date conventions** in anything a person reads: `23/09/2026`, or
  `23 September 2026` written out. Never `09/23/2026`.
- **ISO 8601** (`2026-09-23`) for anything a machine reads or sorts: filenames,
  log lines, JSON fields, database columns.

## Simplicity

- **Flat, single-use functions.** A function called once, by one caller, is
  fine and usually clearer than the inlined alternative. Don't generalise it
  until a second caller genuinely exists.
- **No speculative abstraction.** Write the helper when a caller needs it, not
  in case one might. Delete helpers that lose their last caller.
- **Plain data.** Prefer the language's ordinary structures — dicts, records,
  arrays — over classes, models and wrapper types. Use classes only where the
  language gives you no reasonable alternative.
- **Early returns** over nested conditionals. Avoid deep indentation.
- Prefer a longer flat function over a short one that hides control flow in
  layers of indirection.

## Dependencies

- **Every dependency must be justified**, and the justification stated where
  it's declared. If the standard library or an existing dependency can do it,
  use that instead.
- Check what the project already depends on before reaching for anything new.
- Make optional features optional extras rather than mandatory installs.
- Pin version ranges.

## Comments

- Comment the **why**, never the what. No comment that restates the code.
- Do note units, sentinel values, and the reason a non-obvious choice was made.
- A module-level comment or docstring stating what the module is responsible
  for — and what it must not do — is worth having. Per-function docstrings on
  self-evident functions are not.

## Testing

- **Keep tests minimal.** Cover the critical paths — the logic that would do
  real damage if it were wrong, anything destructive or irreversible, and the
  core behaviour a user depends on.
- **Don't examine every failure case in detail.** One test per error branch is
  not the goal; exhaustive enumeration of how something can fail is rarely
  worth its maintenance cost.
- Prefer a few tests that exercise real usage over many narrow ones that pin
  down implementation details.
- Don't test trivial glue, straightforward accessors, or framework behaviour.
- If a test needs elaborate mocking or setup, treat that as a signal about the
  design rather than a problem to solve with more test scaffolding.

## Error handling

- **Fail fast and loudly.** An error you can't genuinely handle should surface,
  not be swallowed.
- No catch block that only logs and carries on. No fallback default that hides
  a bug behind plausible-looking output.
- Don't write error handling for cases that can't occur.
- Validate at the boundary — user input, parsing, external calls — then trust
  the data inside.
- Error messages say what failed and what to do about it.

## Planning

- Ask clarifying questions before planning or starting non-trivial work, rather
  than guessing at an ambiguous requirement.

## Verification

- **Run it before saying it works.** Build, tests, type check — whatever the
  project has.
- Never report success on unverified work. State plainly what was run and what
  wasn't.
- Show failing output rather than describing it.
- Because tests are kept minimal, exercise the real thing: run the command,
  call the endpoint, load the page.

## Git

- **Commit only when asked**, and never push unless asked.
- Branch before committing if the current branch is the default one.
- Commit messages: imperative mood, short subject line, body explaining why
  rather than what, no emoji.
- One logical change per commit.
- Never force-push a shared branch or rewrite published history.
- Never commit secrets, credentials or `.env` files.
- No `Co-Authored-By` trailer or other Claude attribution in commits or
  pull request descriptions.
