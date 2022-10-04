<template>
  <div>
    <el-row class="listArea">
      <!--<search-bar></search-bar>-->
      <el-row class="listItem" v-for="item in tutorials" :key="item.id">
        <el-col :span="6">
          <div class="cover">
            <el-image :src="item.cover" fit="cover" lazy/>
          </div>
        </el-col>
        <el-col :span="18" style="text-align:left">
          <div class="title">{{ item.title }}</div>
          <div>
            <el-tag v-for="(tag,i) in item.tags" size="mini" :key="i">{{ tag }}</el-tag>
          </div>
          <div class="intro">{{ item.introduction }}</div>
          <div>
            <el-avatar :src="item.authorPhoto" size="small" fit="cover"></el-avatar>
            <span class="author">
              <span>{{ item.author }}</span> /
              <span>{{ item.addTime }}</span>
            </span>
          </div>
        </el-col>
      </el-row>
    </el-row>
    <el-row>
      <el-pagination
        :current-page="1"
        :page-size="5"
        :total="20">
      </el-pagination>
    </el-row>
  </div>
</template>

<script>
export default {
  name: 'ArticleListItem',
  data () {
    return {
      tutorials: [
        {
          cover: 'http://img1.dongshou.com/course/cover/ds_20171028_112148_588225.jpg',
          title: '文艺流苏斜跨手机包',
          author: '晏大仙',
          authorPhoto: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',
          addTime: '2017-08-15',
          hints: 0,
          introduction: '新手第一次作品，看到好看的样式照图模仿做的，可以根据自己手机的大小制作，背后有一张卡位，夏天穿裙子出门没有地方放手机很适用(｡･ω･｡)',
          tags: ['包包', '新手', '皮艺']
        },
        {
          cover: 'http://img1.dongshou.com/course/cover/ds_20171028_112148_588225.jpg',
          title: '文艺流苏斜跨手机包',
          author: '晏大仙',
          addTime: '2017-08-15',
          hints: 0,
          introduction: '新手第一次作品，看到好看的样式照图模仿做的，可以根据自己手机的大小制作，背后有一张卡位，夏天穿裙子出门没有地方放手机很适用(｡･ω･｡)'
        },
        {
          cover: 'http://img1.dongshou.com/course/cover/ds_20171028_112148_588225.jpg',
          title: '文艺流苏斜跨手机包',
          author: '晏大仙',
          addTime: '2017-08-15',
          hints: 0,
          introduction: '新手第一次作品，看到好看的样式照图模仿做的，可以根据自己手机的大小制作，背后有一张卡位，夏天穿裙子出门没有地方放手机很适用(｡･ω･｡)'
        },
        {
          cover: 'http://img1.dongshou.com/course/cover/ds_20171028_112148_588225.jpg',
          title: '文艺流苏斜跨手机包',
          author: '晏大仙',
          addTime: '2017-08-15',
          hints: 0,
          introduction: '新手第一次作品，看到好看的样式照图模仿做的，可以根据自己手机的大小制作，背后有一张卡位，夏天穿裙子出门没有地方放手机很适用(｡･ω･｡)'
        },
        {
          cover: 'http://img1.dongshou.com/course/cover/ds_20171028_112148_588225.jpg',
          title: '文艺流苏斜跨手机包',
          author: '晏大仙',
          addTime: '2017-08-15',
          hints: 0,
          introduction: '新手第一次作品，看到好看的样式照图模仿做的，可以根据自己手机的大小制作，背后有一张卡位，夏天穿裙子出门没有地方放手机很适用(｡･ω･｡)'
        }
      ]
    }
  }
}
</script>

<style scoped>

.listArea {
  min-height: 550px;
  margin-bottom: 15px;
}

.listItem {
  border-radius: 15px;
  margin: 20px auto;
  max-width: 1000px;
  padding: 20px;
  background: #fff;
  box-shadow: 0 0 10px #d8d8d8;
  cursor: pointer;
  /*align-self: center;*/
}

.cover {
  max-width: 300px;
  height: 130px;
  border-radius: 10px;
  overflow: hidden;
  margin-right: 20px;
}

.title {
  color: #222222;
  font-size: 20px;
  text-align: left;
  margin-bottom: 8px;
}

.el-tag{
  margin-right: 10px;
  margin-bottom: 7px;
}

.intro {
  color: #222222;
  height: 36px;
  font-size: 14px;
  line-height: 18px;
  margin-bottom: 4px;
  overflow: hidden;
}

.author {
  color: #8f8f8f;
  font-size: 13px;
  vertical-align: super;
  display: inline;
}

.el-avatar {
  height: 25px;
  width: 25px;
  margin-right: 2px;
}
</style>
