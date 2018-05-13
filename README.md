# README

[Dojo Forum website](https://www.dojoforum.ml/)


## Getting Started Forum
1. Ruby gem Install
```
bundle install
```

2. Setup database
```
rails db:migrate
rails db:seed
```

## API

#### 1.瀏覽文章清單(免登入)

```
GET - https://www.dojoforum.ml/api/v1/posts 
```

#### 2.登入

```
POST - https://www.dojoforum.ml/api/v1/login
```

登入後取得auth_token，以下都要登入需帶有auth_token

#### 3.依分類瀏覽文章清單

```
GET - https://www.dojoforum.ml/api/v1/posts 
```

params:

- category_id:分類id

#### 4.瀏覽單篇文章

```
GET - https://www.dojoforum.ml/api/v1/posts/:id 
```

#### 5.新增文章

```
POST - https://www.dojoforum.ml/api/v1/posts 
```
params:

- title
- description
- status: publish, draft 二選一
- permit: all, friend, myself 三選一
- category_ids: 分類id (非必填)

#### 6.修改文章

```
PATCH - https://www.dojoforum.ml/api/v1/posts/:id 
```
params:

- title
- description
- status: publish, draft 二選一
- permit: all, friend, myself 三選一
- category_ids: 分類id

#### 7.刪除文章

```
DELETE - https://www.dojoforum.ml/api/v1/posts/:id 
```

#### 8.登出

```
POST - https://www.dojoforum.ml/api/v1/logout 
```

