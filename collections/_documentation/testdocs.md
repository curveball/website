---
layout: documentation
title: Test Docs
permalink: /docs/testdocs

---

What you need to know
---------------------

In markdown, using `{:.classname}` you can add css classes to elements. For example:

```markdown
{:.my-phat-class}
This will render as a paragraph with class set to "my-phat-class"
```

{:.note}
This is a paragraph with class `note`

> This is a plain `<blockquote>`, below are some blockquotes with class `.note.info`, `.note.warning`, `.note.bad`, `.note.good`

{:.note.info}
> In most cases this documentation also assumes you know Typescript.

{:.note.warning}
> If any of these concepts are foreign, this documentation is likely not a good
jumping off point.



{:.note.bad}
> Not dumb here. Please do not dumb here.

{:.note.good}
> Please dumb at municipal waste processing plant please.


```scss
.note {
  &:before {
    font-family: 'Genericons';
  }
}
```