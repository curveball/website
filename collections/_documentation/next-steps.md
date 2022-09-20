---
layout: documentation
title: Next Steps
permalink: /docs/next-steps

---

This documentation assumes that you've followed one of the following guides to
get started:

* [Node][node]
* [Bun][bun]
* [AWS Lambda][lambda]
* [Azure Functions][azure]

Most importantly, you have a 'hello world' application, and you have a reference
to an `app` variable.


Context, Request and Response
------------------------------

In the 'hello world' example, you saw a basic middleware:

```typescript
app.use((ctx: Context) => {

  ctx.response.body = {msg: 'hello world!'};

});
```

The `Context` object here contains all the infromation related to the HTTP request
and response, for example:

* `ctx.request.path` - Request URI (just the path)
* `ctx.request.query` - Query parameters
* `ctx.request.method` - HTTP method
* `ctx.request.headers` - Request headers
* `ctx.request.body` - Request body

* `ctx.response.status` - The response status code
* `ctx.response.headers` - Response headers
* `ctx.response.body` - Response body

The basic purpose of a middleware is to read things from `ctx.request` and set
things in `ctx.response`.

There's also many shortcuts in `ctx` for things that are unambigious, such as:

* `ctx.method`
* `ctx.path`
* `ctx.status`

This documentation does not (yet) have a  complete reference to the  `ctx`,
`ctx.request` and `ctx.response` documentation. We recommend taking a look
at the [source][1] to see what's available.

## Helpful middleware

2 middlewares you'll pretty much always want.

```
npm i @curveball/accesslog @curveball/bodyparser
```

Accesslog makes your terminal output and server logs more useful, and
bodyparser will let you read request bodies.

This is how you use them:

```typescript
import { Application } from '@curveball/core'; // on lambda or bun this is 'kernel'
import accessLog from '@curveball/accesslog';
import bodyParser from `@curveball/bodypaser`;

const app = Application();

app.use(accessLog);
app.use(bodyParser);
```


## A route and a GET request

Now that the basics are covered, lets make a simple fake API that returns some
data given a specific path.

This API responds to `GET /article/:id` and returns a JSON article that repeats
the id in the title.

We'll need another package:


```
npm i @curveball/router
```


```typescript
import router from '@curveball/router';
import { Application } from '@curveball/core'; // on lambda or bun this is 'kernel'

const app = Application();
app.use(router.get('/article/:id', async ctx => {

  ctx.response.body = {
    title: 'hello world ' + ctx.params.id,
    body: 'lorum ipsum?'
  };

});

// engine-specific code here
```

By default Curveball will respond with `200 OK` _if_ a response body was set.
It also defaults the `Content-Type` to `application/json`.

Note that we made the middleware async. _all_ Curveball middlewares may be
async.

A `PUT` request on the same route
----------------------------------

Lets assume we also want to do a `PUT` request here to let people update
articles.


```typescript
import router from '@curveball/router';
import { Application } from '@curveball/core'; // on lambda or bun this is 'kernel'

const app = Application();
app.use(bodyParser());
app.use(router.put('/article/:id', async ctx => {

  const newArticleBody = ctx.request.body;

  // Store this in a database
  ctx.response.status = 204; // Success !

});
```

Error handling
--------------

It's possible to set the error status in any middleware, as such:

```typescript
app.use(async ctx => {

  if (request.body.title === undefined) {
    ctx.status = 422;
    ctx.response.body = {
      'message': 'Title was missing!'
    }
    return;
  }

});
```

But we recommend using the [http-errors][http-errors] package instead:


```typescript
import { UnprocessableEntity } from '@curveball/http-errors';

app.use(async ctx => {

  if (request.body.title === undefined) {
    throw new UnprocessableEntity('Title was missing!');
  }

});
```

These exceptions can be thrown from anywhere.

We also strongly recommend using the [problem middleware][problem] to
automatically convert these errors to standard `application/problem+json`
responses.

Next up: learn about the [controller][controller] to better organize your code.


[1]: https://github.com/curveball/kernel/tree/main/src

[node]: /docs/node
[bun]: /docs/bun
[lambda]: /docs/aws-lambda
[azure]: /docs/azure-functions

[bodyparser]: /docs/middleware/bodyparser
[http-errors]: https://github.com/curveball/http-errors
[problem]: /docs/middleware/problem
[controller]: /docs/controller
