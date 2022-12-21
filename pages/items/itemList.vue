<template lang="pug">
  div
    div
      v-select(
      v-model="categoryFilter"
      :items="categories"
      item-text="title"
      item-value="value"
      label="Выберите категорию"
        )
      v-text-field(
      v-model="nameFilter"
      placeholder="Введите название"
      )
    div(
      v-for="item in items"
      :key="item.id").item-card
      v-card.card(
        @click.native="pushDetailPage(item.id)"
      )
        v-card-title {{ item.title }}
        v-card-text Цена всего ничего:
          b {{ item.price }} руб.
        v-btn(v-on:click.stop="addToCart(item.id)" ) {{!item.ordered ? 'Добавить в корзину' : 'Добавить еще!' }}
        v-card-text(v-if="item.ordered") Заказано уже {{ item.ordered }} шт.

</template>

<script>
export default {
  name: 'ItemList',
  data: () => {
    return {
      items: [],
      categoryFilter: null,
      categories: [ {title: 'Не выбрано', value: null}, {title: 'шахматы', value: 'chess'}, {title: 'что-то еще', value: 'something'}],
      nameFilter: '',
      userId: ''
    }
  },
  watch: {
    categoryFilter(filter) {
      this.fetchItems()
    },
    nameFilter(filter) {
      this.fetchItems()
    }
  },
  async mounted() {
    if (localStorage.getItem('userId') !== 'null') {
      this.userId = localStorage.getItem('userId');
    }
    await this.fetchItems();
  },
  methods: {
    pushDetailPage(itemId) {
      this.$router.push(`items/${itemId}`)
    },
    async addToCart(itemId) {
      if(!this.userId) {
        alert('Вы не авторизированны для этого действия')
        return;
      }
      await this.$axios.$put('users/cart', {
        itemId,
        userId: this.userId
      })
      await this.fetchItems()
    },
    async fetchItems() {
      const items = await this.$axios.$post('/items/search', {
        nameFilter: this.nameFilter.length > 0 ? this.nameFilter : null,
        userId: this.userId,
        category: this.categoryFilter
      });
      this.items = items;
    }
  }
}
</script>

<style>
.item-card {
  width: 300px;
  /*height: 200px;*/
  margin: 25px;

}
.card {
  padding: 10px;
}
</style>
