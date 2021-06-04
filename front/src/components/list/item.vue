<template>
  <li class="c-item">
		<form @submit.prevent>
			<div class="-content" v-on-clickaway="away">
				<div class="-item-label">
					<input
						type="checkbox"
						class="c-hidden-box"
						v-bind:title="id"
						v-bind:id="id"
						v-on:change="$emit('change', id, isChecked)"
						v-model="isChecked"
						:disabled="isWritable"
					/>

					<label :for="id" class="check-label">
						<span class="check-label-box"></span>
						<span v-if="!isWritable" class="check-label-text">
							{{title}}
						</span>

						<input
							v-else
							type="text"
							class="-text-input"
							ref="itemInput"
							:placeholder="$t('list.add_item_button')"
							maxlength="50"
							v-model="writableTitle"
						>
					</label>
				</div>

				<div class="-action-buttons">
					<div v-if="!isWritable">
						<button
							v-if="!isChecked"
							class="o-icon-button"
							v-on:click="enableWriteMode"
						>
							<font-awesome-icon icon="pencil-alt" />
						</button>

						<button
							v-if="!isChecked"
							class="o-icon-button"
							v-on:click="$emit('delete', id)"
						>
							<font-awesome-icon icon="trash-alt" />
						</button>
					</div>

					<div v-else>
						<button
							type="submit"
							class="o-icon-button"
							v-on:click="updateItem"
						>
							<font-awesome-icon icon="save" />
						</button>

							<button
								class="o-icon-button"
								v-on:click="isWritable=false"
							>
								<font-awesome-icon icon="times" />
							</button>
					</div>
				</div>
			</div>
		</form>
	</li>
</template>

<script>
import { mixin as clickaway } from 'vue-clickaway';

export default {
	name: "Item",
	props: {
		title: String,
		order: Number,
		id: Number,
		checked: {
			type: Boolean,
			default: false
		},
		isDragging: {
			type: Boolean,
			default: false
		}
	},
	mixins: [
		clickaway
	],
	data() {
		return {
			isChecked: this.checked,
			isWritable: false,
			writableTitle: this.title
		}
	},
	watch: {
		checked() {
			this.isChecked = this.checked
			if (this.isChecked) {
				this.disableWriteMode()
			}
		},
		isWritable: {
			handler() {
				if (this.isWritable) {
					this.$nextTick(() => {
						this.focusInput();
					});
				}
			},
			immediate: true
		},
		title: {
			handler() {
				if (this.title) {
					this.writableTitle = this.title
				}
			},
			immediate: true
		},
		isDragging: {
			handler() {
				this.disableWriteMode()
			},
			immediate: true
		}
	},
	methods: {
		enableWriteMode() {
			this.isWritable = true
		},
		focusInput() {
      this.$refs.itemInput.focus();
    },
		updateItem() {
			this.$emit('edit', this.id, this.writableTitle)
			this.disableWriteMode()
		},
		away: function() {
			this.disableWriteMode()
		},
		disableWriteMode() {
			this.isWritable = false
			this.writableTitle = this.title
		}
	}
};
</script>

<style scoped lang="scss">
	.c-item {
		position: relative;
		cursor: move;
		list-style: none;
		padding: 30px;
		background-color: $color-white;
		margin-bottom: 1px;
		overflow: hidden;
		border-bottom: 1px solid $border-color;

		&.ghost {
			opacity: 1;
			background: $color-accent;
			color: $color-white;

			.c-hidden-box:checked + .check-label {
				.check-label-text {
					&:after {
						background-color: $color-white;
					}
					color: $color-white;
				}
			}
		}

		&:last-child {
			border-bottom: 0;
		}

		.-content {
			position: relative;
			z-index: 1;
		}

		.is-completed {
			text-decoration: line-through;
			color: $color-accent;
		}

		.-item-label {
			display: inline-block;
			width: calc(100% - 60px)
		}

		.-action-buttons {
			float: right;
			width: 60px;
			opacity: 1;
			margin-bottom: -100%;

			.o-icon-button {
				color: $color-accent;
			}
		}

		&:hover {
			&::after {
				left: 0;
			}
		}

		.-text-input {
			border: 0;
			padding: 0;
			font-weight: $weight-bold;
		}
	}

	@media only screen and (max-width: 600px) {
    .c-item {
			padding: 15px 10px;
			font-size: $font-size-default;
    }
  }
</style>
