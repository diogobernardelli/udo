<template>
  <div class="logo">
		<img src="@/assets/images/logo.png"/>
		<p>
			Create tasks for <strong>You</strong> to <strong>Do</strong>
		</p>
	</div>
</template>

<script>
export default {
	name: 'Header'
}
</script>

<style scoped lang="scss">
	.logo {
		text-align: center;
		padding-top: 40px;
		
		img {
			display: block;
			height: 100px;
			margin: 0 auto;
		}

		p {
			font-size: 16px;
			margin-top: 10px;
		}
	}
</style>