# Character Document

A document format for describing characters. Can be turned, by a suitable program, into a character sheet.

Note that these documents are not character sheets; rather they represent all the selections a user makes when requesting a character sheet.

## Requirements

The format must describes the various choices a user makes when selecting to build a character sheet, includes but not limited to:

- The choice of whether to build a single character, a whole party, a set of GM sheets, or some other choice such as a starship, animal companion, NPC, kingdom, or something else.
- The game system it uses, ie Pathfinder, Starfinder, D&D 3.5 etc. These should be kept broad, since third-party material is often mixed with a core game.
- The user's preferred language.
- Choice of classes, archetypes, mythic paths, themes, etc. Some of these choices may be more complex than others, and may entail further choices such as fighting styles, domains, spell schools, oaths etc.
- Refinement of the character with choices such as skills, animal companions, spellbook style, etc. Some of these are yes/no flags, others are selections from a limited list, others are strings. It's expected that new choices will be added in the future, and the list of such choices will vary between games.
- Zero or more image choices, such as iconic, logo, etc. These may be taken from an existing pallette of images, or be custom images provided by the user, in which case it should be possible to embed the images within the document.
- Display and print choices such as watermark, colour or background.

The document should NOT say anything about how these choices should be implemented, ie what information goes on what pages or how it should be printed. The request should be applicable to any implementation.

## Specification

### JSON API wrapper

Each character sheet request **MUST** be a single JSON document, which **MUST** use UTF-8 encoding without BOM. It **SHOULD** validate with the attached JSON schema, though this condition is relaxed for a document written to a future version of the specification. The document **SHOULD** be in dense style, without extra spaces, newlines or indentation.

The top level of the document **MUST** have these parameters:

```json
{
    "version": 0,
    "data": { ... },
    "included": [ ... ]
}
```

- `"version"`: the version of this schema against which the document was written. Currently equal to `0`.
- `"data"`: a single resource object, whose type is typically one of `character`, `party`, etc.
- `"included"` (optional): an array of related resource objects or attachments.

### Resource objects and IDs

The primary resource object, in the `data` parameter, **MUST** be a single character, a party or whatever other item the user requested a character sheet for. There **MAY** be related resource objects or attachments in `included`; though attachments **MAY** be excluded from the document to reduce its size, provided they can be recovered by some other mechanism.

Every resource object **MUST** have a `type` parameter indicating its purpose, taken from a short (but flexible) list. Options include `"character"`, `"party"`, `"gm"` and `"starship"`.

Every resource object and attachment **MUST** have an ID in the format of `[a-z0-9]{6,}`, ie at least six digits of lowercase letters or numbers. For example, `f34ca87`. Resources **MUST** have this ID in their `id` parameter, like so:

```json
{
    "type": "character",
    "id": "f34ca87"
}
```

Resource objects **MAY** refer to others by ID. Any resource object or attachment not reachable from the main resource object **SHOULD** be removed from the document.

### Characters

A resource object of type `"character"` describes a single character.

```json
{
    "type": "character",
    "id": "f34ca87",
    "game": "pathfinder",
    "name": "John Smith",
    "language": "en",
    "pathfinder": { ... },
    "display": { ... },
    "print": { ... }
}
```

- `"game"`: the game system in which this character will be played.
- `"name"`: the name of the character.
- `"language"`: the preferred language code for the character sheet. May be either a two-letter code, `"en"`, or a four-letter locale code, `"en-GB"`.
- `"display"` (optional): settings related to displaying this character sheet on screen
- `"print"` (optional): settings related to printing this character sheet

There **SHOULD** also be a member matching the game name; eg `"game": "myhomebrew", "myhomebrew": { ... }`. This contains properties specific to the game.

### Parties

A resource object of type `"party"` describes a party consisting of multiple characters.

```json
{
    "type": "party",
    "id": "878dc9a",
    "game": "pathfinder",
    "language": "en",
    "characters": [ ... ],
    "pathfinder": { ... },
    "display": { ... },
    "print": { ... }
}
```

- `"game"`: the game system in which these characters will be played.
- `"language"`: the preferred language code for the character sheet. May be either a two-letter code, `"en"`, or a four-letter locale code, `"en-GB"`.
- `"characters"`: an array of character resource objects - see above.
- `"display"` (optional): settings related to displaying this character sheet on screen
- `"print"` (optional): settings related to printing this character sheet

Optionally, a party **MAY** also have a member matching the game name, with properties specific to the game which apply to the whole party. These may be different from the options which apply to the whole party.

### Display settings

```json
"display": {
    "color": "#fe23dc",
    "color2": "#001463",
    "dyslexic": true
}
```

### Print settings

```json
"print": {
    "color": "#fe23dc",
    "dyslexic": true
}
```

## Game data

While each game is different, they have elements in common. The first and most obvious of these is classes. While there are different ways classes and their variants can be handled (prestige classes, archetypes, variant rules, alternative class versions, errata, mythic paths, themes, backgrounds, etc), games in the D&D lineage typically all have classes.

```json
{
    "classes": [
        { "class": "Wizard" }
    ]
}
```

The class entry should include details of any variants or archetypes applied, as well as whether the class falls into certain categories, such as a theme, prestige class or mythic path. The class list may include some selectables which are not called classes.

Note that a class name in the data is not necessarily the name displayed on the page, because the name may be translated, or the display name may be different. For example, there may be more than one class with the same name.


### D&D 3.5e

```json
"dnd35": {
    "classes": [
        { "class": "Wizard", "variant": "" },
        { "class": "Ranger" },
        { "class": "Arcane Archer", "prestige": true }
    ]
}
```

### Pathfinder 1e

The class list for Pathfinder includes mythic paths.

```json
"pathfinder": {
    "classes": [
        { "class": "Druid", "archetype": [ "Urban Druid" ] },
        { "class": "Trickster", "mythic": true }
    ],
    "lycanthrope": true
}
```

### Starfinder

The class list for Starfinder includes themes.

```json
"starfinder": {
    "classes": [
        { "class": "Ace Pilot", "theme": true },
        { "class": "Soldier", "archetype": [ "Starfinder Adept" ] }
    ]
}
```

### Pathfinder 2e

```json
"pathfinder2": {
    "classes": [
        { "class": "Bard" }
    ]
}
```

## Examples

```json
{
  "version": 0,
  "data": {
    "type": "character",
    "id": "9a944c2",
    "game": "pathfinder",
    "name": "Harry Potter",
    "pathfinder": {
      "classes": [
        {
          "name": "Wizard",
          "variant": "Scroll Slinger"
        }
      ],
      "skillsAll": true,
      "lycanthrope": false,
      "spellbookStyle": "large"
    },
    "language": "en",
    "print": {
      "colour": "#f6d328",
      "dyslexic": true
    },
    "images": {
      "iconic": "f34ca87",
      "animalCompanion": "",
      "logo": "pathfinder.png"
    }
  },
  "included": [
    {
      "type": "attachment",
      "id": "f34ca87",
      "format": "image/png",
      "data": "PGh0bWw+CiAgPGhlYWQ+CiAgPC9oZWFkPgogIDxib2R5PgogICAgPHA+VGhpcyBpcyB0aGUgYm9keSBvZiB0aGUgbWVzc2FnZS48L3A+CiAgPC9ib2R5Pgo8L2h0bWw+Cg=="
    }
  ]
}
```
