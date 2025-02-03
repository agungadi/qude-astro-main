import { defineConfig } from "astro/config";
import tailwind from "@astrojs/tailwind";
import mdx from "@astrojs/mdx";
import sitemap from "@astrojs/sitemap";
import icon from "astro-icon";

// https://astro.build/config
export default defineConfig({
  site: "https://midnusa.com",
  integrations: [tailwind(), mdx(), sitemap(), icon()],
  server: {
    host: "0.0.0.0",
    port: 3002
  },
  output: 'static',
});
