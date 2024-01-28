<script setup>
import MarkdownRenderer from '../MarkdownRenderer.vue'
</script>

<template>
  <div>
    <button
      class="absolute top-0 left-0 px-4 py-2 bg-green-400 hover:bg-green-300 rounded-tl-xl rounded-br-xl dark:bg-green-600 dark:text-gray-800 dark:hover:bg-green-500 smooth"
      onclick="window.history.back()"
    >
      BACK
    </button>
    <a
      :href="path['tutorials']"
      class="absolute top-0 right-0 px-4 py-2 bg-green-400 hover:bg-green-300 rounded-tr-xl rounded-bl-xl dark:bg-green-600 dark:text-gray-800 dark:hover:bg-green-500 smooth"
    >
      Your Tutorials
    </a>
    <div v-if="is_admin" class="absolute right-0 mx-auto mt-2">
      <a
        :href="path['requests']"
        class="px-4 py-2 bg-green-400 hover:bg-green-300 rounded-tr-xl rounded-bl-xl dark:bg-green-600 dark:text-gray-800 dark:hover:bg-green-500 smooth"
      >
        Requests
      </a>

      <a
        :href="path['approval']"
        class="px-4 py-2 bg-green-400 hover:bg-green-300 rounded-tr-xl rounded-bl-xl dark:bg-green-600 dark:text-gray-800 dark:hover:bg-green-500 smooth"
      >
        Approvals
      </a>
    </div>
    <a
      :href="path['new_request']"
      v-else
      class="absolute right-0 px-4 py-2 mx-auto mt-1 bg-green-400 hover:bg-green-300 rounded-tr-xl rounded-bl-xl dark:bg-green-600 dark:text-gray-800 dark:hover:bg-green-500 smooth"
    >
      Contact
    </a>
    <div>
      <span
        class="block text-2xl font-bold text-center lg:text-3xl xl:text-5xl dark:text-gray-300"
      >
        Add New Tutorial
      </span>
    </div>
    <div v-if="response_body" class="flex justify-center mt-4">
      <p
        class="px-10 py-1 text-sm font-bold text-center rounded-lg sm:text-base md:text-xl lg:text-2xl"
        :class="[
          success
            ? 'bg-green-600 dark:text-gray-800'
            : 'bg-red-700 dark:text-gray-200'
        ]"
        v-html="response_body"
      ></p>
    </div>
    <div class="mt-10">
      <form @submit.prevent="saveTutorial" class="flex flex-col">
        <div class="pt-3 mb-6 bg-gray-200 rounded">
          <label
            class="block mb-2 ml-3 text-sm font-bold text-gray-700"
            for="email"
          >
            Select Language
          </label>
          <select
            name="type"
            id="type"
            v-model="selected_language"
            required
            class="w-full px-3 pb-3 text-gray-700 transition duration-500 bg-gray-200 border-b-4 border-gray-300 rounded focus:outline-none focus:border-purple-600"
          >
            <option disabled selected value="null">Click Here</option>
            <option
              v-for="language in languages"
              :key="language.id"
              :value="language.id"
            >
              {{ language.title }}</option
            >
          </select>
        </div>
        <div class="pt-3 mb-6 bg-gray-200 rounded">
          <label
            class="block mb-2 ml-3 text-sm font-bold text-gray-700"
            for="email"
          >
            Query
          </label>
          <input
            name="title"
            rows="7"
            required
            v-model="tutorial_title"
            placeholder="Enter Your Question/Problem"
            class="w-full px-3 pb-3 text-gray-700 transition duration-500 bg-gray-200 border-b-4 border-gray-300 rounded focus:outline-none focus:border-purple-600"
          />
        </div>
        <div class="pt-3 mb-6 bg-gray-200 rounded">
          <label
            class="flex items-center justify-between mx-3 mb-2 text-sm font-bold text-gray-700"
            for="password"
          >
            <span>
              Solution
            </span>
            <div>
              <span
                @click="isPreview = !isPreview"
                class="px-2 py-1 text-xs text-indigo-200 uppercase bg-indigo-600 rounded-lg cursor-pointer hover:bg-indigo-800 smooth"
              >
                Preview
              </span>
              <span class="text-xs uppercase">
                &bull; (Supports Markdown) &bull;
              </span>
            </div>
          </label>
          <div v-if="!isPreview">
            <textarea
              name="body"
              v-model="tutorial_body"
              rows="7"
              required
              placeholder="Enter Content"
              class="w-full px-3 pb-3 text-gray-700 transition duration-500 bg-gray-200 border-b-4 border-gray-300 rounded h-52 focus:outline-none focus:border-purple-600"
            ></textarea>
          </div>
          <div v-if="isPreview">
            <div class="px-4 py-1 bg-gray-200 rounded-2xl">
              <markdown-renderer :source="tutorial_body" />
            </div>
          </div>
        </div>
        <button
          class="block py-2 mt-6 font-bold text-white transition duration-200 bg-purple-600 rounded shadow-lg hover:shadow-xl focus:outline-none hover:bg-purple-700"
        >
          Save Tutorial
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  props: ['languages', 'is_admin', 'path'],
  data() {
    return {
      isPreview: false,
      selected_language: null,
      tutorial_title: null,
      tutorial_body: null,
      success: false,
      response_body: null
    }
  },
  created() {},
  methods: {
    saveTutorial() {
      axios
        .post(
          `/tutorials.json`,
          {
            tutorial: {
              title: this.tutorial_title,
              body: this.tutorial_body,
              language_id: this.selected_language
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
        .then((response) => {
          this.response_body = response.data.msg
          this.success = true
          this.reset_form()
        })
        .catch((error) => {
          this.response_body = error.response.data.errors.join('<br>')
          this.success = false
        })
    },
    reset_form() {
      this.selected_language = null
      this.tutorial_title = null
      this.tutorial_body = null
    }
  }
}
</script>
