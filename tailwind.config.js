module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        'light-red': '#ff9999', // 淡い赤色
        'light-blue': '#a0d6ff', // 淡い青色
        yellow: {
          700: '#B7791F',
          800: '#975A16',
          900: '#744210',
        },
        'light-gray': '#8C6D5C',
      },
      keyframes: {
        flashFade: {
          "0%": { transform: "translateX(180px)", opacity: 0 },
          "20%": { transform: "translateX(0)", opacity: 1 },
          "80%": { transform: "translateX(0)", opacity: 1 },
          "100%": { transform: "translateX(180px)", opacity: 0 },
        },
      },
      animation: {
        flash: "flashFade 7.0s forwards",
      },
    },
    backgroundImage: {
      "header-bg": "url('header_bg.png')",
      "main-bg": "url('main_bg.png')",
      "footer-bg": "url('footer_bg.png')",
    },
  },
  plugins: [require("daisyui")],
}
