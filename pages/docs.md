---
title: Curveball Documentation
permalink: /docs
layout: documentation
---

## Quick start

{:.quick-start} 
- [Get started](/docs/getting-started/basics)
- [View Examples](/docs/examples)
- [Browse Middlewares](/docs/middleware)

## Overview

Curveball is a framework for building web services in Node.js. It fulfills a
similar role to [Express][1] and it's heavily inspired by [Koa][2].

This web framework has the following goals:

* A minimal foundation.
* Completely written in and for [TypeScript][3].
* Modern Ecmascript features.
* Async/await-based middleware.
* Native support for modern HTTP features, such as [`103 Early Hints`][http-103].
* The ability to easily do internal sub-requests without having to do a real
  HTTP request.

If you used Koa in the past, this is going to look pretty familiar. We're big
fans of Koa and would probably recommend using it over this project if you don't need
any of the things Curveball offers.

[1]: https://expressjs.com/ "Express"
[2]: https://koajs.com/ "Koa"
[3]: https://www.typescriptlang.org/ "TypeScript"
[http-103]: https://tools.ietf.org/html/rfc8297 "RFC8297: 103 Early Hints"