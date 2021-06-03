import Vue from 'vue'
import App from './app.vue'
import router from './router'
import store from './store'
import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from './backend/axios'
import pageTitle from '@/tools/page-title'
import { library } from '@fortawesome/fontawesome-svg-core'
import {
  faTrashAlt,
  faPencilAlt,
  faCheck,
  faTimes,
  faExclamationTriangle,
  faArrowCircleDown,
  faCircleNotch
} from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

library.add(
  faTrashAlt,
  faPencilAlt,
  faCheck,
  faTimes,
  faExclamationTriangle,
  faArrowCircleDown,
  faCircleNotch
)

Vue.mixin(pageTitle)

Vue.component('font-awesome-icon', FontAwesomeIcon)

Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})

Vue.config.productionTip = false

new Vue({
  router,
  store,
  securedAxiosInstance,
  plainAxiosInstance,
  render: h => h(App)
}).$mount('#app')
