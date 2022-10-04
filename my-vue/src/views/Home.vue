<template>
  <div>
    <nav-menu></nav-menu>
    <el-container>
      <el-aside style="height: 500px;margin-top: 20px">
        <switch></switch>
        <aside-menu></aside-menu>
      </el-aside>
      <el-main>
        <router-view class="views"/>
        <!--<books></books>-->
      </el-main>
    </el-container>
  </div>
</template>

<script>
// @ is an alias to /src
import NavMenu from '@/components/NavMenu'
import AsideMenu from '@/components/AsideMenu'

export default {
  name: 'Home',
  components: {
    NavMenu,
    AsideMenu
  }
}
</script>

<style scoped>
/*.views{*/
/*  max-width: 1200px;*/
/*  margin: 0 auto;*/
/*}*/
</style>
