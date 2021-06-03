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
			placeholder="What will UDo?"
			maxlength="50"
			v-model="activity"
			v-on:click="handleFocus(true)"
		>

		<button
			type="submit"
			class="-submit-input"
			v-on:click="addNewItem"
		>
			<font-awesome-icon icon="arrow-circle-down" />
		</button>
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
					this.$store.commit('displayAlert', {message: 'Activity cannot be empty', status: 'error'});
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
		background-color: #001a4a;
		border-radius: 50px;
		width: 170px;
		transition: all 300ms ease-in-out;
		border: 3px solid #001a4a;

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
			color: white;
			font-weight: 600;
			cursor: pointer;
			transition: all 300ms ease-in-out;

			&::placeholder {
				color: white;
				transition: all 300ms ease-in-out;
			}
		}

		.-submit-input {
			position: absolute;
			opacity: 0;
			z-index: -1;
			margin-top: 20px;
			margin-left: -20px;
			border: 0;
			color: #f56356;
			background: none;
			cursor: pointer;
			width: 18px;
			height: 18px;
		}

		&.-is-writeable {
			width: 400px;
			border-color: #f56356;
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
