import { sveltekit } from "@sveltejs/kit/vite";
import type { UserConfig } from "vite";
import unocss from "unocss/vite";

const config: UserConfig = {
  plugins: [
    unocss(),
    sveltekit(),
  ],
  server: {
    port: 3080,
    host: '0.0.0.0'
  }
};

export default config;
