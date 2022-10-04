<template>
  <el-menu
    :default-active="'/index'"
    router
    mode="horizontal"
    style="min-width: 610px">
    <span class="nav-title">后台管理系统</span>
    <el-menu-item v-for="(item,i) in navList" :key="i" :index="item.name">
      {{ item.navItem }}
    </el-menu-item>
    <el-menu-item style="float: right" @click="loginButtonClicked">
      <span slot="title" class="login-button">{{this.loginButtonText}}</span>
    </el-menu-item>
  </el-menu>
</template>

<script>
import router from '@/router'

export default {
  name: 'NavMenu',
  mounted () {
    if (sessionStorage.getItem('token') === null) {
      this.loginButtonText = '登录'
    } else {
      this.loginButtonText = '登出'
    }
  },
  data () {
    return {
      loginButtonText: '登录',
      navList: []
      //   { name: '/index', navItem: '首页' },
      //   { name: '/article', navItem: '文章' },
      //   { name: '/recommend', navItem: '探索广场' },
      //   { name: '/personal', navItem: '个人中心' },
      //   { name: '/articleEdit', navItem: '发布' }
      // ]
    }
  },
  methods: {
    loginButtonClicked () {
      if (this.loginButtonText === '登出') {
        sessionStorage.removeItem('token')
        sessionStorage.removeItem('refreshToken')
      }
      router.replace('/login')
    }
  }
}
</script>

<style scoped>
span {
  pointer-events: none;
}

.nav-title {
  float: left;
  padding: 20px 30px;
  font-size: 20px;
  font-weight: bold
}

.login-button {
  margin: auto 10px;
}
</style>
