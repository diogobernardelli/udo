<template>
  <p
		class="c-empty-list-helper" 
	>
    <img
      src="@/assets/images/empty-list.png"
      class="icon"
    />
    <br />
		click on the <strong>"What will UDo?"</strong> button to add a new activity
	</p>
</template>

<script>
  export default {
  }
</script>

<style scoped lang="scss">
  .c-empty-list-helper {
		display: block;
		text-align: center;
		margin: 30px auto 50px;
		font-size: 14px;
    font-style: italic;
    
    .icon {
      display: block;
      width: 50%;
      margin: 70px auto 20px;
    }
  }
</style>
