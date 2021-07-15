<template>
  <div id='app'>
    <div class='content-wrapper' ref='contentRef' @click.prevent='handleOpenDia'>
      <div class='bg-box bg-blur'>
        <!--      <img src='./assets/bg.jpeg'>-->
      </div>
      <div class='container'>
        <h1 class='top'>神仙保佑🙏，追虎擒龙， 风水大师，得水为上，藏风次之。左青龙右白虎，前朱雀后玄武, 彩票开光，必中大奖🎉🎉🎉</h1>
        <h1 class='title'>风水大乐透预测</h1>
        <div class='taCenter'>
          <img class='xuanwu' src='./assets/xuanwu.jpeg'>
        </div>

        <div class='taCenter'>
          <div>
            <h3 class='front-area' v-for='(item, index) in frontArea' :key='index'>
              {{item}}
            </h3>
          </div>
          <div class='endArea'>
            <h3 class='front-area' v-for='(item, index) in endArea' :key='index'>
              {{item}}
            </h3>
          </div>
          <div>
            <button @click.prevent='newNum'>点击生成</button>
            <input type='date' v-model='date' >
          </div>
        </div>
        <div class='taLeft'>
          <div class='get-item'>
            <span>中奖日期：</span>
            <span class='get-area'>{{date}}</span>
          </div>
          <div class='get-item'>
            <span>前区：</span>
            <span class='get-area' v-for='(item, index) in getFrontArea' :key='index'>{{item}}</span>
          </div>
          <div class='get-item'>
            <span>后区：</span>
            <span class='get-area' v-for='(item, index) in getEndArea' :key='index'>{{item}}</span>
          </div>
        </div>

        <div class='content-box'>
          <div class='taLeft'>
            <div v-for='(items, index) in allNum' :key='index'>
              <span>(第{{index+1}}个号码)</span>
              前区：<span class='get-area' v-for='(item, index) in items.front' :key='index'>{{item}}</span>
              后区：<span class='get-area' v-for='(item, index) in items.end' :key='index'>{{item}}</span>
              中奖日期：<span>{{date}}</span>
              <button @click='handleDet(index)'>删除</button>
            </div>
          </div>
          <div class='taCenter'>
            <img class='zhuque' src='./assets/zhuque.jpeg'>
          </div>
        </div>

        <img class='baihu' src='./assets/baihu.jpeg'>
        <img class='qinglong' src='./assets/qinglong.jpeg'>

      </div>
    </div>
    <el-dialog
            title="提示"
            :visible.sync="dialogVisible"
            width="30%"
            :before-close="handleClose">
      <span>
       <div class="demo-input-suffix">
        请填写随机码：
        <el-input
                placeholder="请填写随机码"
                v-model="randomMa">
        </el-input>
      </div>
      </span>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click='getMa'>点击获取随机码</el-button>
        <el-button @click="handleMa">确 定</el-button>
       </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'App',
  data() {
    return {
      frontArea: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35'],
      endArea: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
      getFrontArea: [],
      getEndArea: [],
      date: new Date().toLocaleDateString().replace(/\//g, '-'),
      allNum: [],
      dialogVisible: false,
      randomMa: '',
      flag: false
    }
  },
  created() {
    window.oncontextmenu=function(){return false;}
    // 禁止任何键盘敲击事件（防止F12和shift+ctrl+i调起开发者工具）
    window.onkeydown = window.onkeyup = window.onkeypress = function (event) {
      if(event.code === 'F12'){
        window.event.returnValue = false;
        return false;
      }
    }
  },
  methods: {
    newNum() {
      if(!this.flag) {
        return
      }
      if (this.getFrontArea.length <= 5) {
        let position = Math.floor((Math.random()* this.frontArea.length))
        let num = this.frontArea[position]
        this.frontArea.splice(position, 1)
        this.getFrontArea.push(num)
        this.getFrontArea.sort()
      }else if(this.getFrontArea.length >=5 && this.getEndArea.length >=0 &&  this.getEndArea.length < 2) {
        let position1 = Math.floor((Math.random()* this.endArea.length))
        let num1 = this.endArea[position1]
        this.endArea.splice(position1, 1)
        this.getEndArea.push(num1)
        this.getEndArea.sort()
      }else {
        this.allNum.push({
          front: this.getFrontArea,
          end:  this.getEndArea
        })
        let frontAreaCopy = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35']
        let endAreaCopy = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
        this.frontArea = frontAreaCopy
        this.endArea = endAreaCopy
        this.getFrontArea = []
        this.getEndArea = []
      }
    },
    handleDet(index) {
      this.allNum.splice(index, 1)
    },
    handleClose() {
      this.dialogVisible = false
    },
    handleOpenDia() {
      this.dialogVisible = !this.flag;
    },
    getMa() {
      window.location.href = 'https://www.xiaocifang.com/i/GOc7c9b8d86DV.html'
    },
    handleMa() {
      if(this.randomMa === '392042') {
        this.dialogVisible = false
        this.flag = true
        this.$message({
          message: '验证码正确，预祝您中的头彩',
          type: 'success'
        });
      }else {
        this.$message({
          message: '您输入的验证码错误，请点击链接获取验证码',
          type: 'warning'
        });
      }
    }
  }

}
</script>

<style>
  h1, h3 {
    margin: 0;
    padding: 0;
  }
  * {
    margin: 0;
    padding: 0;
  }
#app {
  position: relative;
  height: 100vh;
}
.top {
  display: block;
  text-align: center;
  font-size: 24px;
}
.title {
  text-align: center;
  font-size: 20px;
}

.taCenter {
  text-align: center;
}
.front-area {
  display: inline-block;
  margin-right: 10px;
  color: brown;
}

.taLeft {
  margin-left: 200px;
  margin-top: 10px;
}

.get-item {
  margin-bottom: 10px;
  color: red;
}

.get-area {
  margin-right: 10px;
}

.zhuque, .xuanwu {
  width: 200px;
}
.zhuque {
  position: fixed;
  bottom: 20px;
  left: 50%;
  margin-left: -100px;
}

.baihu  {
  position: absolute;
  left: 0;
  top: 300px;
  width: 120px;
}

.qinglong {
  position: absolute;
  right: 0;
  top: 340px;
  width: 120px;
}

  .content-box {
    height: 100px;
    overflow: auto;
    /*position: absolute;*/
  }
  .endArea {
    margin: 10px auto;
  }
  .container {
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    z-index: 10;
  }
  .bg-blur {
    float: left;
    width: 100%;
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    filter: blur(6px);
  }
  .bg-box {
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
  }
  .bg-box img {
    width: 100%;
    height: 100vh;
  }
  .el-input {
    display: inline-block !important;
    width: 200px !important;
  }

</style>
