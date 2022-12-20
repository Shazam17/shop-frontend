<template lang="pug">
  div
    v-card-title Заказы
    div
      v-card(v-for="order in orders").orders-wrapper
        v-card-title {{ order.name }}
        div
          div.item-card(v-for="item in order.items")
            h3 Название: {{ item.title }}
            p Цена: {{ item.price }} руб.
            p Количество: {{ item.amount }}
        v-btn(
          @click="deleteOrder(order.id)"
        ) Удалить заказ

</template>

<script lang="ts">
export default {
  name: "orders",
  data() {
    return {
      orders: [],
      userId: null
    }
  },
  async mounted() {
    this.userId = localStorage.userId;
    await this.fetchOrders();
  },
  methods: {
    async deleteOrder(orderId: string) {
      await this.$axios.$delete(`/items/order/${orderId}`);
      await this.fetchOrders();
    },
    async fetchOrders() {
      const orderDto = await this.$axios.$get(`/items/orders/${this.userId}`);
      console.log(orderDto)
      this.orders = orderDto;
    }
  }
}
</script>
<style scoped>
.item-card {
  padding: 30px;
  margin: 30px;
  border-radius: 5px;
  background-color: #363637;
}
.orders-wrapper {
  padding: 30px;
  margin-bottom: 30px;
}
</style>
