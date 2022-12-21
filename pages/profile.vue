<template lang="pug">
  v-card
    v-card-title Ваш аккаунт
    div(v-if="user").user-wrapper
      v-text-field(
        label="Email"
        value="user.email"
      )
      v-text-field(
        label="Пароль"
        placeholder="Введите новый пароль",
        v-model="password",
        type="password"
      )
      v-text-field(
        label="Подтверждение пароля"
        placeholder="Подтвердите новый пароль",
        v-model="passwordCheck"
        type="password"
      )
      v-text-field(
        label="Имя пользователя"
        placeholder="Введите имя пользователя"
        v-model="firstName"
      )
      v-text-field(
        label='Фамилия'
        placeholder="Введите фамилию пользователя"
        v-model="lastName"
      )
      v-btn(
        @click="editUser()"
      ) Сохранить
</template>

<script>
export default {
  name: "profile",
  data() {
    return {
      user: null,
      password: '',
      passwordCheck: '',
      firstName: '',
      lastName: ''
    }
  },
  async mounted() {
    if(localStorage.userId !== 'null') {
      this.userId = localStorage.userId;
      await this.fetchUser()
    }
  },
  methods: {
    async editUser() {
      if(this.password !== this.passwordCheck) {
        return;
      }
      await this.$axios.$post('users/update-user', {
        password: this.password,
        firstName: this.firstName,
        lastName: this.lastName,
        userId: this.userId
      });
      await this.fetchUser()
    },
    async fetchUser() {
      this.user = await this.$axios.$get('users/' + this.userId);
      this.password = this.user.password;
      this.passwordCheck = this.user.password;
      this.firstName = this.user.firstName;
      this.lastName = this.user.lastName;
    }
  }
}
</script>

<style scoped>
.user-wrapper {
  padding: 30px;
}
</style>
