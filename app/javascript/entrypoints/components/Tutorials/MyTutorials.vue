<template>
  <div>
    <button
      class="absolute top-0 left-0 px-4 py-2 bg-green-400 hover:bg-green-300 rounded-tl-xl rounded-br-xl dark:bg-green-600 dark:text-gray-800 dark:hover:bg-green-500 smooth"
      onclick="window.history.back()"
    >
      BACK
    </button>
    <div class="flex flex-row items-center justify-between">
      <div class="w-1/4"></div>
      <div
        class="text-2xl font-bold text-center lg:text-3xl xl:text-5xl dark:text-gray-300"
      >
        Your Saved Tutorials
      </div>
      <div class="w-1/4 text-right">
        <slot name="add_new_link"></slot>
      </div>
    </div>
    <div class="mt-8 space-y-2">
      <div
        v-for="(tutorial, index) in tutorials_copy"
        :key="tutorial.id"
        class="border-b border-gray-400 border-dashed"
      >
        <div class="flex flex-row items-baseline justify-between">
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
            <span class="text-sm text-purple-500 sm:text-sm">
              &bull; ({{ tutorial.updated_at.split('T')[0] }})
            </span>
          </div>
          <div class="flex flex-row items-center space-x-2">
            <div>
              <span
                class="text-sm text-red-700 dark:text-red-500"
                v-if="!tutorial.is_approved"
              >
                Not Approved
              </span>
            </div>
            <button
              class="px-2 py-1 text-sm text-gray-100 bg-red-700 rounded-lg"
              @click.prevent="deleteTutorial(index)"
            >
              Delete
            </button>
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
                <div class="pt-3 mb-6 bg-gray-200 rounded">
                  <label
                    class="flex items-center justify-between mx-3 mb-2 text-sm font-bold text-gray-700"
                    for="password"
                  >
                    <span>
                      Solution (Edit)
                    </span>
                    <span class="text-xs uppercase">
                      &bull; (Supports Markdown) &bull;
                    </span>
                  </label>
                  <textarea
                    name="body"
                    rows="10"
                    cols="30"
                    id=""
                    v-model="tutorial.body"
                    class="w-full h-32 px-3 pb-3 text-gray-700 transition duration-500 bg-gray-200 border-b-4 border-gray-300 rounded focus:outline-none focus:border-purple-600"
                  />
                </div>
                <button
                  @click.prevent="updateTutorial(index)"
                  class="w-full px-2 py-2 my-4 font-bold text-white transition duration-200 bg-purple-600 rounded shadow-lg hover:bg-purple-700 hover:shadow-xl"
                >
                  Update Tutorial
                </button>
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
import axios from 'axios'
export default {
  components: {
    CollapseTransition
  },
  props: ['tutorials'],
  data() {
    return {
      isOpen: {},
      tutorials_copy: {}
    }
  },
  created() {
    this.tutorials_copy = this.tutorials
    this.tutorials_copy.forEach((tutorial) => {
      this.isOpen[tutorial.id] = false
    })
  },
  methods: {
    toggleStepsOpen(index) {
      this.isOpen[index] = !this.isOpen[index]
      this.$forceUpdate()
    },
    updateTutorial(index) {
      axios
        .put(
          `/tutorials/${this.tutorials_copy[index].id}.json`,
          {
            tutorial: {
              body: this.tutorials_copy[index].body
            }
          },
          {
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': document
                .querySelector('meta[name="csrf-token"]')
                .getAttribute('content')
            }
          }
        )
        .then((response) => alert('Tutorial Updated'))
        .catch((error) => alert('An Error Occured'))
    },
    deleteTutorial(index) {
      if (confirm('Are you sure')) {
        axios
          .delete(`/tutorials/${this.tutorials_copy[index].id}.json`, {
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': document
                .querySelector('meta[name="csrf-token"]')
                .getAttribute('content')
            }
          })
          .then((response) => {
            alert('Tutorial Deleted')
            this.tutorials_copy.splice(index, 1)
          })
          .catch((error) => alert('An Error Occured'))
      }
    }
  }
}
</script>

<style scoped></style>
