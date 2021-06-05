<template>
  <label class="c-switch">
		<input
			type="checkbox"
			v-on:change="$emit('change')"
			v-model="isChecked"
		>
		<span class="slider"></span>
	</label>
</template>

<script>
	export default {
		name: 'ToogleSwitch',
		data() {
			return {
				isChecked: this.checked
			}
		},
		props: {
			checked: {
				type: Boolean,
				required: true
			}
		},
		watch: {
			checked() {
				this.isChecked = this.checked
			}
		}
	}
</script>

<style scoped lang="scss">
	.c-switch {
		top: 1px;
		margin-left: 4px;
	}
</style>