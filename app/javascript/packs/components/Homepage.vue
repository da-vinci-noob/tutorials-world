<template>
  <div class="container-block">
    <div class="space-y-4 inside-container">
      <div class="flex flex-row items-center justify-between">
        <div class="w-1/4"></div>
        <div class="text-2xl font-bold text-center lg:text-3xl xl:text-5xl">
          Tutorials
        </div>
        <div class="w-1/4 text-right">
          <a
            href=""
            class="inline-block px-2 py-1 text-sm text-gray-200 transition duration-500 transform bg-indigo-600 rounded-lg hover:scale-110 hover:bg-indigo-800 whitespace-nowrap"
          >
            Add New
          </a>
        </div>
      </div>
      <div>
        <h2 class="text-xl font-bold">Languages</h2>
        <div class="mt-2">
          <slot name="language_buttons"></slot>
        </div>
      </div>
      <div>
        <h2 class="text-xl font-bold">Others</h2>
        <div class="mt-2">
          <slot name="others_buttons"></slot>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {}
  },
  methods: {}
}
</script>

<style scoped></style>
