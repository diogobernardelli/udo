<template>
	<div
		:class="[
			'c-alert-message',
			`-${type}`,
			`is-${isVisible ? 'visible' : 'hidden'}`
		]"
		ref="alertMessageBox"
	>
		<font-awesome-icon
			:icon="icon"
			class="-icon-alert"
		/>

		{{ alertText }}

		<font-awesome-icon
			icon="times"
			class="-close-alert"
			v-on:click="closeAlert"
		/>
	</div>
</template>

<script>
	const CLOSE_TIMEOUT = 5000

  export default {
		name: 'AlertMessage',
		props: {
      text: {
        type: String,
        required: true
			},
			type: {
				type: String,
        required: true
			}
		},
		data() {
			return {
				hideTimeout: null,
				alertText: null
			}
		},
		watch: {
			text: {
				handler() {
					clearTimeout(this.hideTimeout)

					if (this.text) {
						this.alertText = this.text
						this.hideTimeout = setTimeout(() => this.closeAlert(), CLOSE_TIMEOUT)
					}
				}
			}
		},
		computed: {
			isVisible() {
				return !!this.text
			},
			icon() {
				return this.type === 'success' ? 'check' : 'exclamation-triangle'
			}
		},
		methods: {
			closeAlert() {
				this.$store.commit('closeAlert')
			}
		}
  }
</script>

<style scoped lang="scss">
	.c-alert-message {
		position: fixed;
		top: -200px;
		left: 50%;
		transform: translate(-50%, 0);
		cursor: default;
		width: 300px;
		padding: 20px 15px;
		border-radius: 2px;
		font-size: $font-size-default;
		font-weight: $weight-bold;
		color: white;
		box-shadow: 0px 4px 5px 2px rgba(0,0,0,0.2);
		transition: all 500ms cubic-bezier(1,-0.62, 0, 1.34);
		z-index: 999;

		&::after {
			content: '';
			position: absolute;
			top: calc(100% - 5px);
			left: 0;
			height: 5px;
			width: 100%;
		}

		&.-success {
			background-color: #00bd9d;
			
			&::after {
				background-color: #008a72;
			}
		}

		&.-error {
			background-color: #f18f3e;

			&::after {
				background-color: #c4722d;
			}
		}
		
		&.is-visible {
			top: 5px;

			&::after {
				animation: shrinkLoadBar 5000ms ease-in-out forwards;
			}
		}

		&.is-hidden {
			top: -200px;

			&::after {
				animation: extendLoadBar 500ms ease-in-out forwards;
			}
		}

		.-icon-alert {
			margin-right: 5px;
		}

		.-close-alert {
			cursor: pointer;
			float: right;
		}
	}

	@keyframes shrinkLoadBar {
		0% { width: 100% }
		100% { width: 0 }
	}

	@keyframes extendLoadBar {
		0% { width: 0 }
		99% { width: 0 }
		100% { width: 100% }
	}
</style>
