---
layout: documentation
title: Bun
permalink: /docs/bun
badge: new
---

To get started with Curveball and Bun, first make sure you have bun 
installed. Open a terminal and type the following command:

```
bun -v
```

If this gave you an error, head over to the [Bun documentation][bun] first
and install bun.

{:.note}
> Most of the documentation assumes you use the `npm` package manager
to install additional packages, but if you are a `bun` user you should probably
use `bun install` instead.

## Installation

Get the NPM package

```sh
bun add @curveball/kernel
```

## Hello world

This is the canonical 'Hello world' application in Curveball in Bun.
Make a file called `src/app.ts`, and enter the following:

```typescript
import { Application, Context } from '@curveball/kernel';

const app = new Application();

// Add all your middleware here!
app.use( ctx => {
  ctx.response.body = {msg: 'hello world!'};
});

export default {
  port: 4000,
  fetch: app.fetch.bind(app)
};
```

In Curveball (like Koa) everything is a middleware, so to respond to a request
you use the `.use()` method.

When this method gets called, you are given a `ctx` argument. This is an object
that contains all the information about both the HTTP request (`ctx.request`) and
the response (`ctx.response`).

In this case we are setting the reponse body to contain an object
`{msg: 'Hello world!'}`. By default this will be turned into a JSON string.

The last step is that we `default export` an object containing a TCP port number, and a 'fetch'
function. This is all Bun needs to start this application, which we can do
now with:

```
bun run src/app.ts
```

After this command you can go to <http://localhost:4000> to see if it worked.


{:.note.good}
> Now we've covered the Bun-specific documentation, go read [next steps][2] to
go over all the common use-cases.

[bun]: https://bun.sh/
[2]: /docs/next-steps
