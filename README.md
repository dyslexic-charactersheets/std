# std
Standardised process for character sheet generation

## Purpose

To allow multiple tools, written in a variety of languages, to work together in the production of awesome character sheets for various role-playing games, including but not limited to Pathfinder and D&D.
Example uses include:

- saving a character description for later
- syncing your character between a device and the cloud
- building a character in one tool then passing to another tool
- importing a character from a tool like HeroLab into a character sheet


## Design

This doc defines a number of standard JSON formats using [JSON Schema](http://json-schema.org/).
Any tool or person may produce or consume a file in these formats.

## Formats

### Character Document

A description of a character, a party or a number of documents.

### Game Data (Full)

Describes information about a game: what classes are available, what skills they have, and what pages they produce.

### Game Data (Min)

Information about a game _without_ the parts relating to printing. Suitable for a web interface.

### Printable Document

A low level description of actual pages that will be printed.