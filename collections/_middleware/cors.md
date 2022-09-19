---
layout: documentation
title: CORS
permalink: /docs/middleware/cors
description: Adds CORS support
repo: https://github.com/curveball/cors
---

This middleware makes it easy to support [CORS][1] in your API or application.

Installation
------------

    npm install @curveball/cors 


Getting started
---------------

After installing the NPM package, simply import the CORS middleware to an existing Curveball server:

```typescript
import cors from '@curveball/cors';
import { Application } from '@curveball/core';

const app = new Application();
app.use(cors());
```

When manually providing CORS options, this is how it should look:

```typescript
app.use(cors({
    allowOrigin: '*',
    allowHeaders: ['Content-Type', 'Accept'],
    allowMethods: ['GET', 'POST'],
    exposeHeaders: ['Link', 'Date'],
    credentials: true
}));

```

If no options are given, it will use these defaults:

```typescript
{
    allowOrigin: '*',
    allowHeaders: ['Content-Type', 'User-Agent', 'Authorization', 'Accept', 'Prefer', 'Prefer-Push', 'Link'],
    allowMethods: ['DELETE', 'GET', 'PATCH', 'POST', 'PUT'],
    exposeHeaders: ['Location', 'Link'],
    credentials: false
}
```

[1]: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
