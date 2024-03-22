<template>
  <!--  -->
  <v-card width="auto" class="mb-5" v-if="note1">
    <v-card-item>
      <div class="float-right">
        <v-btn class="mr-3" @click="check"
          ><v-icon>mdi-pencil</v-icon>EDIT</v-btn
        >
        <v-btn @click="deleteNote">DELETE</v-btn>
      </div>
      <v-row>
        <v-col
          ><v-card-title class="float-right">
            {{ note1.createBy }}
            </v-card-title></v-col
        >
      </v-row>

      <v-card-title>{{ note1.title }}</v-card-title>
      <v-card-text> {{ note1.description }}</v-card-text>
      <v-card-text> {{ note1.category }}</v-card-text>
      <small class="text-caption text-medium-emphasis float-right mr-4">
        Added on: {{ note1.dateTime }}
      </small>
    </v-card-item>
  </v-card>

  <v-dialog v-model="dialog" max-width="600">
    <v-card>
      <v-card-title>Edit Note</v-card-title>
      <v-card-text>
        <v-form @submit.prevent="saveChanges">
          <v-text-field v-model="editedNote.title" label="Title"></v-text-field>
          <v-text-field
            v-model="editedNote.description"
            label="Description"
          ></v-text-field>
          <v-select
            v-model="editedNote.category"
            :items="categories"
            label="Category"
          ></v-select>
          <v-btn type="submit" color="primary">Save Changes</v-btn>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  mounted() {
    this.checklocalStorage();
    console.log(localStorage.getItem("user"));
  },
  props: ["note1","user"],
  data: () => ({
    dialog: false,
    TitleE: "",
    DescriptionE: "",
    selectE: null,
    CategoryE: ["1", "2", "3"],
  }),
  methods: {
    deleteNote() {
      console.log("DELEOT");
      this.$emit("delete-note", this.note1.id);
    },
    // editNote() {
    //   // ตั้งค่าโน้ตที่แก้ไขในตัวแปรชั่วคราว editedNote

    //   let editedNote = {
    //     id: this.note1.id,
    //     title: this.note1.title,
    //     description: this.note1.description,
    //     category: this.note1.category,
    //   };

    //   // เรียกใช้งานเมทอดที่ส่งโน้ตที่แก้ไขไปยังคอมโพเนนต์หลัก
    //   this.$emit("edit-note", editedNote);
    // },

    cancelDialog() {
      this.dialog = false;
    },
    OpenDialog() {
      this.dialog = true;
    },
    check() {
      console.log(this.$props.note1.title);
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
  },
};
</script>