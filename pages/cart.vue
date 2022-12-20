<template lang="pug">
  div
    h2 Ваша корзина
    div(
      v-for="item in items"
      :key="item.id").item-card-cart
      v-card.card(
        @click.native="pushDetailPage(item.id)"
      )
        v-card-title {{ item.item.title }}
        v-card-text Цена: {{ item.item.price }} руб.
        v-card-text Колл-во: {{ item.amount }}
    v-btn(@click="moveToCheckout") Перейти к оплате
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
    if( localStorage.userId){
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
