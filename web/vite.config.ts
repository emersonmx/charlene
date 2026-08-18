import { defineConfig } from "vite";
import tailwindcss from "@tailwindcss/vite";
import react from "@vitejs/plugin-react";

const host = process.env.TAURI_DEV_HOST;

// https://vite.dev/config/
export default defineConfig({
    plugins: [tailwindcss(), react()],

    clearScreen: false,
    server: {
        port: 5173,
        strictPort: true,
        host: host || false,
        hmr: host ? { protocol: "ws", host, port: 1421 } : undefined,
    },

    envPrefix: ["VITE_", "TAURI_ENV_*"],
    build: {
        target:
            process.env.TAURI_ENV_PLATFORM == "windows"
                ? "chrome111"
                : "safari16.4",
        minify: !process.env.TAURI_ENV_DEBUG ? "esbuild" : false,
        sourcemap: !!process.env.TAURI_ENV_DEBUG,
    },
});
