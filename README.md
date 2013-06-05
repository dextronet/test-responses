Test HTTP responses
==============

With this simple node.js server you can test several hard-to-simulate HTTP responses in your client application.

## Usage

The point is you can change these response parameters:

* HTTP status code
* How long it takes for the server to respond
* How big should the response body be (from 1 MB to 999 MB)

This way you can test your client for the responses hard to simulate in your correctly functioning API.

### Use any URL you want (and any HTTP method)

You can pass any url you want. A simple text request may look like this:

```
GET /any/url/you-want
```

Response:

```
HTTP/1.1 200 OK
Date: Wed, 05 Jun 2013 09:10:51 GMT
Connection: keep-alive
Transfer-Encoding: chunke
```

With this basic setup, an empty `200 OK` response is returned.

`GET`, `POST`, `PUT` and `DELETE` methods are supported.

### Change HTTP response status code

Use the `status=[0-9]{3}` query parameter:

```
GET /any/url/you-want?status=500
```

And you'll get the `500 Internal Error` response.


### Simulate long requests on an overheated API

Sometimes the requests to your API may take longer than usual - either it's in a peak activity or the request data may be quite big.

Use the `respond=[0-9]{1,3}s` query parameter.

```
POST /send/something?respond=10s
```

This will delay the response by 10 seconds. Use any value from 1 second to 999 seconds.


### Simulate large content bodies

With the `respond` parameter you can also simulate content-rich responses from your API.

Just use `m` instead of `s` at the end:

```
GET /get/something?respond=25m
```

This will stream back to you a content body 25 megabytes in length.


### Combine status code and response time or length

You can combine the two parameters:

```
GET /request/to/api?status=510&respond=4s
```

However it's not possible to combine response delay and custom content length right now.