# Custom reverse proxy for *.csb.app domains

This repo uses nginx server to route all `*.test.com` requests to `*.csb.app`. This is used in this repo to show a custom 502 page when the csb.app preview urls return 502.

## Notes
- The proxy adds `csb_is_trusted=true` to trust the request coming in from the domain
- If all routes are requested via this proxy, there could some added latency as the request has to hop through one extra layer

## Running locally

Build docker image
```sh
docker build -t nginx-proxy .
```

Run the container
```sh
docker run -p 8123:80 nginx-proxy
```

Make a curl request to simulate `*.test.com` and see the response from the csb.app domain
For this example we can use https://codesandbox.io/p/devbox/9cgchy as the sandbox.

```sh
curl localhost:8123 -H "Host: 9cgchy-8080.test.com"
Hello from CodeSandbox!%
```

This should return the response from `9cgchy-8080.csb.app`.

Now we can test the 502 by stopping the running dev server inside the sandbox. 

Now it will return the custom 502 page
```sh
curl localhost:8123 -H "Host: 9cgchy-8080.test.com"
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 100px; }
        h1 { color: #e74c3c; }
        p { color: #7f8c8d; }
    </style>
</head>
<body>
    <h1>Error</h1>
    <p>The server cannot be reached. Start the dev server inside the vm</p>
</body>
</html>%      
```