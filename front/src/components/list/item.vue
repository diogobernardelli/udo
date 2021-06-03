<template>
  <li class="c-item">
		<div class="l-content">
			<div class="l-item-label">
				<input
					type="checkbox"
					class="c-hidden-box"
					v-bind:title="title"
					v-bind:id="title"
					v-on:change="$emit('change', id)"
					v-model="isChecked"
				/>

				<label :for="title" class="check-label">
					<span class="check-label-box"></span>
					<span class="check-label-text">
						{{title}}
					</span>
				</label>
			</div>

			<div class="l-action-buttons">
				<button
					v-if="!isChecked"
					class="o-icon-button"
					v-on:click="$emit('edit', id)"
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
		</div>
	</li>
</template>

<script>
export default {
	name: "Item",
	props: {
		title: String,
		order: Number,
		id: Number,
		checked: {
			type: Boolean,
			default: false
		}
	},
	data() {
		return {
			isChecked: this.checked
		}
	},
	watch: {
		checked() {
			this.isChecked = this.checked
			if (this.isChecked) this.$store.commit('displayAlert', {message: 'Activity successfully completed', status: 'success'}); 
		}
	},
	methods: {
		check(e) {
			console.log(e)
		}
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
	}
</style>
