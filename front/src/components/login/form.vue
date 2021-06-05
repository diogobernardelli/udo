<template>
  <div>
    <form @submit.prevent="signin">
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
      
      <button class="l-button" type="submit">
        <font-awesome-icon v-if="isLoading" class="rotate" icon="circle-notch" />
        <span v-else>{{ $t('forms.sign_in') }}</span>
      </button>
    </form>
  </div>
</template>

<script>
  import {
    signinSuccessful,
    signinFailed,
    checkSignedIn
  } from '@/tools/session'

  export default {
    data() {
      return {
        isLoading: false,
        username: '',
        password: ''
      }
    },
    created() {
      checkSignedIn()
    },
    updated() {
      checkSignedIn()
    },
    methods: {
      signin() {
        this.isLoading = true  
        this.$http.plain.post('/signin', { username: this.username, password: this.password })
          .then(response =>  signinSuccessful(response))
          .catch(error => signinFailed(error))
          .finally(() => this.isLoading = false)
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
