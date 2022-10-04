<template>
  <div>
    <div class="table-button-bar">
      <el-button @click="handleMultipleArticleOnShelf">批量上架</el-button>
      <el-button @click="clearSelection">取消选择</el-button>
      <el-input placeholder="请输入内容" v-model="inputSearchWord" class="search-input"
                @keyup.enter.native="searchArticle" ref="searchInput" clearable>
        <el-button slot="append" icon="el-icon-search" @click="searchArticle"></el-button>
      </el-input>
    </div>
    <el-table
      :data="tableData" ref="articleTable" v-loading="loading" border
      @selection-change="handleSelectionChange"
      @sort-change='sortChange' :default-sort="{prop:this.sortingColumn,order:this.sortingOrder}">
      <el-table-column type="selection" width="40"></el-table-column>
      <el-table-column prop="id" label="id" width="60" sortable='custom'></el-table-column>
      <el-table-column prop="title" label="标题" sortable='custom' min-width="200"></el-table-column>
      <el-table-column prop="userNickname" label="作者" sortable='custom' min-width="80"></el-table-column>
      <el-table-column prop="publishTime" label="发布时间" sortable='custom' min-width="80"></el-table-column>
      <el-table-column fixed="right" label="操作" width="90">
        <template #default="scope">
          <el-button @click="viewArticleDetails(scope.row)" type="text" size="small">查看</el-button>
          <el-button type="text" size="small" @click="handleArticleOnShelf([scope.row])">上架</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      @current-change="handleCurrentChange" @size-change="handleSizeChange"
      :current-page="currentPage" :page-size="pageSize" :page-sizes="[10, 20, 30, 40, 50]"
      :total="totalData"
      layout="total, sizes, prev, pager, next, jumper">
    </el-pagination>
    <el-dialog :visible.sync="articleDetailVisible" width="80%" top="5vh">
      <el-scrollbar style="height:80vh" ref="scrollBar">
        <article-detail v-bind:article-id="articleId" ref="articleDetail"></article-detail>
      </el-scrollbar>
    </el-dialog>
  </div>
</template>

<script>
import ArticleDetail from '@/views/ArticleDetail'

export default {
  name: 'ArticleWaitChecking',
  components: { ArticleDetail },
  data () {
    return {
      tableData: [],
      currentPage: 1,
      pageSize: 10,
      totalData: 0,
      sortingColumn: 'publishTime',
      sortingOrder: 'descending',
      loading: true,
      articleDetailVisible: false,
      articleId: 0,
      multipleSelection: [],
      inputSearchWord: '',
      searchWord: ''
    }
  },
  mounted () {
    this.loadArticlePageList()
  },
  methods: {
    loadArticlePageList () {
      this.loading = true
      this.$axios.post('/api/getArticlePageList', {
        page: {
          size: this.pageSize,
          current: this.currentPage
        },
        sortingColumn: this.sortingColumn,
        isDesc: this.sortingOrder === 'descending',
        articleState: 0
      }).then(resp => {
        if (resp && resp.data.code === 200) {
          this.tableData = resp.data.data.records
          this.totalData = resp.data.data.total
        }
        this.loading = false
      })
    },
    searchArticle () {
      this.searchWord = this.inputSearchWord
      this.$refs.searchInput.blur()
      this.sortingOrder = 'descending'
      if (this.searchWord.length > 0) {
        this.sortingColumn = 'keyWeight'
        this.$refs.articleTable.clearSort()
      } else {
        this.sortingColumn = 'publishTime'
        this.$refs.articleTable.sort(this.sortingColumn, this.sortingOrder)
      }
      this.currentPage = 1
      this.loadArticlePageList()
    },
    handleCurrentChange: function (val) {
      this.currentPage = val
      this.loadArticlePageList()
    },
    handleSizeChange: function (val) {
      this.pageSize = val
      this.loadArticlePageList()
    },
    sortChange (column, prop, order) {
      if (column.order === null) return
      this.sortingColumn = column.prop // prop标签
      this.sortingOrder = column.order // descending降序、ascending升序
      this.currentPage = 1
      this.loadArticlePageList()
    },
    viewArticleDetails (row) {
      this.articleId = row.id
      this.articleDetailVisible = true
      this.$nextTick(() => {
        this.$refs.scrollBar.wrap.scrollTop = 0
      })
      // this.$router.push({ path: '/articleDetail' })// + row.id.toString() })
    },
    handleArticleOnShelf (rows) {
      if (!rows || rows.length <= 0) {
        this.$message({
          message: '没有选择作品哦',
          type: 'warning'
        })
        return
      }
      const articleIdList = []
      rows.forEach(row => {
        articleIdList.push({ id: row.id })
      })
      this.$axios.post('/api/putArticleOnShelf', { articles: articleIdList })
        .then(resp => {
          if (resp.data.code === 200) {
            this.$message({
              message: '上架成功',
              type: 'success'
            })
          } else {
            this.$message.error('上架失败')
          }
          this.loadArticlePageList()
        })
        .catch(failResponse => {
          alert(failResponse)
        })
    },
    handleMultipleArticleOnShelf () {
      this.handleArticleOnShelf(this.multipleSelection)
    },
    clearSelection () {
      this.$refs.articleTable.clearSelection()
    },
    handleSelectionChange (val) {
      this.multipleSelection = val
    }
  }
}
</script>

<style scoped>
.table-button-bar {
  text-align: start;
  margin-bottom: 10px;
}

.el-pagination{
  margin-top: 20px;
}

.search-input{
  max-width: 300px;
  float: right;
}

::v-deep .el-scrollbar__wrap    {
  overflow-x: hidden;
}

::v-deep .el-dialog {
  margin-bottom: 2vh;
}
</style>
