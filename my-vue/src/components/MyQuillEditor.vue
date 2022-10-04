<!--<template>-->
<!--  <div>-->
<!--    <div class="editor"></div>-->
<!--  </div>-->
<!--</template>-->

<!--<script>-->
<!--import Quill from 'quill'-->
<!--import 'quill/dist/quill.snow.css'-->

<!--// 工具栏配置-->
<!--const toolbarOptions = [-->
<!--  ['bold', 'italic', 'underline', 'strike'], // 加粗 斜体 下划线 删除线 -&#45;&#45;&#45;&#45;['bold', 'italic', 'underline', 'strike']-->
<!--  ['blockquote', 'code-block'], // 引用  代码块-&#45;&#45;&#45;&#45;['blockquote', 'code-block']-->
<!--  [{ header: 1 }, { header: 2 }], // 1、2 级标题-&#45;&#45;&#45;&#45;[{ header: 1 }, { header: 2 }]-->
<!--  [{ list: 'ordered' }, { list: 'bullet' }], // 有序、无序列表-&#45;&#45;&#45;&#45;[{ list: 'ordered' }, { list: 'bullet' }]-->
<!--  [{ script: 'sub' }, { script: 'super' }], // 上标/下标-&#45;&#45;&#45;&#45;[{ script: 'sub' }, { script: 'super' }]-->
<!--  [{ indent: '-1' }, { indent: '+1' }], // 缩进-&#45;&#45;&#45;&#45;[{ indent: '-1' }, { indent: '+1' }]-->
<!--  [{ direction: 'rtl' }], // 文本方向-&#45;&#45;&#45;&#45;[{'direction': 'rtl'}]-->
<!--  [{ size: ['small', false, 'large', 'huge'] }], // 字体大小-&#45;&#45;&#45;&#45;[{ size: ['small', false, 'large', 'huge'] }]-->
<!--  [{ color: [] }, { background: [] }], // 字体颜色、字体背景颜色-&#45;&#45;&#45;&#45;[{ color: [] }, { background: [] }]-->
<!--  // [{ font: [] }], // 字体种类-&#45;&#45;&#45;&#45;[{ font: [] }]-->
<!--  [{ align: [] }], // 对齐方式-&#45;&#45;&#45;&#45;[{ align: [] }]-->
<!--  ['clean'], // 清除文本格式-&#45;&#45;&#45;&#45;['clean']-->
<!--  ['link', 'image', 'video'] // 链接、图片、视频-&#45;&#45;&#45;&#45;['link', 'image', 'video']-->
<!--]-->

<!--export default {-->
<!--  name: 'editor',-->
<!--  props: {-->
<!--    value: Object-->
<!--  },-->
<!--  data () {-->
<!--    return {-->
<!--      quill: null,-->
<!--      options: {-->
<!--        theme: 'snow',-->
<!--        modules: {-->
<!--          toolbar: toolbarOptions-->
<!--        },-->
<!--        placeholder: 'Insert text here ...'-->
<!--      }-->
<!--    }-->
<!--  },-->
<!--  mounted () {-->
<!--    const dom = this.$el.querySelector('.editor')-->
<!--    this.quill = new Quill(dom, this.options)-->
<!--    this.quill.setContents(JSON.parse('[{"insert":"        各位小伙伴们，大家平时会怎么爱护自己心爱的钢笔或者Apple Pencil呢？这些文具都非常娇贵，需要我们的小心呵护💖\\n        今天就教大家用15分钟制作属于自己的复古文艺风笔套，颜值与实用性都在线哟😆\\n\\n成品展示"}]'))-->
<!--    // this.quill.setContents([-->
<!--    //   { insert: 'Hello ' },-->
<!--    //   { insert: 'World!', attributes: { bold: true } },-->
<!--    //   { insert: '\n' }-->
<!--    // ])-->
<!--    // this.quill.setContents(this.value)-->
<!--    // this.value)-->
<!--    this.quill.on('text-change', () => {-->
<!--      this.$emit('input', this.quill.getContents())-->
<!--    })-->
<!--  }-->
<!--}-->
<!--</script>-->

<template>
  <div>
    <!-- 图片上传组件辅助-->
    <el-upload
      class="avatar-uploader"
      accept="image/*"
      :action="serverUrl"
      :headers="header"
      :show-file-list="false"
      :on-success="uploadSuccess"
      :on-error="uploadError"
      :before-upload="beforeUpload">
    </el-upload>
    <!--      v-model="content"-->
    <quill-editor
      class="myQuillEditor"
      ref="myQuillEditor"
      :options="editorOption"
      @change="onEditorChange($event)"
    >
    </quill-editor>
  </div>
</template>

<script>
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'

// 工具栏配置
const toolbarOptions = [
  ['bold', 'italic', 'underline', 'strike'], // 加粗 斜体 下划线 删除线 -----['bold', 'italic', 'underline', 'strike']
  ['blockquote', 'code-block'], // 引用  代码块-----['blockquote', 'code-block']
  [{ header: 1 }, { header: 2 }], // 1、2 级标题-----[{ header: 1 }, { header: 2 }]
  [{ list: 'ordered' }, { list: 'bullet' }], // 有序、无序列表-----[{ list: 'ordered' }, { list: 'bullet' }]
  [{ script: 'sub' }, { script: 'super' }], // 上标/下标-----[{ script: 'sub' }, { script: 'super' }]
  [{ indent: '-1' }, { indent: '+1' }], // 缩进-----[{ indent: '-1' }, { indent: '+1' }]
  [{ direction: 'rtl' }], // 文本方向-----[{'direction': 'rtl'}]
  [{ size: ['small', false, 'large', 'huge'] }], // 字体大小-----[{ size: ['small', false, 'large', 'huge'] }]
  [{ color: [] }, { background: [] }], // 字体颜色、字体背景颜色-----[{ color: [] }, { background: [] }]
  // [{ font: [] }], // 字体种类-----[{ font: [] }]
  [{ align: [] }], // 对齐方式-----[{ align: [] }]
  ['clean'], // 清除文本格式-----['clean']
  ['link', 'image', 'video'] // 链接、图片、视频-----['link', 'image', 'video']
]

export default {
  name: 'MyQuillEditor',
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
          toolbar: {
            container: toolbarOptions,
            handlers: {
              image: function (value) {
                if (value) {
                  // 触发input框选择图片文件
                  document.querySelector('.avatar-uploader input').click()
                } else {
                  this.quill.format('image', false)
                }
              }
            }
          }
        }
      },
      serverUrl: '/api/upload', // 这里写你要上传的图片服务器地址
      header: {
        // token: sessionStorage.token
      } // 有的图片服务器要求请求头需要有token
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
      // this.$axios.post('/api/getArticle', { id: 29 }).then(resp => {
      //   if (resp && resp.data.code === 200) {
      //     var data = resp.data.data
      //     this.content = data.content
      //     alert(this.content)
      this.$refs.myQuillEditor.quill.setContents(JSON.parse(this.content))
      //     alert(this.$refs.myQuillEditor.quill.getContents())
      //   }
      // })
    },
    onEditorChange ({ editor, html, text }) { // 内容改变事件
      console.log('---内容改变事件---')
      this.content = html
      console.log(html)
    },
    // 富文本图片上传前
    beforeUpload () {
      // 显示loading动画
      this.quillUpdateImg = true
    },

    uploadSuccess (res, file) {
      // res为图片服务器返回的数据
      // 获取富文本组件实例
      console.log(res)
      const quill = this.$refs.myQuillEditor.quill
      // 如果上传成功
      if (res.code === 200) {
        // 获取光标所在位置
        const length = quill.getSelection().index
        // 插入图片 res.url为服务器返回的图片地址
        quill.insertEmbed(length, 'image', res.url)
        // 调整光标到最后
        quill.setSelection(length + 1)
      } else {
        this.$message.error('图片插入失败')
      }
      // loading动画消失
      this.quillUpdateImg = false
    },
    // 富文本图片上传失败
    uploadError () {
      // loading动画消失
      this.quillUpdateImg = false
      this.$message.error('图片插入失败')
    }
  }
}
</script>

<style lang='scss'>
.avatar-uploader {
  height: 0;
}

.myQuillEditor .ql-editor {
  line-height: normal !important;
  height: 400px;
}

.myQuillEditor .ql-snow .ql-tooltip[data-mode="link"]::before {
  content: "请输入链接地址:";
}

.myQuillEditor .ql-snow .ql-tooltip.ql-editing a.ql-action::after {
  border-right: 0;
  content: "保存";
  padding-right: 0;
}

.myQuillEditor .ql-snow .ql-tooltip::before{
  content: "访问链接";
}

.myQuillEditor .ql-snow .ql-tooltip a{
  line-height: inherit;
}

.myQuillEditor .ql-snow .ql-tooltip a.ql-action::after{
  content: "编辑";
}

.myQuillEditor .ql-snow .ql-tooltip a.ql-remove::before{
  content: "移除";
}

.myQuillEditor .ql-snow .ql-tooltip[data-mode="video"]::before {
  content: "请输入视频地址:";
}

.myQuillEditor .ql-snow .ql-picker {
  line-height: normal;
}

.myQuillEditor .ql-snow .ql-picker.ql-size .ql-picker-label::before,
.ql-snow .ql-picker.ql-size .ql-picker-item::before {
  content: "14px";
}

.myQuillEditor .ql-snow .ql-picker.ql-size .ql-picker-label[data-value="small"]::before,
.myQuillEditor .ql-snow .ql-picker.ql-size .ql-picker-item[data-value="small"]::before {
  content: "10px";
}

.myQuillEditor .ql-snow .ql-picker.ql-size .ql-picker-label[data-value="large"]::before,
.myQuillEditor .ql-snow .ql-picker.ql-size .ql-picker-item[data-value="large"]::before {
  content: "18px";
}

.myQuillEditor .ql-snow .ql-picker.ql-size .ql-picker-label[data-value="huge"]::before,
.myQuillEditor .ql-snow .ql-picker.ql-size .ql-picker-item[data-value="huge"]::before {
  content: "32px";
}

</style>
