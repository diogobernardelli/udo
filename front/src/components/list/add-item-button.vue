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
			class="-text-input"
			:placeholder="$t('list.add_item_button')"
			maxlength="50"
			v-model="activity"
			v-on:click="handleFocus(true)"
		>

		<button
			v-if="!isAddingItem"
			type="submit"
			class="-submit-input"
			v-on:click="addNewItem"
		>
			<font-awesome-icon icon="arrow-circle-down" />
		</button>

		<font-awesome-icon v-else class="-adding-item-loader rotate" icon="circle-notch" />
	</form>
</template>

<script>
	import { mixin as clickaway } from 'vue-clickaway';
	import { displayErrorAlert} from '@/tools/display-alert-message'

  export default {
		name: 'AddItemButton',
		mixins: [
			clickaway
		],
		props: {
			isAddingItem: {
				type: Boolean,
				default: false
			}
		},
		data() {
			return {
				isWriteable: false,
				activity: ''
			}
		},
		methods: {
			addNewItem() {
				const value = this.activity
				if (value) {
					this.$emit('addItem', this.activity)
					this.activity = ''
				} else {
					displayErrorAlert(this.$t('errors.blank_item'))
				}
			},
			handleFocus(status) {
				this.activity = ''
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
		background-color: $color-secondary;
		border-radius: 50px;
		width: 170px;
		transition: all 300ms ease-in-out;
		border: 3px solid $color-secondary;

		&:not(.-is-writeable):hover {
			padding: 0 20px;
			width: 210px;
		}

		.-text-input {
			display: inline-block;
			border: 0;
			line-height: 60px;
			background: none;
			width: 170px;
			padding: 0 30px;
			color: $color-white;
			font-weight: $weight-bold;
			cursor: pointer;
			transition: all 300ms ease-in-out;

			&::placeholder {
				color: $color-white;
				transition: all 300ms ease-in-out;
			}
		}

		.-submit-input,
		.-adding-item-loader {
			position: absolute;
			opacity: 0;
			z-index: -1;
			margin-top: 20px;
			margin-left: -20px;
			border: 0;
			color: $color-accent;
			background: none;
			cursor: pointer;
			width: 18px;
			height: 18px;
		}

		&.-is-writeable {
			width: 400px;
			border-color: $color-accent;
			border-radius: 10px;
			
			.-text-input {
				width: 370px;
				padding: 0 30px;
				text-align: left;
				cursor: inherit;

				&::placeholder {
					color: $color-placeholder;
				}
			}

			.-submit-input {
				animation: displayButton 500ms ease-in-out forwards;
			}

			.-adding-item-loader {
				opacity: 1;
				z-index: 100;
				top: 1px;
				margin-left: -15px;
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

	@media only screen and (max-width: 600px) {
    .c-add-activity {
			margin: -20px auto 0;
			width: 150px;

			.-text-input {
				line-height: 40px;
				font-size: $font-size-default;
				width: 150px;
			}

			.-submit-input,
			.-adding-item-loader {
				margin-top: 11px;
				margin-left: -10px;
			}

			&.-is-writeable {
				width: 90%;

				.-text-input {
					width: 90%;
				}

				.-adding-item-loader {
					margin-left: -5px;
				}
			}
		}
  }
</style>
