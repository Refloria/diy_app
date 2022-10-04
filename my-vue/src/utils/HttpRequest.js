import axios from 'axios'
import router from '@/router'

const http = axios.create({
  headers: {
    'content-type': 'application/json'
  }
})

http.interceptors.request.use(
  config => {
    const token = sessionStorage.getItem('token')
    if (token) {
      config.headers.authorization = token
    }
    return config
  },
  err => {
    return Promise.reject(err)
  }
)

http.interceptors.response.use(
  response => {
    switch (response.data.code) {
      case 401: {
        router.replace('/login')
        break
      }
      case 403: {
        router.replace('/403')
        break
      }
    }
    if (response.headers['refresh-token']) {
      sessionStorage.setItem('token', response.headers['refresh-token'])
    }
    return response
  },
  error => {
    return Promise.reject(error.response.status)
  }
)

export default http
