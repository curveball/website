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

## Installation

``` bash
$ npm install @curveball/core
``` 

## Handling requests

Curveball core only provides a basic framework. Using it means implementing or
using Curveball middleware. For example, if you want a router, use or build
a Router middleware.

All of the following examples are written in TypeScript, but it is also
possible to use the framework with plain JavaScript. The following example
is the most basic middleware for handling requests.

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

<!-- ```typescript
import { Application } from '@curveball/core';

const app = new Application();
const response = await app.subRequest('POST', '/foo/bar', { 'Content-Type': 'text/html' }, '<h1>Hi</h1>');
``` -->

Only the first 2 arguments are required. It's also possible to pass a Request object instead.

<!-- ```typescript
import { Application, MemoryRequest } from '@curveball/core';

const app = new Application();
const request = new MemoryRequest('POST', '/foo/bar', { 'Content-Type': 'text/html' }, '<h1>Hi</h1>');
const response = await app.subRequest(request);
``` -->

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
<!--
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
``` -->

## Official middleware

Curveball core provides very basic webserver functionalities. There are a variety of
officially supported middeware that adds additional features that can be added as
needed.

* [Router](https://github.com/curveball/router).
* [Body Parser](https://github.com/curveball/bodyparser).
* [Sessions](https://github.com/curveball/session).

<!-- ## API

### The Application class

The application is main class for your project. It's mainly responsible for
calling middlewares and hooking into the HTTP server.

It has the following methods

* `use(m: Middleware)` - Add a middleware to your application.
* `handle(c: Context)` - Take a Context object, and run all middlewares in
  order on it.
* `listen(port: number)` - Run a HTTP server on the specified port.
* `callback()` - The result of this function can be used as a requestListener
  for node.js `http`, `https` and `http2` packages.
* `subRequest(method: string, path:string, headers: object, body: any)` - Run
  an internal HTTP request and return the result.
* `subRequest(request: Request)` - Run an internal HTTP request and return the
  result.


### The Context class

The Context object has the following properties:

* `request` - An instance of `Request`.
* `response` - An instance of `Response`.
* `state` - An object you can use to store request-specific state information.
  this object can be used to pass information between middlewares. A common
  example is that an authentication middlware might set 'currently logged in
  user' information here.


### The Request interface

The Request interface represents the HTTP request. It has the following
properties and methods:

* `headers` - An instance of `Headers`.
* `path` - The path of the request, for example `/foo.html`.
* `method` - For example, `POST`.
* `requestTarget` - The full `requestTarget` from the first line of the HTTP
  request.
* `body` - This might represent the body, but is initially just empty. It's
  up to middlewares to do something with raw body and parse it.
* `rawBody()` - This function uses the [raw-body][1] function to parse the
  body from the request into a string or Buffer. You can only do this once,
  so a middleware should use this function to populate `body`.
* `query` - An object containing the query parametes.
* `type` - The `Content-Type` without additional parameters.
* `accepts` - Uses the [accepts][2] package to do content-negotiation.


### The Response interface

The Response interface represents a HTTP response. It has the following
properties and methods:

* `headers` - An instance of `Headers`.
* `status` - The HTTP status code, for example `200` or `404`.
* `body` - The response body. Can be a string, a buffer or an Object. If it's
  an object, the server will serialize it as JSON.
* `type` - The `Content-Type` without additional parameters.
* `sendInformational(status, headers?)` - Sends a `100 Continue`,
  `102 Processing` or `103 Early Hints` - response with optional headers.
* `push(callback: Middleware)` - Do a HTTP/2 push.


### The Headers inteface

The Headers interface represents HTTP headers for both the `Request` and
`Response`.

It has the following methods:

* `set(name, value)` - Sets a HTTP header.
* `get(name)` - Returns the value of a HTTP header, or null.
* `delete(name)` - Deletes a HTTP header.
* `append(name, value)` - Adds a HTTP header, but doesn't erase an existing
  one with the same name.
* `getAll()` - Returns all HTTP headers as a key-value object. -->



[1]: https://www.npmjs.com/package/raw-body
[2]: https://www.npmjs.com/package/accepts
[http-100]: https://tools.ietf.org/html/rfc7231#section-6.2.1 "RFC7231: 100 Continue"
[http-102]: https://tools.ietf.org/html/rfc2518#section-10.1 "RFC2518: 102 Processing"