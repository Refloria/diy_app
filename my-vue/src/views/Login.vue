<template>
  <body id="poster">
  <el-form class="login_container" label-position="left" label-width="60px">
    <h3 class="login_title">系统登录</h3>
    <el-form-item label="用户名">
      <el-input type="text" v-model="loginForm.username" placeholder="请输入用户名"></el-input>
    </el-form-item>
    <el-form-item label="密码">
      <el-input type="password" v-model="loginForm.password" placeholder="请输入密码"></el-input>
    </el-form-item>
    <el-button class="login_button" type="primary" v-on:click="login">登录</el-button>
  </el-form>
  </body>
</template>

<script>
export default {
  name: 'Login',
  data () {
    return {
      loginForm: {
        username: '',
        password: ''
      },
      responseResult: []
    }
  },
  methods: {
    login () {
      this.$axios
        .post('/api/login', {
          username: this.loginForm.username,
          password: this.loginForm.password
        })
        .then(successResponse => {
          // var loginSuccess = false
          if (successResponse.data.code === 200) {
            // const authorities = successResponse.data.data.authorities
            // for (var x in authorities) {
            //   if (authorities[x].authority === 'admin') {
            //     loginSuccess = true
            //     break
            //   }
            // }
            // if (loginSuccess) {
            sessionStorage.setItem('token', successResponse.data.data.token)
            this.$router.replace({ path: '/index' })
            // } else {
            //   this.$router.replace('/403')
            // }
          } else {
            this.$message.error(successResponse.data.message)
          }
        })
        .catch(failResponse => {
        })
    }
  },
  mounted () {
    sessionStorage.removeItem('token')
  }
}
</script>

<style scoped>
#poster {
  background: url("../assets/login_background.jpg") no-repeat center;
  height: 100%;
  width: 100%;
  background-size: cover;
  position: fixed;
  display: flex;
}

body {
  margin: 0;
}

.login_container {
  border-radius: 15px;
  margin: 90px auto;
  width: 350px;
  padding: 35px 35px 30px 35px;
  background: #fff;
  box-shadow: 0 0 20px #8f8f8f;
  align-self: center;
}

.login_title {
  margin: 0 auto 30px auto;
  text-align: center;
  color: #505458;
}

.login_button {
  width: 100%;
  margin-top: 10px;
}
</style>
