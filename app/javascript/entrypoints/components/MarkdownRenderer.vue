<script setup>
import MarkdownIt from 'markdown-it'

const markdown = new MarkdownIt()

defineProps({
  source: {
    type: String,
    default: ''
  }
})
</script>

<template>
  <div class="py-4 prose lg:prose-lg" v-html="markdown.render(source)" />
</template>
