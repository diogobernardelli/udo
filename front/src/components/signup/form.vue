<template>
  <div>
    <form @submit.prevent="signup">
      <div class="c-form-group">
        <input
          type="text"
          class="-form-field"
          v-model="username"
          :placeholder="$t('forms.username')"
          name="username"
          id='username'
          required
        />
        <label for="username" class="form-label">
          {{ $t('forms.username') }}
        </label>
      </div>

			<div class="c-form-group">
        <input
          type="password"
          class="-form-field"
          v-model="password"
          :placeholder="$t('forms.password')"
          name="password"
          id='password'
          required
        />
        <label for="password" class="form-label">
          {{ $t('forms.password') }}
        </label>
      </div>

			<div class="c-form-group">
        <input
          type="password"
          class="-form-field"
          v-model="password_confirmation"
          :placeholder="$t('forms.password_confirmation')"
          name="password_confirmation"
          id='password_confirmation'
          required
        />
        <label for="password_confirmation" class="form-label">
          {{ $t('forms.password_confirmation') }}
        </label>
      </div>
      
      <button class="l-button" type="submit">
        <font-awesome-icon v-if="isLoading" class="rotate" icon="circle-notch" />
        <span v-else>{{ $t('forms.sign_up') }}</span>
      </button>
    </form>
  </div>
</template>

<script>
  import { displayErrorAlert} from '@/tools/display-alert-message'

  export default {
		data () {
			return {
				isLoading: false,
				username: '',
				password: '',
				password_confirmation: '',
			}
		},
    created () {
			this.checkedSignedIn()
		},
		updated () {
			this.checkedSignedIn()
		},
    methods: {
			signup () {
				this.isLoading = true
				this.$http.plain.post('/signup', { username: this.username, password: this.password, password_confirmation: this.password_confirmation })
					.then(response => this.signupSuccessful(response))
					.catch(error => this.signupFailed(error))
			},
			signupSuccessful (response) {
				if (!response.data.csrf) {
					this.signupFailed(response)
					return
				}

				localStorage.username = response.data.username
				localStorage.csrf = response.data.csrf
				localStorage.signedIn = true
				localStorage.alerts = response.data.alerts
				this.$router.replace('/list')
			},
			signupFailed (error) {
				this.isLoading = false
				const errorMessage = (error.response && error.response.data && error.response.data.error) || this.$t('errors.default')
				displayErrorAlert(errorMessage)
				delete localStorage.csrf
        delete localStorage.signedIn
        delete localStorage.alerts
			},
			checkedSignedIn () {
				if (localStorage.signedIn) {
					this.$router.replace('/list')
				}
			}
		}
  }
</script>

<style scoped lang="scss">
  form {
    display: block;
    width: 60%;
    margin: 30px auto;

    .l-button {
      width: 100%;
    }
  }
</style>
