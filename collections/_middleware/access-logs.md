---
layout: documentation
title: Access Logs
permalink: /docs/middleware/access-logs
description: Automatically log HTTP requests and responses to the console
repo: https://github.com/curveball/accesslogs
---

The accesslog middleware logs HTTP requests, responses and error messages to
the console.

![Screenshot from 0.2.0](https://raw.githubusercontent.com/curveball/accesslog/main/screenshots/v0.2.0.png)

Installation
------------

    npm install @curveball/accesslog


Getting started
---------------

```typescript
import accessLog from '@curveball/accesslog';
import { Application } from '@curveball/core';

const app = new Application();
app.use(accessLog());
```

### Excluding urls

If you'd like to remove certain urls from the access log, you can filter
them out with the 'blacklist' setting.

The default blacklist contains one url: `/health`, as this is often an
endpoint used by load balancers and container orchestrators to see if the
service is alive.

To specify an alternative blacklist, just pass a list of strings to the
`accessLog` function.

```typescript
import accessLog from '@curveball/accesslog';
import { Application } from '@curveball/core';

const app = new Application();
app.use(accessLog({
  blacklist: ['/ignore']
}));
```

### Disabling ANSI colors

If you don't want any color output, it can be disabled entirely with the
`disableColor` option:

```typescript
import accessLog from '@curveball/accesslog';
import { Application } from '@curveball/core';

const app = new Application();
app.use(accessLog({
  disableColor: true
}));
```

[1]: https://github.com/curveball/
