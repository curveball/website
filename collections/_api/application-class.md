---
layout: documentation
title: API
permalink: /docs/api/api
nav-links:
  - title: The Application class
    link: the-application-class
  - title: The Context class
    link: the-context-class
  - title: The Request interface
    link: the-request-interface
  - title: The Response interface
    link: the-response-interface
---

## API

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
* `getAll()` - Returns all HTTP headers as a key-value object. 