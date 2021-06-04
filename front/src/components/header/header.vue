<template>
  <header class="c-header clearfix">
    <div class="flex-1 flex items-center">
      <img
        src="@/assets/images/logo.png"
        class="logo"
      />
      <div class="account">
        <span>Hi, <strong>{{ username }}</strong>.</span>
        <a
          class="logout"
          @click.prevent="signOut"
        >
          Log Out
        </a>
        <br />
        Notifications <vToogle
          @change="toogleNotificationState"
          v-bind:checked="alertState"
        />
      </div>
    </div>
  </header>
</template>

<script>
import vToogle from '@/components/header/toogle.vue'
import { displaySuccessAlert, displayErrorAlert} from '@/tools/display-alert-message'

const SETTINGS_ENDPOINT = '/api/v1/settings'

export default {
  name: 'Header',
  created () {
    this.checkedSignedIn()
	},
	data() {
		return {
			username: localStorage.username
		}
  },
  components: {
    vToogle,
  },
  computed: {
    alertState() {
      return localStorage.alerts == 'true'
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(() => {
          delete localStorage.csrf
          delete localStorage.signedIn
          delete localStorage.alerts
          this.$router.replace('/')
        })
        .catch(() => displayErrorAlert('Cannot sign out'))
    },
    toogleNotificationState() {
      this.$http.secured.post(`${SETTINGS_ENDPOINT}/toogle_alert`)
        .then(response => {
          localStorage.alerts = response.data.item.alerts
          displaySuccessAlert(response.data.message)
        })
        .catch(error => {
          const errorMessage = (error.response && error.response.data && error.response.data.error) || error
          displayErrorAlert(errorMessage)
        })
    },
    checkedSignedIn () {
      if (!localStorage.signedIn) {
        this.$router.replace('/')
      }
    }
  }
}
</script>

<style scoped lang="scss">
	.c-header {
    padding: 30px;
    font-size: 14px;
    border-bottom: 1px solid rgba(0,0,0,.06);
    box-shadow: 0px 5px 25px 3px rgba(0,0,0,0.10);

    .logo {
      height: 40px;
    }

    .account {
      text-align: right;
      float: right;

      .logout {
        display: inline-block;
        cursor: pointer;
        margin: 0 0 5px 3px;
      }
    }
	}
</style>