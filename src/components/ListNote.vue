<template>
 <Tnotes v-for="note in notesd" v-bind:key="note.id" v-bind:note1="note" @delete-note="handleDeleteNote" @edit-note="handleEditNote" />
</template>
  
  <script>
import Tnotes from "./TextNote.vue";

export default {
    mounted() {
    this.checklocalStorage();
  },
  props: ["notesd"],
  components: {
    Tnotes,
  },
  computed: {
    // คำนวณแบ่ง cards ตามหน้าที่กำหนดและเรียงลำดับโน้ตตามเวลาที่สร้างล่าสุด
    sortedNotes() {
      const itemsPerPage = 4;
      const startIndex = (this.$store.state.currentPage - 1) * itemsPerPage;
      const paginated = this.notesd.slice(
        startIndex,
        startIndex + itemsPerPage
      );

      // เรียงลำดับโน้ตตามเวลาที่สร้างล่าสุด
      return paginated.sort(
        (a, b) => new Date(b.dateTime) > new Date(a.dateTime)
      );
    },
  },
  methods: {
    handleEditNote(editedNote){
        
        this.$emit("edit-note", editedNote);
    },
    
    handleDeleteNote(noteId) {
      // ส่งอีเวนต์ delete-note ไปยัง component หลัก (App.vue)
      this.$emit("delete-note", noteId);
    },
    handlePageChange(page) {
      this.$emit("change-page", page);
    },
    checklocalStorage() {
      // ตรวจสอบว่ามีข้อมูลใน localStorage หรือไม่
      if (localStorage.getItem('isLoggedIn') !== null) {
          // ถ้ามีข้อมูลใน localStorage ให้ทำตามที่ต้องการที่นี่
          // เช่น การเข้าสู่ระบบสำเร็จ หรือเปลี่ยนหน้าไปที่หน้าหลัก
          console.log("มีข้อมูลใน localStorage");
      } else {
          // ถ้าไม่มีข้อมูลใน localStorage ให้เด้งไปหน้า login
          // หรือดำเนินการอื่น ๆ ที่คุณต้องการที่นี่
          window.location.href = "/";
      }
    }
    
    
  },
};
</script>