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

In Curveball (like Koa) _everything_ is a middleware, so to respond to a request
you use the `.use()` method.

The `.use()` method requires a `ctx` object as its argument. This `ctx` object
contains all the information about the HTTP request and
the response, accessible via `ctx.request` and `ctx.response`.

In this case we are setting the reponse `body` to contain an object.

```typescript
ctx.response.body = {msg: 'Hello world!'}
``` 

{:.note.info}
By default this will be turned into a JSON string.

--- 

<!-- 
{:.note.suggestion}
>'this' ☝ is a bit vague. Is it significant to mention here? Are all curveball responses JSON by default? Consider adding a `.note.hint` like "(Did you know,) All Curveball responses are JSON by default btw (?)" 
-->


Lastly, call `listen()` to listen on a specific TCP port. 

After this, open <http://localhost:4000> to see if it worked.

{:.note.good}
> Now we've covered the Node-specific documentation, go read [next steps][2] to
go over all the common use-cases.

[1]: https://github.com/curveball/starter "Curveball Starter Template"
[2]: /docs/next-steps
