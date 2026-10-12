import { defineConfig } from "vite";

export default defineConfig({
  // Relative paths: the same build works at /, /staging/ and /pr-123/ on GitHub Pages.
  base: "./",
  build: { outDir: "site", emptyOutDir: true },
  server: { port: 8080 },
  preview: { port: 8080 },
});
