<template>
    <v-container>
      <v-row justify="center">
        <v-col cols="12" sm="8" md="6">
          <v-card>
            <v-card-title class="headline">Login</v-card-title>
            <v-card-text>
              <v-form @submit.prevent="login">
                <v-text-field v-model="username" label="Username"></v-text-field>
                <v-text-field v-model="password" label="Password" type="password"></v-text-field>
                <v-btn type="submit" color="primary">Login</v-btn>
              </v-form>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </template>
  
  <script>
  export default {
    mounted() {
    this.checklocalStorage();
  },
    data() {
      return {
        username: '',
        password: ''
      };
    },
    methods: {
      login() {
        // ตรวจสอบข้อมูลเข้าสู่ระบบ โดยในที่นี้ให้ใช้ข้อมูลที่กำหนดไว้เป็นตัวอย่าง
        if (this.username === 'admin' && this.password === '1234') {
          // ส่งข้อมูลการล็อกอินสำเร็จกลับไปยัง Component หลัก
          this.$emit('login-success', this.username);
          // ล้างค่าช่องใส่ข้อมูลหลังจาก Login เสร็จสิ้น
          localStorage.setItem("user",this.username)
        } else {
          alert('Invalid username or password');
        }
      },
      checklocalStorage() {
      // ตรวจสอบว่ามีข้อมูลใน sessionStorage หรือไม่
      if (localStorage.getItem('isLoggedIn') !== null) {
          // ถ้ามีข้อมูลใน sessionStorage ให้ทำตามที่ต้องการที่นี่
          // เช่น การเข้าสู่ระบบสำเร็จ หรือเปลี่ยนหน้าไปที่หน้าหลัก
          console.log("มีข้อมูลใน localStorage");
      } else {
          // ถ้าไม่มีข้อมูลใน sessionStorage ให้เด้งไปหน้า login
          // หรือดำเนินการอื่น ๆ ที่คุณต้องการที่นี่
          window.location.href = "/";
      }
  },
    }
  };
  </script>
  