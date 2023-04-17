/** @type {import('tailwindcss').Config} */
module.exports = {
  purge: [
    "./app/**/*.html.erb",
    "./app/**/*.html.haml",
    "./app/helpers/**/*.rb",
    "./app/javascript/packs/**/*.js",
  ],
  content: [],
  theme: {
    extend: {},
  },
  plugins: [],
};
