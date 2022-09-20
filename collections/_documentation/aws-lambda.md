---
layout: documentation
title: AWS Lambda
permalink: /docs/aws-lambda
---

Curveball runs natively on AWS lambda, but we do recommend getting some
experience on localhost first with [Node][node] or [Bun][bun].

Before you start with this, it's also important that you know on a high
level of AWS Lambdas work on a high level, and how they respond to HTTP
requests using the Node engine.

AWS lambdas use Node, but they don't use the `http` stack to handle HTTP
requests. These lambda functions export a 'handler' function that receive
an AWS specific object with the HTTP request information, and are expected
to return another object with the respone information.

The AWS documenation has a [good tutorial][1] that demonstrates a "Hello
world" with just the Lambda API.

Once you understand the basics, this is how Curveball integrates with
Lambda.

## Installation

Get the NPM packages

```sh
npm install @curveball/kernel @curveball/aws-lamba
npm install --dev @types/aws-lambda
```

## Hello world

This is the canonical 'Hello world' application in Curveball on AWS Lambda.
Usually this would be called `index.ts`, but you are responsible for tunring
this into `index.js` before uploading this to AWS.

```typescript
import { Application, Context } from '@curveball/kernel';
import handler from '@curveball/aws-lambda';

const app = new Application();

// Add all your middleware here!
app.use( ctx => {
  ctx.response.body = {msg: 'hello world!'};
});

exports.handler = handler(app);
```

In Curveball (like Koa) everything is a middleware, so to respond to a request
you use the `.use()` method.

When this method gets called, you are given a `ctx` argument. This is an object
that contains all the information about the HTTP request (`ctx.request`) and
the response (`ctx.response`).

In this case we are setting the reponse body to contain an object
`{msg: 'Hello world!'}`. By default this will be turned into a JSON string.

The last step is that we export a function called 'handler', which AWS will be
call for every request.

Now we've covered the Lambda-specific documentation, go read [next steps][2] to
go over all the common use-cases.

[1]: https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-create-api-as-simple-proxy-for-lambda.html
[2]: /docs/next-steps

[node]: /docs/bun
[bun]: /docs/node
