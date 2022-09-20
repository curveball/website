---
layout: documentation
title: Session-Redis
permalink: /docs/middleware/session-redis
description: Use Redis to store Curveball sessions
repo: https://github.com/curveball/session-redis
---

This package contains a [Redis][2] backend for the [Session][3] middleware.
Generally when your application scales beyond 1 server, and you use session
cookes you'll need a central storage for session data. Redis is a great pick
for this.

Installation
------------

    npm install @curveball/session-redis


Getting started
---------------

### Adding the middleware

```typescript
import session from '@curveball/session';
import { RedisStore } from '@curveball/session-redis';

app.use(session({
  store: new RedisStore(),
});
```

This will add the redis session store to curveball. Using the redis store
without any options will attempt to connect to a local Redis server using
default connection details.

Here is another example with more options:

```typescript
import session from '@curveball/session';
import RedisStore from '@curveball/session-redis';

app.use(session({
  store: new RedisStore({
    prefix: 'mysess',
    clientOptions: {
      host: 'myhost.redis',
      port: 1234,
      ...
    },
  }),
  cookieName: 'MY_SESSION',
  expiry: 7200
});
```

`clientOptions` is the set of options for the Redis client. The list of
available `clientOptions` can be found on the [NodeRedis/node_redis][1]
repository.

Instead of passing `clientOptions`, it's also possible to pass a fully setup
isntance of RedisClient. This can be useful if the same connection should be
re-used by a different part of your application:

```typescript
import session from '@curveball/session';
import RedisStore from '@curveball/session-redis';
import { RedisClient } from 'redis';

const redis = new RedisClient({
  host: 'myhost.redis',
  port: 1234,
});

app.use(session({
  store: new RedisStore({
    prefix: 'mysess',
    client: redis
  })
  cookieName: 'MY_SESSION',
  expiry: 7200
});
```

[1]: https://github.com/NodeRedis/node_redis#options-object-properties
[2]: https://redis.io/ "Redis"
[3]: /docs/middleware/session "Session middleware"
