/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{js,ts,jsx,tsx,purs}",
    "./node_modules/flowbite/**/*.js",
  ],
  theme: {
    extend: {
      backgroundImage: {
        quest: "url('/assets/quest.png')",
        splash: "url('/assets/splash.png')",
        spacecat: "url('/assets/spaceCat.png')",
        catcard: "url('/assets/ProfileCard.png')",
        pinkbg: "url('/assets/pinkbg.png')",
        beach: "url('/assets/nyaaBeach.jpg')",
        "dark-beach": "linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)), url('/assets/nyaaBeach.jpg')",
        hypersynthetic: "linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)), url('/assets/hypersyntheticCover.jpg')",
        showmehow: "linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)), url('/assets/showMeHowCover.jpg')",
        lvl99: "linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)), url('/assets/lvl99Cover.png')",
      }
    },
  },
  plugins: [require("flowbite/plugin")],
};
