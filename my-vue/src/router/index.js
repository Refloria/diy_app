import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'

import AppIndex from '@/views/AppIndex'
import Login from '@/views/Login'
import ArticleOnShelf from '@/views/ArticleOnShelf'
import ArticleDetail from '@/views/ArticleDetail'
import ArticleWaitChecking from '@/views/ArticleWaitChecking'
import NoAuthority from '@/views/NoAuthority'
import ArticleRecommend from '@/views/ArticleRecommend'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
    redirect: '/index',
    children: [
      {
        path: 'index',
        name: 'AppIndex',
        component: AppIndex,
        meta: {
          requireAuth: true
        }
      },
      {
        path: 'articleOnShelf',
        name: 'ArticleOnShelf',
        component: ArticleOnShelf,
        meta: {
          requireAuth: true
        }
      },
      {
        path: 'articleWaitChecking',
        name: 'ArticleWaitChecking',
        component: ArticleWaitChecking,
        meta: {
          requireAuth: true
        }
      },
      {
        path: 'articleRecommend',
        name: 'ArticleRecommend',
        component: ArticleRecommend,
        meta: {
          requireAuth: true
        }
      },
      {
        path: '403',
        name: 'NoAuthority',
        component: NoAuthority
      }
    ]
  },
  {
    path: '/login',
    name: 'Login',
    component: Login,
    meta: {
      requireAuth: false
    }
  },
  {
    path: '/articleDetail',
    name: 'ArticleDetail',
    component: ArticleDetail,
    meta: {
      requireAuth: true
    }
  }
  // {
  //   path: '/about',
  //   name: 'About',
  //   // route level code-splitting
  //   // this generates a separate chunk (about.[hash].js) for this route
  //   // which is lazy-loaded when the route is visited.
  //   component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  // }
]

const router = new VueRouter({
  mode: 'history',
  routes
})

router.beforeEach((to, from, next) => {
  if (to.meta.requireAuth) {
    if (sessionStorage.getItem('token')) {
      next()
    } else {
      next({
        path: 'login'
      })
    }
  } else {
    next()
  }
})

export default router
