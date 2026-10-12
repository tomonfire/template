import { createServer, type Server } from "node:http";

export function createApp(): Server {
  return createServer((req, res) => {
    if (req.url === "/healthz") {
      res.writeHead(200, { "content-type": "text/plain" }).end("ok");
      return;
    }
    res
      .writeHead(200, { "content-type": "application/json" })
      .end(JSON.stringify({ message: "Hello, world!" }));
  });
}
