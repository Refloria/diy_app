<template>
  <el-menu ref="menu"
    :router="true" :default-openeds="['0']">
    <label v-for="(item,i) in navList" :key="i">
      <el-menu-item v-if="item.children==null" :key="i" :index="item.url">
        <i :class="item.icon"></i>
        <span slot="title">{{item.title}}</span>
      </el-menu-item>
      <el-submenu v-if="item.children" :key="i" :index="i.toString()">
        <template #title>
          <i :class="item.icon"></i>
          <span slot="title">{{item.title}}</span>
        </template>
        <label v-for="(subItem,j) in item.children" :key="j">
          <el-menu-item v-if="subItem.children==null" :key="j" :index="subItem.url">
            <i :class="subItem.icon"></i>
            <span slot="title">{{subItem.title}}</span>
          </el-menu-item>
        </label>
      </el-submenu>
    </label>
  </el-menu>
</template>

<script>
export default {
  name: 'ClassMenu',
  // props: { navList: Array },
  data () {
    return {
      navList: [
        {
          // icon: 'el-icon-document',
          title: '缝绣作品管理',
          url: '0',
          children: [
            {
              title: '推荐作品',
              url: '/articleRecommend'
            },
            {
              title: '已上架作品',
              url: '/articleOnShelf'
            },
            {
              title: '待审核作品',
              url: '/articleWaitChecking'
            }
          ]
        },
        {
          title: '意见反馈',
          url: '/index'
        }
      ]
    }
  }
}
</script>

<style scoped>

.el-menu-item.is-active{
  border-right: 2px solid #409EFF;
}

</style>
