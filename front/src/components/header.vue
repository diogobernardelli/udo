<template>
  <header class="c-header clearfix">
    <div class="flex-1 flex items-center">
      <img
        src="@/assets/images/logo.png"
        class="logo"
      />
      <div class="account">
        <span>Hi, {{ email }}</span><br />
        <a
          v-if="signedIn()"
          class="logout"
          href="javascript:;"
          icon="sign-out-alt"
          @click.prevent="signOut"
        >
          Log Out
        </a>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  name: 'Header',
  created () {
    this.signedIn()
	},
	data() {
		return {
			email: localStorage.email
		}
	},
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(() => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
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
        cursor: pointer;
      }
    }
	}
</style>