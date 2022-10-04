import Vue from 'vue'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui'
// import axios from 'axios'
import 'element-ui/lib/theme-chalk/index.css'

import VueQuillEditor from 'vue-quill-editor'
import http from '@/utils/HttpRequest'

Vue.use(VueQuillEditor)

// 全局注册，之后可在其他组件中通过 this.$axios 发送数据
// Vue.prototype.$axios = axios
Vue.prototype.$axios = http

Vue.config.productionTip = false
Vue.use(ElementUI)

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
