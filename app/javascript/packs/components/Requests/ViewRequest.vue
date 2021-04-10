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
      View Requests
    </div>
    <div class="mt-8">
      <div
        v-for="(request, index) in incompleteRequests"
        :key="request.id"
        class="border-b border-gray-400 border-dashed"
      >
        <div class="flex flex-row items-baseline justify-between">
          <div>
            <span
              class="text-lg font-semibold sm:text-xl lg:text-2xl xl:text-3xl dark:text-gray-400"
            >
              Type:
            </span>
            <span
              class="text-lg capitalize sm:text-xl lg:text-2xl xl:text-3xl dark:text-gray-300"
            >
              {{ request.type_of_request }}
            </span>
          </div>
          <div>
            <span class="text-sm text-purple-500 sm:text-sm">
              &bull; {{ request.user.name }}
            </span>
            <span class="text-sm text-purple-500 sm:text-sm">
              &bull; ({{ request.updated_at.split('T')[0] }})
            </span>
          </div>
        </div>
        <p>
          <button
            :id="request.id"
            @click.prevent="toggleStepsOpen(request.id)"
            class="text-sm text-indigo-700 focus:outline-none dark:text-indigo-500 smooth"
          >
            Toggle Feedback
          </button>
        </p>
        <collapse-transition>
          <div v-show="isOpen[request.id]">
            <div class="p-2">
              <div class="px-4 py-1 bg-gray-200 rounded-2xl">
                <div class="pt-3 mb-6 bg-gray-200 rounded">
                  <label
                    class="flex items-center justify-between mx-3 mb-2 text-sm font-bold text-gray-700"
                    for="password"
                  >
                    Feedback
                  </label>
                  <textarea
                    disabled
                    name="body"
                    rows="10"
                    cols="30"
                    id=""
                    v-model="request.body"
                    class="w-full h-32 px-3 pb-3 text-gray-700 transition duration-500 bg-gray-200 border-b-4 border-gray-300 rounded focus:outline-none focus:border-purple-600"
                  />
                </div>
                <button
                  @click.prevent="updateRequest(index)"
                  class="w-full px-2 py-2 my-4 font-bold text-white transition duration-200 bg-purple-600 rounded shadow-lg hover:bg-purple-700 hover:shadow-xl"
                >
                  Completed
                </button>
              </div>
            </div>
          </div>
        </collapse-transition>
      </div>
      <div class="mt-10">
        <div class="mb-4 text-lg font-bold dark:text-gray-300">
          Completed Requests
        </div>
        <div
          v-for="request in completedRequests"
          :key="request.id"
          class="border-b border-gray-400 border-dashed"
        >
          <div class="flex flex-row items-baseline justify-between">
            <div>
              <span
                class="text-lg font-semibold sm:text-xl lg:text-2xl xl:text-3xl dark:text-gray-400"
              >
                Type:
              </span>
              <span
                class="text-lg capitalize sm:text-xl lg:text-2xl xl:text-3xl dark:text-gray-300"
              >
                {{ request.type_of_request }}
              </span>
            </div>
            <div>
              <span class="text-sm text-purple-500 sm:text-sm">
                &bull; {{ request.user.name }}
              </span>
              <span class="text-sm text-purple-500 sm:text-sm">
                &bull; ({{ request.updated_at.split('T')[0] }})
              </span>
            </div>
          </div>
          <p>
            <button
              :id="request.id"
              @click.prevent="toggleStepsOpen(request.id)"
              class="text-sm text-indigo-700 focus:outline-none dark:text-indigo-500 smooth"
            >
              Toggle Feedback
            </button>
          </p>
          <collapse-transition>
            <div v-show="isOpen[request.id]">
              <div class="p-2">
                <div class="px-4 py-1 bg-gray-200 rounded-2xl">
                  <div class="pt-3 mb-6 bg-gray-200 rounded">
                    <label
                      class="flex items-center justify-between mx-3 mb-2 text-sm font-bold text-gray-700"
                      for="password"
                    >
                      Feedback
                    </label>
                    <textarea
                      disabled
                      name="body"
                      rows="10"
                      cols="30"
                      id=""
                      v-model="request.body"
                      class="w-full h-32 px-3 pb-3 text-gray-700 transition duration-500 bg-gray-200 border-b-4 border-gray-300 rounded focus:outline-none focus:border-purple-600"
                    />
                  </div>
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
import axios from 'axios'
export default {
  components: {
    CollapseTransition
  },
  props: ['requests'],
  data() {
    return {
      isOpen: {},
      requests_copy: {}
    }
  },
  computed: {
    incompleteRequests() {
      return this.requests.filter((request) => request.is_completed == false)
    },
    completedRequests() {
      return this.requests.filter((request) => request.is_completed == true)
    }
  },
  created() {
    this.requests_copy = this.requests
    this.requests_copy.forEach((request) => {
      this.isOpen[request.id] = false
    })
  },
  methods: {
    toggleStepsOpen(index) {
      this.isOpen[index] = !this.isOpen[index]
      this.$forceUpdate()
    },
    updateRequest(index) {
      axios
        .put(
          `/requests/${this.incompleteRequests[index].id}.json`,
          {},
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
          alert('Request Marked Completed')
          window.location.reload()
        })
        .catch((error) => alert('An Error Occured'))
    }
  }
}
</script>

<style scoped></style>
