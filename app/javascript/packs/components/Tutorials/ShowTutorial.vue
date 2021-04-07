<template>
  <div class="container-block">
    <div class="relative py-0 mt-10 inside-container">
      <button
        class="absolute top-0 left-0 px-4 py-2 bg-green-400 hover:bg-green-300 rounded-tl-xl rounded-br-xl"
        onclick="window.history.back()"
      >
        BACK
      </button>
      <div>
        <span
          class="block text-2xl font-bold text-center lg:text-3xl xl:text-5xl"
        >
          {{ language.title }}
        </span>
      </div>
      <div class="mt-8 space-y-2">
        <div
          v-for="tutorial in resultQuery"
          :key="tutorial.id"
          class="border-b border-gray-400 border-dashed"
        >
          <span
            class="text-lg font-semibold sm:text-xl lg:text-2xl xl:text-3xl"
          >
            Query:
          </span>
          <span class="text-lg sm:text-xl lg:text-2xl xl:text-3xl">
            {{ tutorial.title }}
          </span>
          <p>
            <button
              :id="tutorial.id"
              @click.prevent="toggleStepsOpen(tutorial.id)"
              class="text-sm text-indigo-700 focus:outline-none"
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
        return this.language.tutorials
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
