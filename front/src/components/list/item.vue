<template>
  <li class="c-item">
		<form @submit.prevent>
			<div class="l-content">
				<div class="l-item-label">
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
							placeholder="What will UDo?"
							maxlength="50"
							v-on-clickaway="away"
							v-model="writableTitle"
						>
					</label>
				</div>

				<div class="l-action-buttons">
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
							v-if="!isChecked"
							type="submit"
							class="o-icon-button"
							v-on:click="updateItem"
						>
							<font-awesome-icon icon="save" />
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
			if (this.isChecked) this.isWritable = false
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
				this.isWritable = false
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
			this.isWritable = false
		},
		away: function() {
			this.isWritable = false
		},
	}
};
</script>

<style scoped lang="scss">
	.c-item {
		position: relative;
		cursor: move;
		list-style: none;
		padding: 30px 30px;
		background-color: #fff;
		margin-bottom: 1px;
		overflow: hidden;
		border-bottom: 1px solid rgba(0,0,0,.06);

		&.ghost {
			opacity: 1;
			background: #f56356;
			color: white;

			.c-hidden-box:checked + .check-label {
				.check-label-text {
					&:after {
						background-color: #fff;
					}
					color: white;
				}
			}
		}

		&:last-child {
			border-bottom: 0;
		}

		.l-content {
			position: relative;
			z-index: 1;
		}

		&::before {
			content: '';
			position: absolute;
			height: 100%;
			width: 100%;
			top: 0;
			left: -100%;
			background: rgba(255,255,255,.2);
			border-radius: 50px;
			z-index: 0;
		}

		.is-completed {
			text-decoration: line-through;
			color: #f56356;
		}

		.l-item-label {
			display: inline-block;
			width: calc(100% - 60px)
		}

		.l-action-buttons {
			float: right;
			width: 60px;
			opacity: 1;
			margin-bottom: -100%;

			.o-icon-button {
				color: #f56356;
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
			font-weight: bold;
		}
	}
</style>
