---
layout: documentation
title: Static
permalink: /docs/middleware/static
description: Serves static files from a directory
repo: https://github.com/curveball/static
---

This middlware can be used to server files (assets) from a directory. For example, you
might want to expose a directory with css files or images to the world.


Installation
------------

    npm install @curveball/static


Getting started
---------------

```typescript
import { Application } from '@curveball/core';
import serveFiles from '@curveball/static';
import { join } from 'path';

const app = new Application();
app.use(
    serveFiles({
        // Absolute path to assets directory
        staticDir: join(__dirname, 'assets'),
    })
);
```


Serving files from a different directory
---------------
It is possible to serve files from a directory that doesn't math your request path.


For example:
| Static Dir          | Request URI       |
|---------------------|-------------------|
| `/home/app/static`  | `/assets/app.css` |

You would configure it like this:

```typescript
import { Application } from '@curveball/core';
import serveFiles from '@curveball/static';
import { join } from 'path';

const app = new Application();
app.use(
    serveFiles({
        // Absolute path to assets directory
        staticDir: join(__dirname, 'static'),
        pathPrefix: '/assets',
    })
);
```

API
---

The default export for this package is the `serveFiles` function. When called, this
function returns a middleware. It accepts a dictionary of configuration options.

### Options

- `staticDir`: Absolute path to assets directory. Assets cannot be served above
  this directory.
- `pathPrefix`: Request path to match if it differs from the static directory.
- `maxAge`: If specified, this will cause a `Cache-Control: max-age=n` header
  to be added, where `n` is the value of `maxAge`.
