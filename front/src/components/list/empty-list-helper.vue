<template>
  <div
		class="c-empty-list-helper" 
	>
    <img
      src="@/assets/images/empty-list.png"
      class="icon"
    />
    <br />
    <p v-html="$t('helpers.create_first_item')"></p>
	</div>
</template>

<script>
  export default {
    name: "EmptyListHelper",
  }
</script>

<style scoped lang="scss">
  .c-empty-list-helper {
		display: block;
		text-align: center;
		margin: 30px auto 50px;
		font-size: $font-size-big;
    font-style: italic;

    p {
      margin: 0;
    }
    
    .icon {
      display: block;
      width: 50%;
      margin: 70px auto 20px;
    }
  }

  @media only screen and (max-width: 600px) {
    .c-empty-list-helper {
      p {
        max-width: 60%;
        margin: 0 auto;
      }
    }
  }
</style>
