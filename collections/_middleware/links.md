---
layout: documentation
title: Links
permalink: /docs/middleware/links
description: Helps parse and generate HTTP Weblinks
repo: https://github.com/curveball/links
---

This middleware helps you parse and generate HTTP Weblinks.

Any links passed in a request via the [`Link`][3] header will now be exposed in
`ctx.request`.  Similarly, if a link was set in `ctx.response.links`, it will
automatically be encoded as a `Link` header in the HTTP response.

Lastly, if the request body was a [HAL][2] object, and it has a `_links`
property, these links will also be added to `ctx.response.links`.

Installation
------------

    npm i @curveball/links

Usage
-----

```typescript
import { Application, Context } from '@curveball/core';
import links from '@curveball/links';
import bodyParser from '@curveball/bodyparser';


const app = new Application();

// If you would like to parse HAL links, the bodyParser must be loaded first.
app.use(bodyParser());

app.use(links());

app.use( (ctx: Context) => {

  // Read a Link from a HAL body or Link header
  console.log(ctx.request.links.get('author'));

  // Write a Link header
  ctx.response.links.set({ rel: 'alternate' , type: 'text/csv', href: '/export.csv'});

});
```

[2]: https://tools.ietf.org/html/draft-kelly-json-hal-08
[3]: https://tools.ietf.org/html/rfc8288
