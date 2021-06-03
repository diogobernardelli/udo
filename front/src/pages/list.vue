<template>
  <div>
    <vAlertMessage
      :text="getAlertMessage.message"
      :type="getAlertMessage.status"
    />

    <vHeader />
    
    <vAddItemButton
      @addItem="addItem"
    />

    <font-awesome-icon v-if="isFetchingItems" class="rotate" icon="circle-notch" />

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
            @change="toggleCompleted"
            @edit="updateItem"
            @delete="removeItem"
          />
        </draggable>

        <vEmptyListHelper v-else />
      </div>
    </div>

    <!-- <div class="list-group col-md-3">
      <pre>{{listString}}</pre>
    </div> -->
  </div>
</template>

<script>
import draggable from "vuedraggable";
import vHeader from '@/components/header.vue'
import vEmptyListHelper from '@/components/list/empty-list-helper.vue'
import vItem from '@/components/list/item.vue'
import vAddItemButton from '@/components/list/add-item-button.vue'
import vAlertMessage from '@/components/list/alert-message.vue'
import { displaySuccessAlert, displayErrorAlert} from '@/tools/display-alert-message'

const SUCCESS_ALERT = 'success'
const ERROR_ALERT = 'error'
const ITEMS_ENDPOINT = '/api/v1/items'

export default {
  name: "List",
  pageTitle() {
    return 'Create tasks for You to Do'
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
      // list: message.map((name, index) => {
      //   return { id: index, name, order: index + 1, fixed: false, completed: !Math.round(Math.random()) };
      // }),
      list: [],
      isDragging: false,
      delayedDragging: false,
      isFetchingItems: false
    };
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
      };
    },
    listString() {
      return JSON.stringify(this.list, null, 2);
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

      this.$http.plain.get(ITEMS_ENDPOINT)
        .then(response => {
          this.list = response.data.items
        })
        .catch(error => {
          this.$store.commit(
            'displayAlert',
            {
              message: error,
              status: ERROR_ALERT
            }
          )
        })
        .finally(() => this.isFetchingItems = false)
    },
    toggleCompleted(id) {
      let element = this.list.find(item => item.id === id)
      element.completed = !element.completed
    },
    addItem(text) {
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
          const errorMessage = (error.response && error.response.data && error.response.data.error) || error
          displayErrorAlert(errorMessage)
        })
    },
    updateItem(element) {
      console.log(element)
      this.$store.commit(
        'displayAlert',
        {
          message: 'Activity Successfully Updated',
          status: SUCCESS_ALERT
        }
      )
    },
    removeItem(id) {
      this.$http.secured.delete(`${ITEMS_ENDPOINT}/${id}`)
        .then(response => {
          displaySuccessAlert(response.data.message)
          this.list = response.data.items
        })
        .catch(error => {
          const errorMessage = (error.response && error.response.data && error.response.data.error) || error
          displayErrorAlert(errorMessage)
        })
    },
    updateOrderItems() {
      if (this.list.length === 0) return
      this.list.forEach((item, index) => item.order = index + 1)
      this.$http.secured.post(`${ITEMS_ENDPOINT}/reorder`, {
        items: this.list
      })
        .then(response => {
          // displaySuccessAlert(response.data.message)
          this.list = response.data.items
        })
        .catch(error => {
          const errorMessage = (error.response && error.response.data && error.response.data.error) || error
          displayErrorAlert(errorMessage)
        })
    }
  }
};
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
    color: #001a4a;
  }
</style>
