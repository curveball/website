---
layout: documentation
title: Writing Docs
permalink: /docs/writing-docs

---

## General tips

- **Aim** &ndash; aim to write shorter sentences
- **Try** &ndash; to avoid (many, long) one-sentence paragraphs. Use shorter sentences and string 'em together!
- **Rly** &ndash; why use many word when few word do trick?

### Subheadings
- (`###` / `h3`) Are great to help with that. <br/>_Subheadings don't show up in the page-nav menu, level 2 headings (`## / h2`) do._
- **Use markdown** be generous with markup. **bold**, _emphasise_, [add classes](#what-you-need-to-know), use ALL the markup!
- **For example**: why not use a horizontal line `---` some times?
- **Eyes only** Writing lots of dry paragraphs in a row? Throw an image, code snippet or a super hot tip [using the util classes](#what-you-need-to-know) in there. Let the mind wander for a bit!

---

## What you need to know

In markdown, using `{:.classname}` you can add css classes to elements. 

```markdown
{:.my-class}
This will render as a paragraph with class set to "my-class"

{:.my-class}
> This will render as a blockquote with class set to "my-class"
```
## Utility classes
The docs stylesheet contains a couple of util classes to decorate elements for extra emphasis.
Add `.note` to indicate a piece of text with an icon. 

* **`.note`** &ndash; base class, adds a general note icon indicator
* `.info` adds a blue info icon
* `.comment` adds a text balloon icon
* `.warning` adds a red exclamation mark icon
* `.hint` adds an arrow icon
* `.bad` adds a red cross icon
* `.good` adss a green (ish) check icon

## Usage

Add the class `.note` to a paragraph or blockquote. 

```
{:.note}
Paragraph with note

{:.note}
> Blockquote with note
```

{:.note}
Paragraph with note

{:.note}
> Blockquote with note

Optionally extend the class with appropriate indicator:
```
{:.note.warning}
> Yeah nah yeah m8
```


{:.note.warning}
> Yeah nah yeah m8 in a block quote

---

## Examples
**`.note`**

{:.note}
A general note

{:.note}
> A general note

**`.note.comment`**

{:.note.comment}
This paragraph indicates discussion.

{:.note.comment}
> This blockquotes indicates discussion.

**`.note.help`**

{:.note.help}
A sign showing people where they can find help

{:.note.help}
> In case you got lost please checkout [this other document](#)


**`.note.hint`**

{:.note.hint}
Indicates stuff you want to point out.

{:.note.hint}
> Indicates stuff you want to point out.

**`.note.info`**

{:.note.info}
Use **`.info`**  for stuff you want to point out, but differently.

{:.note.info}
> In most cases this documentation <del>also</del> assumes you know Typescript.

**`.note.warning`**

{:.note.warning}
**Warning** &ndash; Here be papercuts

{:.note.warning}
> _If any of these concepts are foreign, this documentation is **likely not** a good
jumping off point._

**`.note.bad`**

{:.note.bad}
**Discouraged** &ndash; Stuff to avoid 

{:.note.bad}
> Not dumb here. Please do not dumb here.

**`.note.good`**

{:.note.good}
**Encouraged** &ndash; Tips, best practices etc

{:.note.good}
> Please dumb at municipal waste processing plant please.

**`.note.fixme`**

{:.note.fixme}
> This should be changed before merging to `main`.

**`.note.suggestion`**

{:.note.suggestion}
> _Here is my suggestion for a copy change in the paragraph above ☝_

