<template>
  <div class="pa-4 text-center">
    <div class="d-flex justify-content-end align-items-end bottom-right">
      <v-btn icon="mdi-plus" size="x-large" @click="dialog = true"></v-btn>
    </div>
    <v-dialog v-model="dialog" width="auto">
      <v-card max-width="400" prepend-icon="mdi-plus" title="Add Note">
        <template v-slot:actions>
          <v-sheet class="mx-auto" width="300">
            <v-form @submit.prevent>
              <v-text-field v-model="titleT" label="Title" required></v-text-field>
              <v-text-field
                v-model="descriptionText"
                label="Discripton"
                required
              ></v-text-field>
              <v-select
                v-model="select"
                :items="category"
                label="Category"
                required
              ></v-select>
              <v-btn class="mt-2" type="submit" block @click="SendData"
                >Save</v-btn
              >
            </v-form>
          </v-sheet>
        </template>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  mounted() {
    this.checklocalStorage();
    console.log(localStorage.getItem("user"));
  },
  data: () => ({
    dialog: false,
    titleT: "",
    descriptionText: "",
    select: null,
    category: ["1", "2", "3"],
    idNode:1,
    createBy:localStorage.getItem("user")
  }),
  methods: {
    SendData() {
      const id = this.idNode++
      if (
        this.titleT !== "" &&
        this.descriptionText !== "" &&
        this.select !== ""
      ) {
        const title = this.titleT;
        const description = this.descriptionText;
        const category = this.select;
        const createBy = this.createBy;
        // current dateTime
        const dateTime = new Date().toLocaleString("th-TH");
        this.$emit("SeDataToCnote", {
          id,
          title,
          description,
          category,
          dateTime,
          createBy
        });
        this.showAlertDone = true;
        //clear data
        this.titleT = "";
        this.descriptionText = "";
        this.select = null;
        alert("Add Note")
        this.dialog = false;
        console.log(dateTime);
      }else{
        alert("Please fill in fields")
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
    }
  },
};
</script>
<style>
.bottom-right {
  position: fixed;
  bottom: 0;
  right: 0;
  margin-right: 20px; /* ปรับขนาดของชิ้นส่วนของปุ่มตามความต้องการ */
  margin-bottom: 20px; /* ปรับขนาดของชิ้นส่วนของปุ่มตามความต้องการ */
}
</style>