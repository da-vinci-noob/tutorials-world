<script setup>
defineProps(['languages', 'others', 'language_path', 'new_tutorial_path'])
</script>

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
        <a
          :href="new_tutorial_path"
          class="inline-block px-2 py-1 text-sm text-gray-200 transform bg-indigo-600 rounded-lg smooth hover:scale-110 hover:bg-indigo-800 whitespace-nowrap"
          >Add new</a
        >
      </div>
    </div>
    <div>
      <h2 class="text-xl font-bold dark:text-gray-300">Languages</h2>
      <div class="mt-2">
        <div class="space-y-2">
          <a
            v-for="language in languages"
            :key="language.id"
            :href="language_path.replace('replace_id', language.id)"
            class="inline-block mr-4 btn-link btn-link-primary"
            >{{ language.title }}</a
          >
        </div>
      </div>
    </div>
    <div>
      <h2 class="text-xl font-bold dark:text-gray-300">Others</h2>
      <div class="mt-2">
        <div class="space-y-2">
          <a
            v-for="other in others"
            :key="other.id"
            :href="language_path.replace('replace_id', other.id)"
            class="inline-block mr-4 btn-link btn-link-primary"
            >{{ other.title }}</a
          >
        </div>
      </div>
    </div>
  </div>
</template>
