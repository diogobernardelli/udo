<template>
  <header class="c-header clearfix">
    <div class="flex-1 flex items-center">
      <img
        src="@/assets/images/logo.png"
        class="logo"
      />
      <div class="account">
        <span v-html="$t('header.greetings', { user: username })"></span>
        <a
          class="logout"
          @click.prevent="signUserOut"
        >
          {{ $t('header.sign_out') }}
        </a>
        <br />
        {{ $t('header.notifications') }} <vToogle
          @change="toogleNotificationState"
          v-bind:checked="alertState"
        />
      </div>
    </div>
  </header>
</template>

<script>
  import vToogle from '@/components/header/toogle.vue'
  import { displaySuccessAlert } from '@/tools/display-alert-message'
  import {
    signOut,
    checkSignedOut,
    errorAlert
  } from '@/tools/session'

  const SETTINGS_ENDPOINT = '/api/v1/settings'

  export default {
    name: 'Header',
    created () {
      checkSignedOut()
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
      signUserOut () {
        signOut()
      },
      toogleNotificationState() {
        this.$http.secured.post(`${SETTINGS_ENDPOINT}/toogle_alert`)
          .then(response => {
            localStorage.alerts = response.data.item.alerts
            displaySuccessAlert(response.data.message)
          })
          .catch(error => {
            errorAlert(error)
          })
      }
    }
  }
</script>

<style scoped lang="scss">
	.c-header {
    padding: 30px;
    font-size: $font-size-big;
    border-bottom: 1px solid $border-color;
    box-shadow: 0px 5px 25px 3px $shadow-box-color;

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
