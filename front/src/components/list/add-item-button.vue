<template>
	<form
		@submit.prevent
		:class="[
			'c-add-activity',
			{
				'-is-writeable': isWriteable
			}
		]"
		v-on-clickaway="away"
	>
		<input
			type="text"
			ref="textInput"
			class="-text-input"
			placeholder="What will UDo?"
			v-on:click="handleFocus(true)"
		>

		<font-awesome-icon
			class="-submit-input"
			icon="arrow-circle-down"
			v-on:click="addNewItem"
		/>

	</form>
</template>

<script>
	import { mixin as clickaway } from 'vue-clickaway';

  export default {
		name: 'AddItemButton',
		mixins: [
			clickaway
		],
		data() {
			return {
				isWriteable: false,
			}
		},
		methods: {
			addNewItem() {
				const value = this.$refs.textInput.value
				if (value) {
					this.$emit('addItem', this.$refs.textInput.value)
					this.$refs.textInput.value = ''
				} else {
					this.$emit('errorMessage', 'Activity cannot be empty', 'error')
				}
			},
			handleFocus(status) {
				this.isWriteable = status
			},
			away: function() {
				this.handleFocus(false)
			},
		}
  }
</script>

<style scoped lang="scss">
	.c-add-activity {
		position: relative;
		display: block;
		margin: -30px auto 0;
		width: fit-content;
		background-color: #001a4a;
		border-radius: 50px;
		width: 170px;
		transition: all 300ms ease-in-out;

		.-text-input {
			display: inline-block;
			border: 0;
			color: white;
			line-height: 60px;
			background: none;
			width: 170px;
			padding: 0 30px;
			cursor: pointer;
			transition: all 300ms ease-in-out;

			&::placeholder {
				color: white;
				transition: all 300ms ease-in-out;
			}
		}

		.-submit-input {
			position: fixed;
			opacity: 0;
			z-index: -1;
			margin-top: 21px;
			margin-left: -10px;
			border: 0;
			color: #f56356;
			cursor: pointer;
			width: 18px;
			height: 18px;
		}

		&.-is-writeable {
			width: 400px;
			border-radius: 10px;
			
			.-text-input {
				width: 370px;
				padding: 0 30px;
				text-align: left;
				cursor: inherit;

				&::placeholder {
					color: rgba(255,255,255,.4);
				}
			}

			.-submit-input {
				animation: displayButton 500ms ease-in-out forwards;
			}
		}
	}

	@keyframes displayButton {
		0% {
			opacity: 0;
			z-index: -1;
		}
		50% {
			opacity: 0;
			z-index: 100;
		}
		100% {
			opacity: 1;
			z-index: 100;
		}
	}
</style>
