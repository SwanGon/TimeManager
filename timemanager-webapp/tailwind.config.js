/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{vue,js,jsx}'],
  theme: {
    extend: {
      colors: {
        'bg-primary': '#0A0A0D',
        'bg-secondary': '#1E1E2F',
        'bg-tertiary': '#2B2D42',
        'text-primary': '#E6E6E6',
        'text-secondary': '#A9A9A9',
        'text-accent': '#FFD700',
        'button': '#4B4E6D',
        'button-hover': '#6C6F84',
        'button-text': '#E6E6E6',
        'icon': '#E6E6E6',
        'warning': '#FF4C4C',
        'disabled': '#7A7A7A',
      }
    }
  },
  plugins: []
}
