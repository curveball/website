---
layout: documentation
title: Body Parser
permalink: /docs/middleware/body-parser
description: Helps parse JSON and Text request bodies
repo: https://github.com/curveball/bodyparser
---

This middleware parses HTTP request bodies when they come in, and makes the
data available in `ctx.request.body`.

When this middleware is added, it will automatically read all bodies from
requests that have one of the following values as their `Content-Type` header:

* `application/json`
* `application/*+json`
* `application/x-www-form-urlencoded`
* `text/*`

It sets the result of this parsing process to the `ctx.request.body`
property. In the case of text bodies, it will result in a string.

In the case of JSON bodies, it will be the result of `JSON.parse` on the
body.

Installation
------------

    npm install @curveball/bodyparser

Getting started
---------------

```typescript
import { Application } from '@curveball/core';
import bodyParser from '@curveball/bodyparser';

const app = new Application();
app.use(bodyParser());


app.use( ctx => {
  // Log request bodies
  console.log(ctx.request.body);
});
```
