<template>
  <div class="pa-4 text-center">
    <div class="d-flex justify-content-end align-items-end bottom-right">
      <v-btn icon="mdi-plus" size="x-large" @click="dialog = true"></v-btn>
    </div>
    <v-dialog v-model="dialog" width="auto">
      <v-alert
        v-model="alert"
        icon="$error"
        close-label="Close Alert"
        color="error"
        title="Fill"
        variant="tonal"
        closable
      >
      </v-alert>
      <v-card max-width="400" prepend-icon="mdi-plus" title="Add Note">
        <template v-slot:actions>
          <v-sheet class="mx-auto" width="300">
            <v-form @submit.prevent ref="form">
              <v-text-field
                :rules="nameRules"
                v-model="titleT"
                label="Title"
                required
              ></v-text-field>
              <v-text-field
                :rules="nameRules"
                v-model="descriptionText"
                label="Discripton"
                required = "asdsadsada"
              ></v-text-field>
              <v-select
                :rules="nameRulesD"
                v-model="select"
                :items="category"
                label="Category"
                required
              ></v-select>
              <v-btn class="mt-2" validation block @click="SendData()"
                >Save</v-btn
              >

              <v-btn class="mt-4" color="error" block @click="reset">
                Reset Form
              </v-btn>
            </v-form>
          </v-sheet>
        </template>
      </v-card>
      <div></div>
    </v-dialog>
  </div>

  <!-- alert -->
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
    idNode: 1,
    createBy: localStorage.getItem("user"),
    alert: false,
    nameRules: [(v) => !!v || "This field is required"],
    nameRulesD:[(select) => !!select || 'This field is required']
  }),
  methods: {
    SendData() {
      this.$refs.form.validate();
      const id = this.idNode++;
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
          createBy,
        });
        //clear data
        this.titleT = "";
        this.descriptionText = "";
        this.select = null;
        alert("Add Note");
        this.dialog = false;
        console.log(dateTime);
      }
    },
    checklocalStorage() {
      // ตรวจสอบว่ามีข้อมูลใน sessionStorage หรือไม่
      if (localStorage.getItem("isLoggedIn") !== null) {
        // ถ้ามีข้อมูลใน sessionStorage ให้ทำตามที่ต้องการที่นี่
        // เช่น การเข้าสู่ระบบสำเร็จ หรือเปลี่ยนหน้าไปที่หน้าหลัก
        console.log("มีข้อมูลใน localStorage");
      } else {
        // ถ้าไม่มีข้อมูลใน sessionStorage ให้เด้งไปหน้า login
        // หรือดำเนินการอื่น ๆ ที่คุณต้องการที่นี่
        window.location.href = "/";
      }
    },
    reset() {
      this.$refs.form.reset();
      console.log();
    },
    async validate() {
      const { valid } = await this.$refs.form.validate();

      if (valid) alert("Form is valid");
    },
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