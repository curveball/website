---
layout: documentation
title: Getting started with Node
permalink: /docs/node
---

To get started with Curveball and Node, first make sure you have node
installed. Open a terminal and type the following two commands:

```
node -v
npm -v
```

Curveball currently requires a Node version higher than 16, and any `npm`
version that came with it.

Typescript is strongly suggested, and everything in Curveball is written
with Typescript in mind, including the documentation. The drawback of this
is that it's a bit more effort in Node.js to get everything up and running.

To make this easier, we made a [starter template][1] that you can use as a
starting point. It's very lightweight and unopiniated, but if you're already
comfortable configuring Typescript you don't need the template.

Template or not, here's roughly how you start an application from scratch:

## Installation

Get the NPM package

```sh
npm i @curveball/core
```

## Hello world

This is the canonical 'Hello world' application in Curveball:

```typescript
import { Application, Context } from '@curveball/core';

const app = new Application();
app.use((ctx: Context) => {

  ctx.response.body = {msg: 'hello world!'};

});

app.listen(4000);
```

In Curveball (like Koa) everything is a middleware, so to respond to a request
you use the `.use()` method.

When this method gets called, you are given a `ctx` argument. This is an object
that contains all the information about the HTTP request (`ctx.request`) and
the response (`ctx.response`).

In this case we are setting the reponse body to contain an object
`{msg: 'Hello world!'}`. By default this will be turned into a JSON string.

Lastly, you call `listen` to listen on a specific TCP port. After this call
you can go to <http://localhost:4000> to see if it worked.

Now we've covered the Node-specific documentation, go read [next steps][2] to
go over all the common use-cases.

[1]: https://github.com/curveball/starter "Curveball Starter Template"
[2]: /docs/next-steps
