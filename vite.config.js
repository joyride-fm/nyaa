import * as path from "path";
import { VitePluginFonts } from 'vite-plugin-fonts'

const DB = process.env.DEV_BUILD
  ? path.resolve(__dirname, "output/Main/")
  : process.env.NODE_ENV === "production"
  ? path.resolve(__dirname, "output-es/Main/")
  : path.resolve(__dirname, "output/Main/");

const ASSETS = path.resolve(__dirname, "assets/");

console.log(`Build path is ${DB}`);

export default {
  resolve: {
    alias: {
      PureScript: DB,
      assets: ASSETS,
    },
  },
  build: {
    minify: process.env.DEV_BUILD ? false : 'esbuild'
  },
  plugins: [
    VitePluginFonts({
      google: {
        families: ['Mochiy Pop P One'],
      },
    }),
  ],
};
