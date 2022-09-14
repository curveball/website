---
layout: documentation
title: Basics
permalink: /docs/getting-started/basics
nav-links:
  - title: Overview
    link: overview
  - title: Installation
    link: installation
  - title: Handling requests
    link: handling-requests
  - title: Internal subrequests
    link: internal-subrequests
  - title: 1xx Informational responses
    link: 1xx-informational-responses
  - title: Official middleware
    link: official-middleware
---

## Overview

Curveball core only provides a basic framework. Using it means implementing or
using Curveball middleware. For example, if you want a router, use or build
a Router middleware.

All of the code examples are written in TypeScript, but it is also
possible to use the framework with plain JavaScript.
## Installation

``` bash
$ npm install @curveball/core
``` 

## Handling requests

The following example is the most basic middleware for handling requests.

```typescript
import { Application, Context } from '@curveball/core';

const app = new Application();
app.use((ctx: Context) => {

  ctx.status = 200;
  ctx.response.body = 'Hello world!'

});
```
## Internal subrequests

Many Node.js HTTP frameworks don't easily allow doing internal sub-requests.
Instead, they recommend doing a real HTTP request. These requests are more
expensive though, as it has to go through the network stack.

Curveball allows you do do an internal request with 'mock' request and
response objects.

Suggested use-cases:

* Running cheaper integration tests.
* Embedding resources in REST apis.

Example:

```typescript
import { Application } from '@curveball/core';

const app = new Application();
const response = await app.subRequest('POST', '/foo/bar', { 'Content-Type': 'text/html' }, '<h1>Hi</h1>');
```

Only the first 2 arguments are required. It's also possible to pass a Request object instead.

```typescript
import { Application, MemoryRequest } from '@curveball/core';

const app = new Application();
const request = new MemoryRequest('POST', '/foo/bar', { 'Content-Type': 'text/html' }, '<h1>Hi</h1>');
const response = await app.subRequest(request);
``` 

## 1xx Informational responses

Curveball has native support for sending informational responses. Examples are:

* [`100 Continue`][http-100] to let a client know even before the request
  completed that it makes sense to continue, or that it should break off the
  request.
* [`102 Processing`][http-102] to periodically indicate that the server is
  still working on the response. This might not be very useful anymore.
* [`103 Early Hints`][http-103] a new standard to let a client or proxy know
  early in the process that some headers might be coming, allowing clients or
  proxies to for example pre-fetch certain resources even before the initial
  request completes.

Here's an example of a middleware using `103 Early Hints`:

```typescript
import { Application, Context, Middleware } from '@curveball/core';

const app = new Curveball();
app.use(async (ctx: Context, next: Middleware) => {

  await ctx.response.sendInformational(103, {
    'Link' : [
      '</style.css> rel="prefetch" as="style"',
      '</script.js> rel="prefetch" as="script"',
    ]
  });
  await next();

});
```
## Official middleware

Curveball core provides very basic webserver functionalities. There are a variety of
officially supported middeware that adds additional features that can be added as
needed.

* [Router](https://github.com/curveball/router).
* [Body Parser](https://github.com/curveball/bodyparser).
* [Sessions](https://github.com/curveball/session).


[1]: https://www.npmjs.com/package/raw-body
[2]: https://www.npmjs.com/package/accepts
[http-100]: https://tools.ietf.org/html/rfc7231#section-6.2.1 "RFC7231: 100 Continue"
[http-102]: https://tools.ietf.org/html/rfc2518#section-10.1 "RFC2518: 102 Processing"
