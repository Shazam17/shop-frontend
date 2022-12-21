<template lang="pug">
v-card
  v-card-title Формирование заказа
  v-text-field(
    label="ФИО"
    placeholder="Введите фио"
    v-model="fullName"
  )
  v-text-field(
    label="Адрес"
    placeholder="введите адрес"
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
      destination: '',
      fullName: ''
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
