<template>
  <div>
    <button
      class="absolute top-0 left-0 px-4 py-2 bg-green-400 hover:bg-green-300 rounded-tl-xl rounded-br-xl dark:bg-green-600 dark:text-gray-800 dark:hover:bg-green-500 smooth"
      onclick="window.history.back()"
    >
      BACK
    </button>
    <div>
      <span
        class="block text-2xl font-bold text-center lg:text-3xl xl:text-5xl dark:text-gray-300"
      >
        {{ language.title }}
      </span>
    </div>
    <div class="mt-2 text-center lg:mt-4">
      <input
        class="px-4 py-1 rounded-lg outline-none focus:outline-none focus:ring-indigo-400 focus:ring-2 active:ring-indigo-400 active:ring-2 dark:bg-gray-500 dark:hover:bg-gray-600 dark:focus:bg-gray-600 smooth"
        type="text"
        autofocus
        v-model="searchQuery"
        placeholder="Search"
      />
    </div>
    <div class="mt-8 space-y-2">
      <div
        v-for="tutorial in resultQuery"
        :key="tutorial.id"
        class="border-b border-gray-400 border-dashed"
      >
        <div class="flex flex-row items-center justify-between space-x-2">
          <div>
            <span
              class="text-lg font-semibold sm:text-xl lg:text-2xl xl:text-3xl dark:text-gray-400"
            >
              Query:
            </span>
            <span
              class="text-lg sm:text-xl lg:text-2xl xl:text-3xl dark:text-gray-300"
            >
              {{ tutorial.title }}
            </span>
          </div>
          <div>
            <span class="text-sm text-purple-500 sm:text-sm">
              &bull; ({{ tutorial.updated_at.split('T')[0] }})
            </span>
            <span class="text-sm text-purple-500 sm:text-sm whitespace-nowrap">
              &bull; ( Author: {{ tutorial.user.name }})
            </span>
          </div>
        </div>
        <p>
          <button
            :id="tutorial.id"
            @click.prevent="toggleStepsOpen(tutorial.id)"
            class="text-sm text-indigo-700 hover:opacity-80 focus:outline-none dark:text-indigo-500 smooth"
          >
            Toggle Solution
          </button>
        </p>
        <collapse-transition>
          <div v-show="isOpen[tutorial.id]">
            <div class="p-2">
              <div class="px-4 py-1 bg-gray-200 rounded-2xl">
                <slot :name="`tutorial_body_${tutorial.id}`"></slot>
              </div>
            </div>
          </div>
        </collapse-transition>
      </div>
    </div>
  </div>
</template>
<script>
import { CollapseTransition } from '@ivanv/vue-collapse-transition'

export default {
  components: {
    CollapseTransition
  },
  props: ['language'],
  data() {
    return {
      isOpen: {},
      searchQuery: null
    }
  },
  created() {
    this.language.tutorials.forEach((tutorial) => {
      this.isOpen[tutorial.id] = false
    })
  },
  computed: {
    resultQuery() {
      if (this.searchQuery) {
        return this.language.tutorials.filter((item) => {
          return this.searchQuery
            .toLowerCase()
            .split(' ')
            .every(
              (v) =>
                item.title.toLowerCase().includes(v) ||
                item.body.toLowerCase().includes(v)
            )
        })
      } else {
        return this.language.tutorials
      }
    }
  },
  methods: {
    toggleStepsOpen(index) {
      this.isOpen[index] = !this.isOpen[index]
      this.$forceUpdate()
    }
  }
}
</script>

<style scoped></style>
