package com.example.app;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.sun.net.httpserver.HttpServer;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

class AppTest {

  private static HttpServer server;
  private static String base;

  @BeforeAll
  static void start() throws Exception {
    server = App.create(0);
    server.start();
    base = "http://127.0.0.1:" + server.getAddress().getPort();
  }

  @AfterAll
  static void stop() {
    server.stop(0);
  }

  @Test
  void healthz() throws Exception {
    HttpResponse<String> res;
    try (HttpClient client = HttpClient.newHttpClient()) {
      res = client.send(HttpRequest.newBuilder(URI.create(base + "/healthz")).build(),
          HttpResponse.BodyHandlers.ofString());
    }
    assertEquals(200, res.statusCode());
    assertEquals("ok", res.body());
  }
}
