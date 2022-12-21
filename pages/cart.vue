<template lang="pug">
  div
    h2 Ваша корзина
    div(
      v-for="item in items"
      :key="item.id").item-card-cart
      v-card.card(

      )
        v-card-title {{ item.item.title }}
        v-card-text Цена: {{ item.item.price }} руб.
        v-card-text Колл-во: {{ item.amount }}
    v-btn(@click="moveToCheckout", v-if="items.length > 0") Перейти к оплате
    v-card-title(v-if="items.length === 0" ) Ваша корзина пуста, добавьте в нее что-нибудь!
</template>

<script>
export default {
  name: "cart",
  data() {
    return {
      items: []
    }
  },
  async mounted() {
    if( localStorage.userId !== 'null'){
      const cart = await this.$axios.$get('users/cart/' + localStorage.userId);
      this.items = cart.items;
      console.log(cart)
    }
  },
  methods: {
    moveToCheckout() {
      this.$router.push('/checkout')
    }
  }
}
</script>

<style scoped>
.item-card-cart {
  width: 300px;
  margin: 30px;
}
</style>
