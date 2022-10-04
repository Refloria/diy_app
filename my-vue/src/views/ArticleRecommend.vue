<template>
  <div>
    <div class="table-button-bar">
      <el-button @click="handleMultipleCancelRecommend">取消推荐</el-button>
      <el-button @click="clearSelection">取消选择</el-button>
      <el-button @click="addRecommend" style="float: right">+ 添加</el-button>
    </div>
    <el-table
      :data="tableData" ref="articleTable" v-loading="loading" border
      @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="40"></el-table-column>
      <el-table-column prop="id" label="id" width="60"></el-table-column>
      <el-table-column prop="title" label="标题" min-width="200"></el-table-column>
      <el-table-column prop="userNickname" label="作者" min-width="80"></el-table-column>
      <el-table-column prop="publishTime" label="发布时间" min-width="80"></el-table-column>
      <el-table-column fixed="right" label="操作" width="110">
        <template #default="scope">
          <el-button @click="viewArticleDetails(scope.row)" type="text" size="small">查看</el-button>
          <el-button type="text" size="small" @click="handleCancelRecommend([scope.row])">取消推荐</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!--文章选择弹窗-->
    <el-dialog :visible.sync="articleSelectingVisible" width="90%" top="8vh">
      <el-scrollbar style="height:75vh"  ref="scrollBar1">
        <el-input placeholder="请输入内容" v-model="inputSearchWord" class="search-input"
                  @keyup.enter.native="searchArticle" ref="searchInput" clearable>
          <el-button slot="append" icon="el-icon-search" @click="searchArticle"></el-button>
        </el-input>
        <el-table :data="articlesData" ref="addRecommendTable" v-loading="loading2" border
                  @sort-change='sortChange' :default-sort="{prop:this.sortingColumn,order:this.sortingOrder}">
          <el-table-column prop="id" label="id" width="60" sortable='custom'></el-table-column>
          <el-table-column prop="title" label="标题" sortable='custom' min-width="200"></el-table-column>
          <el-table-column prop="userNickname" label="作者" sortable='custom' min-width="80"></el-table-column>
          <el-table-column prop="publishTime" label="发布时间" sortable='custom' min-width="80"></el-table-column>
          <el-table-column fixed="right" label="操作" width="90">
            <template #default="scope">
              <el-button @click="viewArticleDetails(scope.row)" type="text" size="small">查看</el-button>
              <el-button type="text" size="small" @click="handleRecommend(scope.row)">推荐</el-button>
            </template>
          </el-table-column>
        </el-table>
        <el-pagination
          @current-change="handleCurrentChange" @size-change="handleSizeChange"
          :current-page="currentPage" :page-size="pageSize" :page-sizes="[10, 20, 30, 40, 50]"
          :total="totalData"
          layout="total, sizes, prev, pager, next, jumper">
        </el-pagination>
      </el-scrollbar>
    </el-dialog>
    <!--文章详情弹窗-->
    <el-dialog :visible.sync="articleDetailVisible" width="80%" top="5vh">
      <el-scrollbar style="height:80vh" ref="scrollBar2">
        <article-detail v-bind:article-id="articleId" ref="articleDetail"></article-detail>
      </el-scrollbar>
    </el-dialog>
  </div>
</template>

<script>
import ArticleDetail from '@/views/ArticleDetail'

export default {
  name: 'ArticleRecommend',
  components: { ArticleDetail },
  data () {
    return {
      // 推荐文章表格
      tableData: [],
      multipleSelection: [],
      loading: false,
      // 非推荐文章表格
      articlesData: [],
      sortingColumn: 'publishTime',
      sortingOrder: 'descending',
      loading2: false,
      currentPage: 1,
      pageSize: 10,
      totalData: 0,
      inputSearchWord: '',
      searchWord: '',
      // 弹窗
      articleId: 0,
      articleSelectingVisible: false,
      articleDetailVisible: false
    }
  },
  mounted () {
    this.loadRecommendArticles()
  },
  methods: {
    loadRecommendArticles () {
      this.loading = true
      this.$axios.post('/api/getRecommendArticles').then(resp => {
        if (resp && resp.data.code === 200) {
          this.tableData = resp.data.data
        }
        this.loading = false
      }).catch(failResponse => {
        alert(failResponse)
        this.loading = false
      })
    },
    loadArticlePageList () {
      this.loading2 = true
      this.$axios.post('/api/getAddRecommendPageList', {
        page: {
          size: this.pageSize,
          current: this.currentPage
        },
        sortingColumn: this.sortingColumn,
        isDesc: this.sortingOrder === 'descending',
        searchWord: this.searchWord === '' ? null : this.searchWord
      }).then(resp => {
        if (resp && resp.data.code === 200) {
          this.articlesData = resp.data.data.records
          this.totalData = resp.data.data.total
        }
        this.loading2 = false
      }).catch(failResponse => {
        alert(failResponse)
        this.loading = false
      })
    },
    searchArticle () {
      this.searchWord = this.inputSearchWord
      this.$refs.searchInput.blur()
      this.sortingOrder = 'descending'
      if (this.searchWord.length > 0) {
        this.sortingColumn = 'keyWeight'
        this.$refs.addRecommendTable.clearSort()
      } else {
        this.sortingColumn = 'publishTime'
        this.$refs.addRecommendTable.sort(this.sortingColumn, this.sortingOrder)
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
        this.$refs.scrollBar2.wrap.scrollTop = 0
      })
      // this.$router.push({ path: '/articleDetail' })// + row.id.toString() })
    },
    addRecommend () {
      if (this.tableData.length >= 5) {
        this.$message.error('推荐作品最多为5个哦')
        return
      }
      this.sortingColumn = 'publishTime'
      this.sortingOrder = 'descending'
      this.currentPage = 1
      this.pageSize = 10
      this.totalData = 0
      this.inputSearchWord = ''
      this.articleSelectingVisible = true
      this.$nextTick(() => {
        this.$refs.scrollBar1.wrap.scrollTop = 0
      })
      this.loadArticlePageList()
    },
    handleCancelRecommend (rows) {
      if (!rows || rows.length <= 0) {
        this.$message.warning('没有选择作品哦')
        return
      }
      const articleIdList = []
      rows.forEach(row => {
        articleIdList.push({ id: row.id })
      })
      this.$axios.post('/api/cancelRecommendArticle', { articles: articleIdList })
        .then(resp => {
          if (resp.data.code === 200) {
            this.$message.success('取消推荐成功')
          } else {
            this.$message.error('取消推荐失败')
          }
          this.loadRecommendArticles()
        })
        .catch(failResponse => {
          alert(failResponse)
        })
    },
    handleMultipleCancelRecommend () {
      this.handleCancelRecommend(this.multipleSelection)
    },
    clearSelection () {
      this.$refs.articleTable.clearSelection()
    },
    handleSelectionChange (val) {
      this.multipleSelection = val
    },
    handleRecommend (row) {
      this.$axios.post('/api/recommendArticle', { id: row.id })
        .then(resp => {
          if (resp.data.code === 200) {
            this.$message.success('推荐成功')
          } else {
            this.$message.error('推荐失败')
          }
          this.articleSelectingVisible = false
          this.loadRecommendArticles()
        })
        .catch(failResponse => {
          this.articleSelectingVisible = false
          alert(failResponse)
        })
    }
  }
}
</script>

<style scoped>
.table-button-bar {
  text-align: start;
  margin-bottom: 10px;
}

.el-pagination {
  margin-top: 20px;
}

.search-input {
  max-width: 300px;
  float: right;
  margin-bottom: 10px;
}

::v-deep .el-scrollbar__wrap {
  overflow-x: hidden;
}

::v-deep .el-scrollbar__view {
  padding-right: 12px;
}

::v-deep .el-dialog {
  margin-bottom: 2vh;
}

</style>
