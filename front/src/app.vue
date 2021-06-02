<template>
  <div id="app">
    <vContainer>
      <RouterView />
    </vContainer>
  </div>
</template>

<script>
  import '@/assets/style/application.scss'
  
  import vContainer from '@/components/container.vue'

  export default {
    components: {
      vContainer
    }
  }
</script>

<style lang="scss">
  
</style>
