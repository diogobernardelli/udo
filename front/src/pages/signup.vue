<template>
  <div>
    <vAlertMessage
      :text="getAlertMessage.message"
      :type="getAlertMessage.status"
    />

    <vLogo />

    <vForm />

    <div class="c-sign-in-up">
      {{ $t('forms.action_sign_in') }}<br />
			<router-link class="uppercase" to="/">{{ $t('forms.sign_in') }}</router-link>
    </div>
  </div>
</template>

<script>
import vLogo from '@/components/logo.vue'
import vForm from '@/components/signup/form.vue'
import vAlertMessage from '@/components/alert-message.vue'

export default {
  name: 'Signup',
  pageTitle() {
    return this.$t('forms.sign_up')
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
