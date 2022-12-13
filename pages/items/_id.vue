<template lang="pug">
  v-card(
    :v-if="item !== null"
  ).item-detail-card
    v-card-title {{ item.title }}
    v-card-text описание товара: {{ item.description }}
    v-card-text цена: {{ item.price }}
    v-card-text осталось в наличии {{ item.amount }}


</template>


<script>
export default {
  name: "ItemDetails",
  data: () => {
    return {
      id: '1',
      item: {

      }
    }
  },
  asyncData({ params }) {
    return {id: params.id}
  },
  async mounted() {
    this.item = await this.$axios.$get('/items/' + this.id);
    console.log(this.item)
  }
}
</script>


<style>
.item-detail-card {
  margin: 50px auto;
  width: 50%;
}
</style>
