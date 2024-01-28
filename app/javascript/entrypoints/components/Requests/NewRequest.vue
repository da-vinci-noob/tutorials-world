<script setup>
import CollapseTransition from '@ivanv/vue-collapse-transition/src/CollapseTransition.vue'
</script>

<template>
  <div>
    <button
      class="absolute top-0 left-0 px-4 py-2 bg-green-400 hover:bg-green-300 rounded-tl-xl rounded-br-xl dark:bg-green-600 dark:text-gray-800 dark:hover:bg-green-500 smooth"
      onclick="window.history.back()"
    >
      BACK
    </button>
    <div
      class="text-2xl font-bold text-center lg:text-3xl xl:text-5xl dark:text-gray-300"
    >
      Contact Us
    </div>
    <div class="mt-8">
      <form @submit.prevent="saveRequest">
        <div class="pt-3 mb-6 bg-gray-200 rounded">
          <label class="block mb-2 ml-3 text-sm font-bold text-gray-700">
            Type of Request
          </label>
          <select
            name="type"
            id="type"
            v-model="request_type"
            required
            class="w-full px-3 pb-3 text-gray-700 transition duration-500 bg-gray-200 border-b-4 border-gray-300 rounded focus:outline-none focus:border-purple-600"
          >
            <option disabled selected value="null">Click Here</option>
            <option value="language">Add New Language</option>
            <option value="feedback">Feedback</option>
          </select>
        </div>
        <div class="pt-3 mb-6 bg-gray-200 rounded">
          <label
            class="block mb-2 ml-3 text-sm font-bold text-gray-700"
            for="body"
          >
            Request
          </label>
          <textarea
            name="body"
            id="body"
            required
            v-model="request_body"
            class="w-full px-3 pb-3 text-gray-700 transition duration-500 bg-gray-200 border-b-4 border-gray-300 rounded focus:outline-none focus:border-purple-600"
          ></textarea>
        </div>
        <button
          class="w-full py-2 mt-6 font-bold text-white transition duration-200 bg-purple-600 rounded shadow-lg hover:bg-purple-700 hover:shadow-xl"
          type="submit"
        >
          Request
        </button>
      </form>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  props: ['tutorials'],
  data() {
    return {
      request_type: null,
      request_body: null
    }
  },
  methods: {
    saveRequest() {
      axios
        .post(
          `/requests.json`,
          {
            request: {
              type_of_request: this.request_type,
              body: this.request_body
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
          this.request_type = null
          this.request_body = null
          alert('Request Sent Successfully')
        })
        .catch((error) => alert('An Error Occured'))
    }
  }
}
</script>

<style scoped></style>
