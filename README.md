# Test application
---
Link to endpoint https://corva-test-app.herokuapp.com/compute/

Link to repo https://github.com/askubiy/corv_test


## Features

- Based on lightweight Sinatra DSL
- Ready for heroku deployment
- Ready for testing with rspec

## Getting started

### Local installation and run

1. Clone the repository
2. Install dependencies (`bundle`)
6. Run `rspec` from project dir to run all tests
7. Run `rackup -p 5000` to run server locally
8. Make requests to `http://localhost:5000/compute/` to test manually

### Testing on remote endpoint

Endpoint url https://corva-test-app.herokuapp.com/compute/

Make POST requests using for example Postman or using cUrl (valid request):

```
curl -X POST \
  https://corva-test-app.herokuapp.com/compute/req021 \
  -H 'Accept: */*' \
  -H 'Accept-Encoding: gzip, deflate' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Length: 458' \
  -H 'Content-Type: application/json' \
  -H 'Host: corva-test-app.herokuapp.com' \
  -H 'User-Agent: PostmanRuntime/7.18.0' \
  -H 'cache-control: no-cache' \
  -d '{
    "timestamp": 1493758596,
    "data": [
        {
            "title": "Part 1",
            "values": [
                0,
                3,
                5,
                6,
                2,
                10
            ]
        },
        {
            "title": "Part 2",
            "values": [
                6,
                3,
                1,
                3,
                9,
                4
            ]
        }
    ]
}'
```

Invalid request body:

```
curl -X POST \
  https://corva-test-app.herokuapp.com/compute/req021 \
  -H 'Accept: */*' \
  -H 'Accept-Encoding: gzip, deflate' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Length: 458' \
  -H 'Content-Type: application/json' \
  -H 'Host: corva-test-app.herokuapp.com' \
  -H 'User-Agent: PostmanRuntime/7.18.0' \
  -H 'cache-control: no-cache' \
  -d '{
    "timestamp": 1493758596
}'
```

