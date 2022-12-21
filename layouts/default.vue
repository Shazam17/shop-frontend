<template>
  <v-app class="app-wrapper" >
    <div class="drawer-wrapper">
      <v-card
        class="drawer">
        <v-navigation-drawer
          floating
          permanent>
          <v-list
            dense
            rounded>
            <v-list-item
              v-for="item in items"
              :key="item.title"
              @click="pushRoute(item.route)"
              link>
              <v-list-item-content>
                <v-list-item-title class="text-list" >{{ item.title }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
          <v-card class="small-cart" @click="pushRoute('/cart')" v-if="userId">
            <v-card-title>Корзина</v-card-title>
            <v-card-text> {{ cartPrice }} руб.</v-card-text>
          </v-card>
          <v-card class="small-cart" @click="logout()" v-if="userId">
            <v-card-title>Выход</v-card-title>
          </v-card>
          <v-card class="small-cart" @click="pushRoute('/auth')" v-if="!userId">
            <v-card-title>Войти в аккаунт</v-card-title>
          </v-card>
        </v-navigation-drawer>
      </v-card>
      <div class="app-container">
        <Nuxt />
      </div>
    </div>
  </v-app>
</template>

<script>
export default {
  data () {
    return {
      items: [
        { title: 'Главная', route: '/' },
      ],
      cartPrice: 0,
      userId: null
    }
  },
  async mounted() {
    await this.fetchData()
    if(localStorage.userId !== 'null' && localStorage.userId) {
      this.items.push(...[
        { title: 'Пользователь', route: '/profile'},
        { title: 'Заказы', route: '/orders'},
      ])
    }
  },
  methods: {
    async fetchData() {
      if(localStorage.userId !== 'null' && localStorage.userId) {
        const cart = await this.$axios.$get('users/cart/' + localStorage.userId);
        this.cartPrice = cart.totalPrice;
        this.userId = localStorage.userId
      } else {
        this.cartPrice = 0;
        this.userId = null
      }
    },
    pushRoute(route) {
      this.$router.push(route);
    },
    async logout() {
      localStorage.setItem('userId', null);
      await this.fetchData()
      await this.$router.push('/auth')
    }
  }
}
</script>


<style>
.drawer-wrapper {
  display: flex;
  height: fit-content;
}
.drawer {
  width: 150px;
  margin: 15px;
  height: 500px;
}
.text-list {
  font-size: 14px;
}
.small-cart {
  margin: 15px;
}
.app-container {
  margin: 50px auto;
  width: 60%;
  height: 100%;
}
.app-wrapper {
  /*min-height: 0vh !important;*/
  min-height: 100vh !important;

}
.v-application--wrap {
  min-height: 0vh !important;
}
</style>
