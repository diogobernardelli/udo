<template>
  <div class="logo">
		<img src="@/assets/images/logo.png"/>
		<p v-html="$t('helpers.welcome_subtitle')"></p>
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
			font-size: $font-size-title;
			margin-top: 10px;
		}
	}
</style>
