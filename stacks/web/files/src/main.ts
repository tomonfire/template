import "./style.css";
import { greeting } from "./greeting";

const app = document.querySelector<HTMLElement>("#app");
if (app) {
  app.innerHTML = `<h1>${greeting("world")}</h1><p>Edit <code>src/main.ts</code> and save.</p>`;
}
