<template>
  <div>
    <vAlertMessage
      :text="getAlertMessage.message"
      :type="getAlertMessage.status"
    />

    <vLogo />

    <vForm />

    <div class="c-sign-in-up">
      {{ $t('forms.action_sign_up') }}<br />
      <router-link class="uppercase" to="/signup">{{ $t('forms.sign_up') }}</router-link>
    </div>
  </div>
</template>

<script>
  import vLogo from '@/components/logo.vue'
  import vForm from '@/components/login/form.vue'
  import vAlertMessage from '@/components/alert-message.vue'

  export default {
    name: 'Login',
    pageTitle() {
      return this.$t('forms.sign_in')
    },
    components: {
      vLogo,
      vForm,
      vAlertMessage
    },
    computed: {
      getAlertMessage() {
        return {
          message: this.$store.state.alertText,
          status: this.$store.state.alertType
        }
      }
    }
  }
</script>

<style scoped lang="scss">

</style>
