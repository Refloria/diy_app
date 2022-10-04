<template>
  <div>
    <el-form :model="article" :rules="rules" label-width="80px">
      <el-page-header @back="goBack" content="发布文章"></el-page-header>
      <el-form-item label="标题" prop="title">
        <el-input v-model="article.title"></el-input>
      </el-form-item>
      <el-form-item label="分类" prop="class">
        <el-select v-model="article.class" placeholder="请选择分类">
          <el-option v-for="cla in classList" :key="cla.id" :label="cla.name" :value="cla.id"/>
        </el-select>
      </el-form-item>
      <el-form-item label="标签" prop="tags">
        <el-select v-model="article.tags" multiple filterable placeholder="请选择标签">
          <el-option v-for="item in tagList" :key="item.id" :label="item.name" :value="item.id"/>
        </el-select>
      </el-form-item>
      <el-form-item label="简介" prop="introduction">
        <el-input type="textarea" v-model="article.introduction"></el-input>
      </el-form-item>
      <el-form-item label="内容" prop="content">
        <my-quill-editor v-bind:content="article.content"></my-quill-editor>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">立即创建</el-button>
        <el-button>取消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import MyQuillEditor from '@/components/MyQuillEditor'

export default {
  name: 'ArticleEdit',
  components: {
    MyQuillEditor
  },
  data () {
    return {
      article: {
        title: 'title',
        introduction: '',
        content: '',
        tags: [1, 2],
        class: 2,
        addTime: '',
        lastEditTime: '',
        author: ''
      },
      classList: [
        { id: 1, name: '介绍' },
        { id: 2, name: '教程' },
        { id: 3, name: '展示' }
      ],
      tagList: [
        { id: 1, name: '刺绣' },
        { id: 2, name: '苏绣' },
        { id: 3, name: '草木染' },
        { id: 4, name: '扎染' },
        { id: 5, name: '蜡染' }
      ],
      rules: {
        title: [
          { required: true, message: '请输入标题', trigger: 'blur' }
        ],
        class: [
          { required: true, message: '请选择分类', trigger: 'change' }
        ],
        tags: [
          { required: true, message: '请选择标签', trigger: 'change' }
        ],
        introduction: [
          { required: true, message: '请输入标题', trigger: 'blur' }
        ],
        content: [
          { required: true, message: '请输入内容', trigger: 'blur' }
        ]
      }
    }
  },
  mounted () {
    this.loadArticle()
  },
  methods: {
    loadArticle () {
      this.$axios.post('/api/getArticle', { id: 29 }).then(resp => {
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
.el-form {
  padding: 10px;
  max-width: 1200px;
  margin: 10px auto;
  text-align: left;
}

.el-page-header {
  margin-left: 10px;
  margin-bottom: 20px;
}

.el-select {
  width: 100%;
}
</style>
