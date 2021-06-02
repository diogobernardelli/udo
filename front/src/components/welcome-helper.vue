<template>
  <p
		class="c-helper" 
	>
    are you new around here?<br />
		click on the button above do add a new activity
	</p>
</template>

<script>
  export default {
    props: {
      text: {
        type: String,
        default: ''
      }
    }
  }
</script>

<style scoped lang="scss">
  .c-helper {
		display: block;
		text-align: center;
		margin: 30px auto 50px;
		font-size: 13px;
		font-style: italic;
  }
</style>
