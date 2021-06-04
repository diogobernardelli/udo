<template>
  <div>
    <vAlertMessage
      :text="getAlertMessage.message"
      :type="getAlertMessage.status"
    />

    <vLogo />

    <vForm />

    <div class="c-sign-in-up">
      Already have a UDo account?<br />
			<router-link to="/">SIGN IN</router-link>
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
    return 'Sign up'
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
