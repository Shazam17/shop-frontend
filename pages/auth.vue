<template lang="pug">
  v-card.auth-wrapper
    div.field-wrapper
      v-card-title Авторизация
      v-text-field(
        v-model="email"
        placeholder="Введите почту"
      )
      v-text-field(
        v-model="password"
        type='password'
        placeholder="Введите пароль"
      )
      v-btn(@click="login()") войти
      p
      v-btn(@click="$router.push('/register')") Зарегистрироваться

</template>

<script>
export default {
  name: "auth",
  data() {
    return {
      email: '',
      password: ''
    }
  },
  methods: {
    async login() {
      const auth = await this.$axios.$post('items/login', {
        email: this.email,
        password: this.password
      });
      if(auth.success) {
        localStorage.userId = auth.userId;
        this.$router.push('/')
      }
    }
  }
}
</script>

<style scoped>
.auth-wrapper {
  margin: 50px auto 0 auto;
  width: 50%
}
.field-wrapper {
  margin: 0 auto;
  width: 50%;
  padding: 15px;
}
</style>
