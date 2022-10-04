<template>
  <div style="max-width: 1000px;margin: 0 auto">
    <h1>{{ article.title }}</h1>
    <read-only-quill-editor v-bind:content="article.content"></read-only-quill-editor>
  </div>
</template>

<script>
import ReadOnlyQuillEditor from '@/components/ReadOnlyQuillEditor'

export default {
  name: 'ArticleDetail',
  components: {
    ReadOnlyQuillEditor
  },
  props: {
    articleId: Number
  },
  data () {
    return {
      article: {
        title: 'title1',
        introduction: '',
        content: '',
        tags: [1, 2],
        class: 2,
        addTime: '',
        lastEditTime: '',
        author: ''
      }
    }
  },
  mounted () {
    this.loadArticle()
  },
  watch: {
    articleId: {
      handler: function (val, oldVal) {
        if (val !== oldVal) { this.loadArticle() }
      }
    }
  },
  methods: {
    loadArticle () {
      this.$axios.post('/api/getArticle', { id: this.articleId }).then(resp => {
        if (resp && resp.data.code === 200) {
          var data = resp.data.data
          this.article.title = data.title
          this.article.content = data.content
        }
      })
    },
    onSubmit () {
    },
    goBack () {
      // console.log('go back')
    }
  }
}
</script>

<style scoped>
</style>
