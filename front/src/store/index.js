import Vue from 'vue'
import Vuex from 'vuex'
// import axios from 'axios'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    alertText: '',
    alertType: ''
  },
  mutations: {
    displayAlert(
      state,
      obj={
        message: '',
        status: ''
      }
    ){
      this.commit('closeAlert');
      setTimeout(() => {
        state.alertText = obj.message
        state.alertType = obj.status
      }, 300)
    },
    closeAlert(state) {
      state.alertText = ''
    }
  },
  actions: {},
  modules: {}
})

export default store;
