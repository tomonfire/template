package com.example.app;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpServer;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;

/** Minimal HTTP service using the JDK's built-in server. */
public final class App {

  private App() {}

  /** Creates (but does not start) the server on the given port; 0 picks a free port. */
  public static HttpServer create(int port) throws IOException {
    HttpServer server = HttpServer.create(new InetSocketAddress(port), 0);
    server.createContext("/healthz", ex -> respond(ex, "text/plain", "ok"));
    server.createContext("/", ex -> respond(ex, "application/json", "{\"message\":\"Hello, world!\"}"));
    return server;
  }

  private static void respond(HttpExchange ex, String type, String body) throws IOException {
    byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
    ex.getResponseHeaders().set("Content-Type", type);
    ex.sendResponseHeaders(200, bytes.length);
    try (OutputStream out = ex.getResponseBody()) {
      out.write(bytes);
    }
  }

  public static void main(String[] args) throws IOException {
    int port = Integer.parseInt(System.getenv().getOrDefault("PORT", "8080"));
    create(port).start();
    System.out.println("listening on http://localhost:" + port);
  }
}
