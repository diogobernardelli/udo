<template>
  <div>
    <form @submit.prevent="signin">
      <div class="form-group">
        <input
          type="text"
          class="form-field"
          v-model="username"
          placeholder="Username"
          name="username"
          id='username'
          required
        />
        <label for="username" class="form-label">
          Username
        </label>
      </div>

      <div class="form-group">
        <input
          type="password"
          class="form-field"
          v-model="password"
          placeholder="Password"
          name="password"
          id='password'
          required
        />
        <label for="password" class="form-label">
          Password
        </label>
      </div>
      
      <button class="o-button" type="submit">
        <font-awesome-icon v-if="isLoading" class="rotate" icon="circle-notch" />
        <span v-else>Sign In</span>
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
        password: ''
      }
    },
    created () {
      this.checkSignedIn()
    },
    updated () {
      this.checkSignedIn()
    },
    methods: {
      signin () {
        this.isLoading = true  
        this.$http.plain.post('/signin', { username: this.username, password: this.password })
          .then(response => {
            return this.signinSuccessful(response)
          })
          .catch(error => this.signinFailed(error))
      },
      signinSuccessful (response) {
        if (!response.data.csrf) {
          this.signinFailed(response)
          return
        }
        localStorage.username = response.data.username
        localStorage.csrf = response.data.csrf
        localStorage.signedIn = true
        this.$router.replace('/list')
      },
      signinFailed (error) {
        this.isLoading = false
        const errorMessage = (error.response && error.response.data && error.response.data.error) || error
        displayErrorAlert(errorMessage)
        delete localStorage.csrf
        delete localStorage.signedIn
      },
      checkSignedIn () {
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

    .o-button {
      width: 100%;
    }
  }
</style>