<template>
  <div>
    <vAlertMessage
      :text="getAlertMessage.message"
      :type="getAlertMessage.status"
    />

    <vHeader />
    
    <vAddItemButton
      @addItem="addItem"
      :is-adding-item="isAddingItem"
    />

    <font-awesome-icon
      v-if="isFetchingItems"
      class="rotate"
      icon="circle-notch"
    />

    <div v-else>
      <div>
        <draggable
          class="c-list-group"
          tag="ul"
          v-if="containsItem"
          v-model="list"
          v-bind="dragOptions"
          @start="isDragging=true"
          @end="isDragging=false"
        >
          <vItem
            v-for="element in list"
            :key="element.order"
            v-bind:id="element.id"
            v-bind:title="element.title"
            v-bind:order="element.order"
            v-bind:checked="element.completed"
            v-bind:is-dragging="isDragging"
            @change="toggleCompleted"
            @edit="updateItem"
            @delete="removeItem"
          />
        </draggable>

        <vEmptyListHelper v-else />
      </div>
    </div>
  </div>
</template>

<script>
  import draggable from "vuedraggable";
  import { errorAlert } from '@/tools/session'
  import vItem from '@/components/list/item.vue'
  import vHeader from '@/components/header/header.vue'
  import vAlertMessage from '@/components/alert-message.vue'
  import vAddItemButton from '@/components/list/add-item-button.vue'
  import vEmptyListHelper from '@/components/list/empty-list-helper.vue'
  import { displaySuccessAlert } from '@/tools/display-alert-message'

  const ITEMS_ENDPOINT = '/api/v1/items'

  export default {
    name: "List",
    pageTitle() {
      return this.$t('helpers.default_title')
    },
    components: {
      vHeader,
      draggable,
      vItem,
      vEmptyListHelper,
      vAddItemButton,
      vAlertMessage
    },
    data() {
      return {
        list: [],
        isDragging: false,
        delayedDragging: false,
        isFetchingItems: false,
        isAddingItem: false
      }
    },
    created() {
      this.load()
    },
    computed: {
      getAlertMessage() {
        return {
          message: this.$store.state.alertText,
          status: this.$store.state.alertType
        }
      },
      dragOptions() {
        return {
          animation: 0,
          group: "description",
          ghostClass: "ghost"
        }
      },
      containsItem() {
        return this.list.length > 0
      }
    },
    watch: {
      isDragging(newValue) {
        if (newValue) {
          return;
        }
        this.$nextTick(() => {
          this.updateOrderItems();
          this.delayedDragging = false;
        });
      }
    },
    methods: {
      load() {
        this.isFetchingItems = true

        this.$http.secured.get(ITEMS_ENDPOINT)
          .then(response => {
            this.list = response.data.items
          })
          .catch(error => {
            errorAlert(error)
          })
          .finally(() => this.isFetchingItems = false)
      },
      toggleCompleted(id, isChecked) {
        this.$http.secured.patch(`${ITEMS_ENDPOINT}/${id}`, {
          completed: isChecked
        })
          .then(response => {
            displaySuccessAlert(response.data.message)
          })
          .catch(error => {
            errorAlert(error)
          })
      },
      addItem(text) {
        this.isAddingItem = true
        this.updateOrderItems()

        this.$http.secured.post(ITEMS_ENDPOINT, {
          title: text,
          order: 0,
          completed: false,
        })
          .then(response => {
            displaySuccessAlert(response.data.message)
            this.list.unshift(response.data.item)
          })
          .catch(error => {
            errorAlert(error)
          })
          .finally(() => setTimeout(() => this.isAddingItem = false, 500))
      },
      updateItem(id, title) {
        this.$http.secured.patch(`${ITEMS_ENDPOINT}/${id}`, {
          id: id,
          title: title
        })
          .then(response => {
            displaySuccessAlert(response.data.message)
            const index = this.list.findIndex(item => item.id === id)
            this.list[index].title = title
          })
          .catch(error => {
            errorAlert(error)
          })
      },
      removeItem(id) {
        this.$http.secured.delete(`${ITEMS_ENDPOINT}/${id}`)
          .then(response => {
            displaySuccessAlert(response.data.message)
            this.list = response.data.items
          })
          .catch(error => {
            errorAlert(error)
          })
      },
      updateOrderItems() {
        if (this.list.length === 0) return
        this.list.forEach((item, index) => item.order = index + 1)
        this.$http.secured.post(`${ITEMS_ENDPOINT}/reorder`, {
          items: this.list
        })
          .then(response => {
            displaySuccessAlert(response.data.message)
            this.list = []
            this.$nextTick(() => {
              this.list = response.data.items
            });
          })
          .catch(error => {
            errorAlert(error)
          })
      }
    }
  }
</script>

<style scoped lang="scss">
  .c-list-group {
    padding: 0;
    min-height: 20px;
    margin-top: 20px;
    overflow: hidden;

  }
  .rotate {
    display: block;
    width: 40px;
    height: 40px;
    margin: 40px auto;
    color: $color-secondary;
  }

  @media only screen and (max-width: 600px) {
    .c-list-group {
			margin-bottom: 0;
    }
  }
</style>
