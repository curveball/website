---
title: Home
layout: home
---

### Hello world

```typescript
import { Application } from '@curveball/core';

const app = new Application();
app.use( async ctx => {
  ctx.response.type = 'text/plain';
  ctx.response.body = 'hello world';
});

app.listen(80);
```

Everything is a middleware, and middlewares may or may not be `async`.

### Hello world on AWS Lambda

```typescript
import { Application } from '@curveball/core';
import { handler } from '@curveball/aws-lambda';

const app = new Application();
app.use( ctx => {
  ctx.response.type = 'text/plain';
  ctx.response.body = 'hello world';
});

exports.handler = handler(app);
```

### HTTP/2 Push

```typescript
const app = new Application();
app.use( ctx => {
  ctx.response.type = 'text/plain';
  ctx.body = 'hello world';

  ctx.push( pushCtx => {

    pushCtx.path = '/sub-item';
    pushCtx.response.type = 'text/html';
    pushCtx.response.body = '<h1>Automatically pushed!</h1>';

  });

});
```

The callback to `ctx.push` will only get called if Push was supported by the
client, and because it creates a new 'context', any middleware can be attached
to it, or even *all* the middleware by doing a 'sub request'.


### Resource-based controllers

Controllers are optional and opinionated. A single controller should only ever
manage one type of resource, or one route.


```typescript
import { Application, Context } from '@curveball/core';
import { Controller } from '@curveball/controller';

const app = new Application();

class MyController extends Controller {

  get(ctx: Context) {

    // This is automatically triggered for GET requests

  }

  put(ctx: Context) {

    // This is automatically triggered for PUT requests

  }

}

app.use(new MyController());
```

### Routing

The recommended pattern is to use exactly one controller per route.

```typescript
import { Application } from '@curveball/core';
import router from '@curveball/router';

const app = new Application();

app.use(router('/articles', new MyCollectionController());
app.use(router('/articles/:id', new MyItemController());
```

### Content-negotation in controllers

```typescript
import { Context } from '@curveball/core';
import { Controller, method, accept } from '@curveball/controller';

class MyController extends Controller {

  @accept('html')
  @method('GET')
  async getHTML(ctx: Context) {

    // This is automatically triggered for GET requests with
    // Accept: text/html

  }

  @accept('json')
  @method('GET')
  async getJSON(ctx: Context) {

    // This is automatically triggered for GET requests with
    // Accept: application/json

  }

}
```

### Emitting errors

To emit a HTTP error, it's possible to set `ctx.status`, but easier to just
throw a related exception.


```typescript
function myMiddleware(ctx: Context, next: Middleware) {

  if (ctx.method !== 'GET') {
    throw new MethodNotAllowed('Only GET is allowed here');
  }
  await next();

}
```

The project also ships with a [middleware][5] to automatically generate
[RFC7807][4] `application/problem+json` responses.

### Transforming HTTP responses in middlewares

With express middlewares it's easy to do something *before* a request was
handled, but if you ever want to transform a response in a middleware, this
can only be achieved through a complicated hack.

This is due to the fact that responses are immediately written to the TCP
sockets, and once written to the socket it's effectively gone.

So to do things like gzipping responses, Express middleware authors needs to
mock the response stream and intercept any bytes sent to it. This can be
clearly seen in the express-compression source:
<https://github.com/expressjs/compression/blob/master/index.js>.

Curveball does not do this. Response bodies are buffered and available by
middlewares.

For example, the following middleware looks for a HTTP Accept header of
`text/html` and automatically transforms JSON to a simple HTML output:

```typescript
app.use( async (ctx, next) => {

  // Let the entire middleware stack run
  await next();
 
  // HTML encode JSON responses if the client was a browser.
  if (ctx.accepts('text/html') && ctx.response.type ==== 'application/json') {
    ctx.response.type = 'text/html';
    ctx.response.body = '<h1>JSON source</h1><pre>' + JSON.stringify(ctx.response.body) + '</pre>';
  }

});
```

To achieve the same thing in express would be quite complicated.

You might wonder if this is bad for performance for large files. You would be
completely right, and this is not solved yet.

However, instead of writing directly to the output stream the intent for this
is to allow users to set a callback on the `body` property, so writing the
body will not be buffered, just deferred. The complexity of implementing these
middlewares will not change.

### HTML API browser

Curveball also ships with an [API browser][6] that automatically transforms
JSON in to traversable HTML, and automatically parses HAL links and HTTP Link
headers.

Every navigation element is completely generated based on links found in the
response.

To use it:

```typescript
import { halBrowser } from 'hal-browser';
import { Application } from '@curveball/core';

const app = new Application();
app.use(halBrowser());
```

Once set up, your API will start rendering HTML when accessed by a browser.

<figure>
  <img src="/assets/posts/hal-browser.png" alt="HAL browser example" />
</figure>


### Sending informational responses

```typescript
ctx.response.sendInformational(103, {
  link: '</foo>; rel="preload"'
})
```

### Parsing Prefer headers

```typescript
const foo = ctx.request.prefer('return');
// Could be 'representation', 'minimal' or false
console.log(foo);
```

[1]: https://expressjs.com/
[2]: https://koajs.com/
[3]: https://github.com/awslabs/aws-serverless-express/blob/master/src/index.js
[4]: https://tools.ietf.org/html/rfc7807
[5]: https://github.com/curveball/problem/
[6]: https://github.com/curveball/hal-browser
[7]: https://github.com/curveball/core/issues
[8]: https://github.com/curveball
[9]: https://curveballjs.org/
[10]: https://github.com/curveball/core
[11]: https://badgateway.net/
[12]: https://github.com/curveball/a12n-server
