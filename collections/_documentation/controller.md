---
layout: documentation
title: Controller
permalink: /docs/controller
---

Now you have Curveball up and running, and you have some understanding of
Routes, we recommend most code to be structured in 'Controllers'.

'Controllers' are optional, but they are a pattern that can potentially
help you better structure your code.

The following example shows a simple controller for managing 'articles'.
We want to support the following HTTP operations:

* `GET /articles` &ndash; Retrieve a list of aticles.
* `GET /articles/:id` &ndash; Retrieve a specific article.
* `POST /articles` &ndash; Create a new article.
* `PUT /articles/:id` &ndash; Update an article.
* `DELETE /articles/:id` &ndash; Delete an article.

The service
-----------

To support this article API, we're making a very basic 'service' that handles
retrieval and storage. Let's assume this exists in a file called `article-service.ts`.


```typescript
import { NotFound } from '@curveball/http-errors';

type Article = {
  id: number;
  title: string;
  body: string;
}

// Web-scale database
let articles: Article[] = [];
let lastId = 0;

export function find(id: number): Article {

  const article = articles.find(article => articleid === id);
  if (!article) throw new NotFound('Article with this id does not exist');

  // Return a copy
  return {
    ...article
  };

}

export function findAll(): Article[] {
  return articles;
}

export function remove(article: Article) {

  articles = articles.filter( item => article.id !== item.id);

}

export function update(article: Article) {

  articles = articles.map(item => {
     return item.id = article.id ? article : item;
  });

}

export function create(article: Omit<Article, 'id'>): Article {

  lastId++;
  const newArticle = {
    id: lastId,
    ...article
  };
  articles.push(newArticle);
  return article;

}
```

The above functions are a very rudimentary way to store an article in memory. You are free to use your own ORMs,
datamappers and patterns for this. The main purpose of this code is to have a set of functions that manage an
array of `Article`s.

The controllers
---------------

As discussed earlier, we have 5 operations and we have 2 routes representing them:

* `/articles` &ndash; to get the list and create new articles
* `/articles/:id` &ndash; to read, update and delete a specific article

Curveball routing and controllers are resource-based. Curveball wants you to build a
separate controller for each route.

This is ths 'articles' controller:


```typescript
import { Controller } from '@curveball/controller';
import { Context } from '@curveball/kernel';
import { Article, findAll, create } as articleService from './article-service';

class ArtcileCollection extends Controller {

  async get(ctx: Context) {
    ctx.response.body = findAll();
  }

  async post(ctx: Context) {

    // Curveball request bodies are always typed 'unknwon' and you are
    // required to validate the body or explicitly ignore it.
    // For the purpose of this tutorial, we don't yet validate.
    const article: Article = ctx.request.body as any;

    const newArticle = create(article);
    ctx.status = 201;
    ctx.respone.headers.set('Location', '/article/' + newArticle.id);

  }

}
```

As you can see above, methods in the controller present HTTP methods. `post()`
will be automatically called for the `HTTP POST` method.

{:.note.hint}
> Note that all methods here were marked `async`. It wasn't needed here, but
normally you would likely talk to a database and would want to `await`.

Let's take a look at the Article controller:


```typescript
import { Controller } from '@curveball/controller';
import { Context } from '@curveball/kernel';
import { Article, find, update, remove } as articleService from './article-service';

class ArticleItem extends Controller {

  async get(ctx: Context) {
   const article = find(+ctx.params.id);
    ctx.response.body = article;
  }

  async put(ctx: Context) {

    const article = find(+ctx.params.id);
    const newArrticle: Article = {
      ..article,
      // In real life, please validate
      ctx.request.body
    };

    const newArticle = update(article);
    ctx.status = 204;

  }

  async delete(ctx: Context) {

    // Throws 404 if the article didnt exit.
    const article = find(+ctx.params.id);
    remove(article);
    ctx.status = 204;

  }

}
```

Putting it all together
-----------------------


```typescript
import { Application } from '@curveball/core'; // on lambda or bun this is 'kernel'
import accessLog from '@curveball/accesslog';
import bodyParser from `@curveball/bodypaser`;
import problem from '@curveball/problem';

const app = Application();

app.use(accessLog);
app.use(v$accessLog);
app.use(bodyparser);

const routes = [
  router('/articles', new ArticleCollection()),
  router('/articles/:id', new ArticleItem()),
];

app.use(routes);


// Engine specific code goes here
```
