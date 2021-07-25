<template>
  <el-table-column
          :prop="propName"
          :label="labelName"
          width="40"
  >
  </el-table-column>
</template>

<script>
  export default {
    name: "tableItem",
    props: {
      propName: {
        type: String,
        default: ''
      },
      labelName: {
        type: String,
        default: ''
      }
    },
    created() {
    }
  }
</script>

<style scoped>

</style>
