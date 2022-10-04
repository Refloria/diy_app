<template>
    <quill-editor
      ref="readOnlyQuillEditor"
      class = "readOnlyQuillEditor"
      :options="editorOption"
      @focus="focus($event)"
    >
    </quill-editor>
</template>

<script>
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'
export default {
  name: 'ReadOnlyQuillEditor',
  props: {
    content: String
  },
  data () {
    return {
      quillUpdateImg: false, // 根据图片上传状态来确定是否显示loading动画，刚开始是false,不显示
      // content: null,
      editorOption: {
        placeholder: '',
        theme: 'snow', // or 'bubble'
        modules: {
          toolbar: []
        }
      }
    }
  },
  mounted () {
    this.loadArticle()
  },
  watch: {
    content: {
      handler: function (val, oldVal) {
        if (val !== oldVal) { this.loadArticle() }
      }
    }
  },
  methods: {
    loadArticle () {
      if (!this.content || this.content === '') {
        this.$refs.readOnlyQuillEditor.quill.setContents(JSON.parse('[{"insert":"\\n"}]'))
      } else {
        this.$refs.readOnlyQuillEditor.quill.setContents(JSON.parse(this.content))
      }
    },
    focus (event) {
      event.enable(false) // 设置富文本编辑器不可编辑
    }
  }
}
</script>

<style lang='scss'>
.readOnlyQuillEditor .ql-toolbar.ql-snow {
  height: 0;
  border: none;
}

.readOnlyQuillEditor .ql-container.ql-snow{
  border: none;
}
</style>
