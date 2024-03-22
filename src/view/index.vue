<template>
    <v-app id="inspire">
      <LoginPage />
      <v-app-bar>
        <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
  
        <v-app-bar-title>My Note</v-app-bar-title>
      </v-app-bar>
  
      <v-navigation-drawer v-model="drawer" temporary>
        <div class="d-flex justify-content-end align-items-end bottom-right">
          <v-btn> Logout </v-btn>
        </div>
        <v-footer>asdsad</v-footer>
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
    </v-app>
  </template>
  
  <script setup>
  import { ref } from "vue";
  import CreateNote from "./components/create-note.vue";
  import ListNote from "./components/ListNote.vue";
  import LoginPage from './components/LoginPage.vue';
  const drawer = ref(null);
  </script>
  
  <script>
  export default {
    components: {
      CreateNote,
      ListNote,
      LoginPage
    },
    data: () => ({
      drawer: null,
      notes: [
        {
          id:"1",
          title:"Hellp",
          description: "adsadsa",
          category: "2",
        },
        {
          id:"2",
          title:"Pae",
          description: "adsadsa",
          category: "2",
        },
      ],
      currentTime: null,
      currentPage: 1,
      itemsPerPage: 4,
    }),
    computed: {
      // คำนวณจำนวนหน้าโดยใช้ Math.ceil จากจำนวนของ notes หารด้วย itemsPerPage
      lengthPages() {
        return Math.ceil(this.notes.length / this.itemsPerPage);
      },
      // คำนวณแบ่ง cards ตามหน้าที่กำหนด
      paginatedNotes() {
        const startIndex = (this.currentPage - 1) * this.itemsPerPage;
        return this.notes.slice(startIndex, startIndex + this.itemsPerPage);
      },
    },
    methods: {
      getCurrentTime() {
        const now = new Date();
        this.currentTime = now.toLocaleString(); // หรืออื่น ๆ ตามที่ต้องการแสดงรูปแบบ
      },
      //Add data to notes
      handleSeDataToCnote(data) {
        console.log("Received data in Parent Component:", data);
        //unshift คือการเพิ่มโน้ตใหม่ที่สร้างไปยังตำแหน่งแรกของอาร์เรย์
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
    },
  };
  </script>