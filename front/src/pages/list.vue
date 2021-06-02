<template>
  <div>
    <vAlertMessage
      :text="alertText"
      :type="alertType"
      @close="closeAlert"
    />

    <vHeader />
    
    <vAddItemButton
      @addItem="addItem"
      @errorMessage="displayAlert"
    />

    <div>
      <draggable
        class="c-list-group"
        tag="ul"
        v-if="containsItem"
        v-model="list"
        v-bind="dragOptions"
        :move="onMove"
        @start="isDragging=true"
        @end="isDragging=false"
      >
        <vItem
          v-for="element in list"
          :key="element.order"
          v-bind:id="element.id"
          v-bind:name="element.name"
          v-bind:order="element.order"
          v-bind:checked="element.completed"
          @change="toggleCompleted"
          @edit="updateItem"
          @delete="removeItem"
        />
      </draggable>

      <vWelcomeHelper v-else />
    </div>

    <!-- <div class="list-group col-md-3">
      <pre>{{listString}}</pre>
    </div> -->
  </div>
</template>

<script>
import draggable from "vuedraggable";
import vHeader from '@/components/header.vue'
import vWelcomeHelper from '@/components/welcome-helper.vue'
import vItem from '@/components/list/item.vue'
import vAddItemButton from '@/components/list/add-item-button.vue'
import vAlertMessage from '@/components/list/alert-message.vue'

const message = [
  "vue.draggable",
  "draggable",
  "component",
  "for",
  "vue.js 2.0",
  "based",
  "on",
  "Sortablejs"
];

const SUCCESS_ALERT = 'success'

export default {
  name: "List",
  pageTitle() {
    return 'Create tasks for You to Do'
  },
  components: {
    vHeader,
    draggable,
    vItem,
    vWelcomeHelper,
    vAddItemButton,
    vAlertMessage
  },
  data() {
    return {
      list: message.map((name, index) => {
        return { id: index, name, order: index + 1, fixed: false, completed: !Math.round(Math.random()) };
      }),
      isDragging: false,
      delayedDragging: false,
      alertText: '',
      alertType: ''
    };
  },
  methods: {
    onMove({ relatedContext, draggedContext }) {
      const relatedElement = relatedContext.element;
      const draggedElement = draggedContext.element;
      return (
        (!relatedElement || !relatedElement.fixed) && !draggedElement.fixed
      );
    },
    toggleCompleted(id) {
      let element = this.list.find(item => item.id === id)
      element.completed = !element.completed
    },
    addItem(text) {
      this.updateOrderItems()
      const newItem = {
        id: this.list.length + 1,
        name: text,
        order: 0,
        fixed: false,
        completed: false
      }
      this.list.unshift(newItem)
      this.displayAlert(
        'Activity Successfully Created',
        SUCCESS_ALERT
      )
    },
    updateItem(element) {
      console.log(element)
      this.displayAlert(
        'Activity Successfully Updated',
        SUCCESS_ALERT
      )
    },
    removeItem(id) {
      this.list = this.list.filter(element => element.id !== id);
      this.displayAlert(
        'Activity Successfully Removed',
        SUCCESS_ALERT
      )
    },
    updateOrderItems() {
      this.list.forEach((item, index) => item.order = index + 1)
    },
    closeAlert() {
      this.alertText = ''
    },
    displayAlert(message, status) {
      this.closeAlert()
      setTimeout(() => {
        this.alertText = message
        this.alertType = status
      }, 500)
    }
  },
  computed: {
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
        // TODO:
        // enviar request para API
        this.updateOrderItems();
        this.delayedDragging = false;
      });
    }
  }
};
</script>

<style scoped lang="scss">
  .c-list-group {
    padding: 0;
    min-height: 20px;
    margin-top: 20px;
  }
</style>
