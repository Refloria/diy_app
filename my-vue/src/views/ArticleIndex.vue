<template>

    <el-main class="list">
      <article-list-item></article-list-item>
      <!--<books></books>-->
    </el-main>
</template>

<script>
import ArticleListItem from '@/components/ArticleListItem'

export default {
  name: 'ArticleIndex',
  components: { ArticleListItem }
}
</script>

<style scoped>
.list{
  /*max-width: 930px;*/
  margin: auto;
  background: #f5f5f5;
}
</style>
