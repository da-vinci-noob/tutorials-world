<script setup>
import { ref, onMounted, computed } from 'vue'

const darkMode = ref(localStorage.dark ? true : false)

const updateIcon = computed(() => {
  return darkMode.value
})

onMounted(() => {
  if (window.localStorage.getItem('dark') == 'false') {
    document.documentElement.classList.remove('dark')
    darkMode.value = false
  } else {
    document.documentElement.classList.add('dark')
    darkMode.value = true
  }
})

const switch_theme = () => {
  if (window.localStorage.getItem('dark') == 'false') {
    window.localStorage.setItem('dark', true)
    document.documentElement.classList.add('dark')
    darkMode.value = true
  } else {
    window.localStorage.setItem('dark', false)
    document.documentElement.classList.remove('dark')
    darkMode.value = false
  }
  // console.log(window.localStorage.getItem('dark'))
}
</script>

<template>
  <div>
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
            : 'text-gray-700 bg-gray-200 font-semibold scale-110 hover:bg-white'
        ]"
      >
        Light
      </button>
      <button
        type="button"
        class="w-1/2 py-1 ease-out rounded-md smooth focus:outline-none"
        :class="[
          darkMode
            ? 'text-gray-200 bg-gray-700 font-semibold scale-110 hover:bg-gray-900'
            : 'hover:bg-gray-800 hover:text-gray-100 text-gray-200'
        ]"
      >
        Dark
      </button>
    </div>
  </div>
</template>
