<template>
  <!--  -->
  <v-card width="auto" class="mb-5" v-if="note1">
    <v-card-item>
      <div class="float-right">
        <v-btn class="mr-3" @click="OpenDialogEdit()"
          ><v-icon>mdi-pencil</v-icon>EDIT</v-btn
        >
        <v-btn @click="deleteNote">DELETE</v-btn>
      </div>
      <v-row>
        <v-col
          ><v-card-title class="float-right">
            Create By {{ note1.createBy }}
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

  <!-- -->
  <v-dialog v-model="dialog" width="auto" height="auto">
    <v-card max-width="400" prepend-icon="mdi-plus" title="Add Note">
      <template v-slot:actions>
        <v-sheet class="mx-auto" width="600" height="400">
          <v-form @submit.prevent ref="form">
            <v-text-field
              v-model="editedNote.title"
              label="Title"
              required
            ></v-text-field>
            <v-text-field
              v-model="editedNote.description"
              label="Discripton"
              required="asdsadsada"
            ></v-text-field>
            <v-select
              v-model="editedNote.category"
              :items="CategoryE"
              label="Category"
              required
            ></v-select>
            <div>
              <v-row>
                <v-col>
                  <v-btn class="" block @click="saveChanges">Save Change</v-btn>
                </v-col>
              </v-row>
              <v-row>
                <v-col>
                  <v-btn class="" color="error" block @click="reset">
                    Reset Form
                  </v-btn>
                </v-col>
              </v-row>
              <v-row>
                <v-col>
                  <v-btn class="" color="error" block @click="cancelDialog">
                    cancel
                  </v-btn>
                </v-col>
              </v-row>
            </div>
          </v-form>
        </v-sheet>
      </template>
    </v-card>
    <div></div>
  </v-dialog>
</template>

<script>
export default {
  mounted() {
    this.checklocalStorage();
    console.log(localStorage.getItem("user"));
  },
  props: ["note1", "user"],
  data: () => ({
    id: null,
    dialog: false,
    TitleE: "",
    DescriptionE: "",
    selectE: null,
    CategoryE: ["1", "2", "3"],
    dateTime: "",
    createBy: "", 
    editedNote: {
        id: null,
        title: '',
        description: '',
        category: '',
      },
  }),
  methods: {
    deleteNote() {
      console.log("DELETE");
      this.$emit("delete-note", this.note1.id);
    },

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
      // ตรวจสอบว่ามีข้อมูลใน localStorage หรือไม่
      if (localStorage.getItem("isLoggedIn") !== null) {
        // ถ้ามีข้อมูลใน localStorage ให้ทำตามที่ต้องการที่นี่
        // เช่น การเข้าสู่ระบบสำเร็จ หรือเปลี่ยนหน้าไปที่หน้าหลัก
        console.log("มีข้อมูลใน localStorage");
      } else {
        // ถ้าไม่มีข้อมูลใน localStorage ให้เด้งไปหน้า login
        // หรือดำเนินการอื่น ๆ ที่คุณต้องการที่นี่
        window.location.href = "/";
      }
    },
    reset() {
      this.$refs.form.reset();
    },
    OpenDialogEdit() {
      this.dialog = true;
      // กำหนดข้อมูลที่ต้องการแก้ไขลงใน editedNote
      this.editedNote.id = this.note1.id;
      this.editedNote.title = this.note1.title;
      this.editedNote.description = this.note1.description;
      this.editedNote.category = this.note1.category;
    },
    saveChanges() {
      // ส่งข้อมูลโน้ตที่แก้ไขไปยังคอมโพเนนต์หลัก (App.vue)
      this.$emit("edit-note", this.editedNote);
      // ปิดไดอะล็อกหลังจากบันทึกการแก้ไข
      this.dialog = false;
    },
   
  },
};
</script>