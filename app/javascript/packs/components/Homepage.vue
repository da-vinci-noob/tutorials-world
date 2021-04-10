<template>
  <div class="space-y-4">
    <div class="flex flex-row items-center justify-between">
      <div class="w-1/4"></div>
      <div
        class="text-2xl font-bold text-center dark:text-gray-300 lg:text-3xl xl:text-5xl"
      >
        Welcome to Tutorials World
      </div>
      <div class="w-1/4 text-right">
        <slot name="add_new_link"></slot>
      </div>
    </div>
    <div>
      <h2 class="text-xl font-bold dark:text-gray-300">Languages</h2>
      <div class="mt-2">
        <slot name="language_buttons"></slot>
      </div>
    </div>
    <div>
      <h2 class="text-xl font-bold dark:text-gray-300">Others</h2>
      <div class="mt-2">
        <slot name="others_buttons"></slot>
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
