---
layout: documentation
title: Getting started
permalink: /docs/getting-started

---

Curveball is a micro HTTP framework for Typescript. You can compare it to
[Express][1], [Koa][2] or [Fasify][3].

Curveball lets you build the same types of applications as these frameworks,
but it's especially well suited to build APIs. It embraces REST, and comes
with an number of quality of life features that make building advanced HTTP
APIs a joy.

Curveball runs on [Node][node], but it has a very minimal 'kernel', which makes
it run natively on [AWS Lambda][lambda] and [Bun][bun], unlike other frameworks
which often don't work without bulky compatibility layers.

What you need to know
---------------------

This documentation assumes you have an understanding of the main HTTP concepts
such as:

* **Requests**, including the URL, method, headers and body.
* **Responses**, including the status, headers and body. (and what they mean)

In most cases this documentation also assumes you know Typescript.

{:.note.warning}
> If any of these concepts are foreign, this documentation is likely not a good
jumping off point.

Picking an engine
-----------------

Curveball currently supports a few different runtime engines. They are all
a little different, so there is separate set-up instructions for each of them.

If you are not sure which to start with, Node is by far the most commmon.

* [Node][node]
* [Bun][bun]
* [AWS Lambda][lambda]
* [Azure Functions][azure]

Choose your engine to continue this guide.

[1]: https://expressjs.com/
[2]: https://koajs.com/
[3]: https://www.fastify.io/

[node]: /docs/node
[bun]: /docs/bun
[lambda]: /docs/aws-lambda
[azure]: /docs/azure-functions


<!--

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

* [100 Continue][http-100] &ndash; to let a client know even before the request
  completed that it makes sense to continue, or that it should break off the
  request.

* [102 Processing][http-102] &ndash; to periodically indicate that the server is
  still working on the response. This might not be very useful anymore.

* [103 Early Hints][http-103] &ndash; a new standard to let a client or proxy know
  early in the process that some headers might be coming, allowing clients or
  proxies to for example pre-fetch certain resources even before the initial
  request completes.

### Example: middleware using `103 Early Hints`:

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

* [Router](https://github.com/curveball/router)
* [Body Parser](https://github.com/curveball/bodyparser)
* [Sessions](https://github.com/curveball/session)


[1]: https://www.npmjs.com/package/raw-body
[2]: https://www.npmjs.com/package/accepts
[http-100]: https://tools.ietf.org/html/rfc7231#section-6.2.1 "RFC7231: 100 Continue"
[http-102]: https://tools.ietf.org/html/rfc2518#section-10.1 "RFC2518: 102 Processing"
[http-103]: https://tools.ietf.org/html/rfc8297 "RFC8297: 103 Early Hints"


-->
