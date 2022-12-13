<template lang="pug">
  v-card
    v-card-title Ваш аккаунт
    div(v-if="user")
      v-text-field(
        value="user.email"
      )
      v-text-field(
        placeholder="Введите новый пароль"
      )
      v-text-field(
        placeholder="Подтвердите новый пароль"
      )
      v-text-field(
        placeholder="Введите имя пользователя"
      )
      v-text-field(
        placeholder="Введите фамилию пользователя"
      )
      v-btn Сохранить
</template>

<script>
export default {
  name: "profile",
  data() {
    return {
      user: null
    }
  },
  async mounted() {
    if(localStorage.userId) {
      this.userId = localStorage.userId;
      this.user = await this.$axios.$get('users/' + this.userId);
    }
  }
}
</script>

<style scoped>

</style>
