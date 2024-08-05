module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {},
    backgroundImage: {
      "header-bg": "url('header_bg.png')",
      "main-bg": "url('main_bg.png')",
      "footer-bg": "url('footer_bg.png')",
    },
  },
  plugins: [require("daisyui")],
}
