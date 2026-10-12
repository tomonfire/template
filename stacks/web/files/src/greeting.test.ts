import { describe, expect, it } from "vitest";
import { greeting } from "./greeting";

describe("greeting", () => {
  it("greets by name", () => {
    expect(greeting("Ada")).toBe("Hello, Ada!");
  });

  it("falls back to world", () => {
    expect(greeting("  ")).toBe("Hello, world!");
  });
});
