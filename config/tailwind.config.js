const { colors } = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/**/*.erb',
    './app/javascript/app.vue',
    './app/javascript/packs.vue',
    './app/javascript/**/*.vue',
    './app/javascript/*.vue'
  ],
  darkMode: 'class', // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        // Added CoolGray Colors
        gray: {
          50: '#f9fafb',
          100: '#f3f4f6',
          200: '#e5e7eb',
          300: '#d1d5db',
          400: '#9ca3af',
          500: '#6b7280',
          600: '#4b5563',
          700: '#374151',
          800: '#1f2937',
          900: '#111827'
        },
        green: {
          600: '#00FA00'
        }
      },
      fontFamily: {
        sans: [
          'Inter',
          'ui-sans-serif',
          'system-ui',
          '-apple-system',
          'BlinkMacSystemFont',
          '"Segoe UI"',
          'Roboto',
          '"Helvetica Neue"',
          'Arial',
          '"Noto Sans"',
          'sans-serif',
          '"Apple Color Emoji"',
          '"Segoe UI Emoji"',
          '"Segoe UI Symbol"',
          '"Noto Color Emoji"'
        ]
      }
    }
  },
  variants: {
    extend: {
      borderRadius: ['responsive', 'focus', 'active'],
      backgroundColor: ['focus']
    }
  },
  plugins: [require('@tailwindcss/typography')]
}
