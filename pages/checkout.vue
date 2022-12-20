<template lang="pug">
v-card
  v-card-title Формирование заказа
  v-text-field(
    placeholder="Введите получателя"
    v-model="destination"
  )
  v-btn(
    @click="createOrder()"
  ) сформировать заказа
</template>

<script>
export default {
  name: "checkout",
  data() {
    return {
      destination: ''
    }
  },
  methods: {
    async createOrder() {
      const userId = localStorage.userId;
      await this.$axios.$put(`/items/order/${userId}`, {destination: this.destination})
      await this.$router.push('/')
    }
  }
}
</script>

<style scoped>

</style>
