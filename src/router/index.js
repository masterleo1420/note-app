import { createRouter, createWebHistory } from 'vue-router'

import LoginPage from "../components/LoginPage"

const routes = [
  { path: '/', 
  name: 'Login', 
  component: LoginPage },

]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
