# std
Standardised process for character sheet generation

## Purpose

The goals of this standard are:

1. To decouple the process of character generation

2. To enable more flexible ways of storing, sharing and using this data.

The first is a preparation for future work. The front-end website is likely to be replaced some day; and new game systems are likely to require a complete overhaul of the back-end. This is a problem wile the two are tightly coupled, as they need to change together.

The second unlocks new possibilities, such as the ability to save, load, combine and exchange character sheet requests.

Combined, these goals will allow multiple tools, written in a variety of languages, to work together in the production of awesome character sheets for various role-playing games, including but not limited to Pathfinder and D&D. They enable the expansion of the tools to cover more new games, and new ways of building character sheets.

Further criteria for a successful format include:

1. It should be agnostic to technology and platform, so it can be easily used and implemented in a variety of programming languages and contexts.

2. It should be stable, so that a document should continue to be usable years later.

3. It should be flexible enough to fit unanticipated use cases, both new options internally and new ways of using the documents externally.

4. It must be compatible with the project's open source license.

A natural result of these criteria is that the format should avoid proprietary technology, and instead be made using existing standards throughout.

## Design

This repo defines a number of standard JSON formats using [JSON Schema](http://json-schema.org/).
Any tool or person may produce or consume a file in these formats.

The formats are versioned; in most cases, an earlier version of the file should be consumable by a later version of any software, either by the file still being valid or by .

## Formats

### Character Document

A description of a character, a party or a number of documents.

Read more: [Character Document](./character-schema).

### Game Data (Full)

Describes information about a game: what classes are available, what skills they have, and what pages they produce.

Read more: [Game Data Document](./game-data-schema).

### Game Data (Min)

Information about a game _without_ the parts relating to printing. Suitable for a web interface.

### Printable Document

A low level description of actual pages that will be printed.