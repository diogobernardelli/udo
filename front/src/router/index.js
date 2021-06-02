import Vue from 'vue'
import VueRouter from 'vue-router'
import vLogin from '@/pages/login.vue'
import vSignup from '@/pages/signup.vue'
import vList from '@/pages/list.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Login',
    component: vLogin
  },
  {
    path: '/signup',
    name: 'Signup',
    component: vSignup
  },
  {
    path: '/list',
    name: 'List',
    component: vList
  }
]

const router = new VueRouter({
  routes
})

export default router
