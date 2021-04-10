<template>
  <div class="flex flex-row items-center justify-end mt-2 mr-2 space-x-4">
    <slot name="user"></slot>
    <div
      class="flex items-center justify-center w-32 px-2 py-1 space-x-2 rounded-md"
      :class="[darkMode ? 'bg-gray-200 ring-2 ring-green-600' : 'bg-gray-600']"
      @click="switch_theme"
    >
      <button
        type="button"
        class="w-1/2 py-1 ease-in rounded-md smooth focus:outline-none"
        :class="[
          darkMode
            ? 'hover:bg-white text-gray-800 bg-gray-300'
            : 'text-gray-700 bg-gray-200 font-semibold scale-125 hover:bg-white'
        ]"
      >
        Light
      </button>
      <button
        type="button"
        class="w-1/2 py-1 ease-out rounded-md smooth focus:outline-none"
        :class="[
          darkMode
            ? 'text-gray-200 bg-gray-700 font-semibold scale-125 hover:bg-gray-900'
            : 'hover:bg-gray-800 hover:text-gray-100 text-gray-200'
        ]"
      >
        Dark
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'DarkSwitcher',
  data() {
    return {
      darkMode: localStorage.dark ? true : false
    }
  },
  computed: {
    updateIcon() {
      return this.darkMode
    }
  },
  mounted() {
    if (window.localStorage.getItem('dark') == 'false') {
      document.documentElement.classList.remove('dark')
      this.darkMode = false
    } else {
      document.documentElement.classList.add('dark')
      this.darkMode = true
    }
  },
  methods: {
    switch_theme() {
      if (window.localStorage.getItem('dark') == 'false') {
        window.localStorage.setItem('dark', true)
        document.documentElement.classList.add('dark')
        this.darkMode = true
      } else {
        window.localStorage.setItem('dark', false)
        document.documentElement.classList.remove('dark')
        this.darkMode = false
      }
      // console.log(window.localStorage.getItem('dark'))
    }
  }
}
</script>
