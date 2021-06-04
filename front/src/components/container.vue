<template>
  <div class="c-container">
    <slot />
  </div>
</template>

<script>
  export default {
    props: {
      gutter: {
        type: Boolean,
        default: true
      }
    }
  }
</script>

<style scoped lang="scss">
  // @import '@/assets/style/_colors.scss';

  .c-container {
    max-width: 600px;
    margin: 50px auto;
    box-shadow: 0px 0px 15px 15px rgba(0,0,0,0.1);
    border-radius: 5px;
    background-color: $color-white;
    overflow: hidden;
  }

  @media only screen and (max-width: 600px) {
    .c-container {
      max-width: 96%;
    }
  }
</style>
