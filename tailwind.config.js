module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {}
  },
  variants: {
    borderRadius: ['responsive', 'focus', 'active']
  },
  plugins: [require('@tailwindcss/typography')]
}
