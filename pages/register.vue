<template lang="pug">
  v-card.auth-wrapper
    div.field-wrapper
      v-card-title Регистрация
      v-text-field(
        v-model="email"
        placeholder="Введите почту"
      )
      v-text-field(
        v-model="password"
        type='password'
        placeholder="Введите пароль"
      )
      v-btn(@click="register()") Зарегистрироваться

</template>

<script>
export default {
  name: "register",
  data() {
    return {
      email: '',
      password: ''
    }
  },
  methods: {
    async register() {
      const auth = await this.$axios.$post('users/register', {
        email: this.email,
        password: this.password
      });
      console.log(auth)
      if(auth.success) {
        await this.$router.push('/auth')
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
