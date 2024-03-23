<template>
  <v-app id="inspire">
    <!-- ส่วนของเงื่อนไขเพื่อตรวจสอบการแสดงหน้า -->
    <template v-if="isLoggedIn">
      <v-app-bar>
        <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
        <v-app-bar-title>My Note</v-app-bar-title>
      </v-app-bar>

      <v-navigation-drawer v-model="drawer" temporary>
        <div class="d-flex justify-content-end align-items-end bottom-right">
          <v-btn @click="handleLogout"> Logout </v-btn>
          <v-btn> test </v-btn>
        </div>
        <div></div>
      </v-navigation-drawer>

      <v-main>
        <v-container class="mt-10">
          <v-row>
            <v-col>
              <div class="float-right">
                <v-btn @click="sortNotesByTitle">เรียงลำดับตามชื่อ</v-btn>
                <v-btn @click="sortByCategory">Sort by Category</v-btn>
              </div>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <ListNote
                :notesd="paginatedNotes"
                :currentPage="currentPage"
                @change-page="handleChangePage"
                @delete-note="handleDeleteNote"
                @edit-note="handleEditNote"
              />
              <v-pagination
                v-model="currentPage"
                :length="Math.ceil(notes.length / 4)"
                rounded="circle"
              >
              </v-pagination>
            </v-col>
          </v-row>
        </v-container>

        <CreateNote v-on:SeDataToCnote="handleSeDataToCnote" />
      </v-main>
    </template>

    <!-- ส่วนของ LoginPage ที่ยังไม่ได้ใช้งาน -->
    <template v-else>
      <LoginPage @login-success="handleLoginSuccess" />
    </template>
  </v-app>
</template>

<script setup>
import { ref } from "vue";
import CreateNote from "./components/create-note.vue";
import ListNote from "./components/ListNote.vue";
import LoginPage from "./components/LoginPage.vue";

const drawer = ref(null);
const user = ref(null);

const handleLoginSuccess = (userData) => {
  user.value = userData;
  localStorage.setItem("isLoggedIn", true);
  window.location.href = "/";
};

const isLoggedIn = ref(localStorage.getItem("isLoggedIn") === "true");

const handleLogout = () => {
  localStorage.setItem("isLoggedIn", false);
  localStorage.removeItem("user");
  window.location.href = "/";
};
</script>

<script>
export default {
  monuted() {
    console.log();
  },
  name: "App",
  components: {
    CreateNote,
    ListNote,
    LoginPage,
  },
  data: () => ({
    drawer: null,
    notes: [],
    currentTime: null,
    currentPage: 1,
    itemsPerPage: 4,
    createBy: "",
  }),
  computed: {
    lengthPages() {
      return Math.ceil(this.notes.length / this.itemsPerPage);
    },
    paginatedNotes() {
      const startIndex = (this.currentPage - 1) * this.itemsPerPage;
      return this.notes.slice(startIndex, startIndex + this.itemsPerPage);
    },
  },
  methods: {
    getCurrentTime() {
      const now = new Date();
      this.currentTime = now.toLocaleString();
    },
    handleSeDataToCnote(data) {
      console.log("Received data in Parent Component:", data);
      this.notes.unshift(data);
      this.notes.sort((a, b) => new Date(b.dateTime) - new Date(a.dateTime));
    },
    sortNotesByTitle() {
      this.notes.sort((a, b) => a.title.localeCompare(b.title));
    },
    sortByCategory() {
      this.notes.sort((a, b) => a.category.localeCompare(b.category));
    },
    handleChangePage(page) {
      this.currentPage = page;
    },
    handleDeleteNote(noteId) {
      this.notes = this.notes.filter((note) => note.id !== noteId);
    },
    handleEditNote(editedNote) {
    // ตรวจสอบว่ามีโน้ตที่ต้องการแก้ไขหรือไม่
    const noteIndex = this.notes.findIndex(note => note.id === editedNote.id);
    if (noteIndex !== -1) {
      // ทำการอัปเดตข้อมูลโน้ตที่มี ID ตรงกับ ID ใน editedNote
      this.notes[noteIndex] = editedNote;
    } else {
      console.error('Note not found for ID:', editedNote.id);
    }
  }
  },
};
</script>
