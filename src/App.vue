<template>
  <div id='app'>
    <div class='content-wrapper' ref='contentRef' @click='handleOpenDia'>
      <div class='bg-box bg-blur'>
        <!--        <img src='./assets/bg.jpeg'>-->
      </div>
      <div class='container'>
        <h1 class='top'>神仙保佑🙏🙏🙏，追虎擒龙， 风水大师，得水为上，藏风次之。左青龙右白虎，前朱雀后玄武, 彩票开光，必中大奖🎉🎉🎉</h1>
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
            <el-button type='danger' @click='newNum'>手动生成</el-button>
            <el-button v-if='loading' type='danger' @click='newNumFunc' disabled>生成中</el-button>
            <el-button v-else type='danger' @click='newNumFunc'>自动生成</el-button>
            <el-button type='danger' @click='stopAutoFunc'>停止自定生成</el-button>
            <input class='date-box' type='date' v-model='date'>
            <el-button type='danger' @click='copyNum'>复制号码</el-button>
          </div>
          <img class='bagua' src='./assets/bagua.jpeg' @click.stop='show = true'>
          <van-image-preview v-model="show" :images="images">
            <!--            <template v-slot:index>第{{ index }}页</template>-->
          </van-image-preview>
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
        <div class='flex-sb'>
          <div class='taLeft'>
            <el-table
                    :data="allNum"
                    style="width: 80%"
                    highlight-current-row
                    @current-change="handleCurrentChange"
            >
              <el-table-column
                      type="index"
                      width="50">
              </el-table-column>
              <el-table-column
                      prop="front"
                      label="前区"
                      width="260">
                <template slot-scope="scope">
                  <span style="margin-left: 10px">{{scope.row.front }}</span>
                </template>
              </el-table-column>
              <el-table-column
                      prop="end"
                      label="后区"
                      width="180">
                <template slot-scope="scope">
                  <span style="margin-left: 10px">{{scope.row.end }}</span>
                </template>
              </el-table-column>
              <el-table-column
                      prop="date"
                      label="中奖日期"
                      width="120"
              >
              </el-table-column>
              <el-table-column
                      fixed="right"
                      label="操作"
                      width="120">
                <template slot-scope="scope">
                  <el-button
                          @click.native.prevent="handleDet(scope.$index, items)"
                          type="text"
                          size="small">
                    删除
                  </el-button>
                </template>
              </el-table-column>
            </el-table>
            <textarea cols="100" rows="1" ref="allNumRef" v-model='allNumString'
                      style='opacity: 0'>这里面的文本内容被复制 </textarea>
          </div>
          <div>
            <div>
              <el-select
                      v-model="front"
                      multiple
                      filterable
                      allow-create
                      default-first-option
                      placeholder="请选择前区号码"
                      style='width: 400px'
              >
                <el-option
                        v-for="item in 35"
                        :key="item"
                        :label="item < 10 ? '0' + item : item"
                        :value="item < 10 ? '0' + item : item">
                </el-option>
              </el-select>
            </div>
            <div>
              <el-select
                      v-model="end"
                      multiple
                      filterable
                      allow-create
                      default-first-option
                      placeholder="请选择后区号码">
                <el-option
                        v-for="item in 12"
                        :key="item"
                        :label="item < 10 ? '0' + item : item"
                        :value="item < 10 ? '0' + item : item">
                </el-option>
              </el-select>
            </div>
            <el-button size='small' @click='handleBi'>对比</el-button>
            <h3>所选号码应用历史中奖情况(07001~21084)共{{selectedNum.length}}期</h3>
            <div class='prize-box' v-if='num'>
              <el-tag type="success">
                <span v-if='num'>
                  <b style='margin-right: 5px'>所有中奖数: {{num}}个;</b>
                  <strong>中奖概率 {{(num/selectedNum.length * 100).toFixed(2) }} %</strong>
                </span>
                <span v-if='nine'>9等奖数: {{nine}}个</span>
                <span v-if='eight'>8等奖数: {{eight}}个</span>
                <span v-if='seven'>7等奖数: {{seven}}个</span>
                <span v-if='six'>6等奖数: {{six}}个</span>
                <span v-if='five'>5等奖数: {{five}}个</span>
                <span v-if='four'>4等奖数: {{four}}个</span>
                <span v-if='three'>3等奖数: {{three}}个</span>
                <span v-if='two'>2等奖数: {{two}}个</span>
                <span v-if='one'>1等奖数: {{one}}个</span>
              </el-tag>
            </div>
            <div class='prize-content' v-if='selectedNum.length>0'>
              <div v-for='(item, index) in selectedNum' :key='index'>
                <div v-if='item.level>0'>
                  <span>第{{item.no}}期：</span>
                  <span style='display: inline-block; width: 80px'>
                <span v-if='item.level > 0' style='color: red'>中{{item.level}}等奖</span>
                <span v-else>未中奖</span>
              </span>
                  <span style='margin-right: 20px'>前区：
                <span v-if='item.array[0].length>0'>
                  <span style='color: red'>{{item.array[0]}}</span>
                </span>
                <span v-else>无</span>
              </span>
                  <span>后区：
                 <span v-if='item.array[1].length>0'>
                  <span style='color: red'>{{item.array[1]}}</span>
                </span>
                <span v-else>无</span>
              </span>
                </div>
              </div>
            </div>
          </div>
        </div>
<!--        <div class='taCenter'>-->
<!--          <el-table-->
<!--                  :data="history"-->
<!--                  style="width: 90%; text-align: center; margin: 0 auto"-->
<!--                  highlight-current-row-->
<!--          >-->
<!--            <el-table-column label="前区">-->
<!--              <template v-for='(item, index) in 35'>-->
<!--                <table-item :key='index' :prop-name="item < 10 ? '0' + item : item.toString()" :label-name="item < 10 ? '0' + item : item.toString()"></table-item>-->
<!--              </template>-->
<!--            </el-table-column>-->
<!--            <el-table-column label="后区">-->
<!--              <template v-for='(item, index) in 47'>-->
<!--                <table-item v-if='item > 35' :key='index' :prop-name="item.toString()" :label-name='(item-35).toString()'></table-item>-->
<!--              </template>-->
<!--            </el-table-column>-->
<!--          </el-table>-->
<!--        </div>-->
        <div class='taCenter'>
          <img class='zhuque' src='./assets/zhuque.jpeg'>
        </div>

        <img class='baihu' src='./assets/baihu.jpeg'>
        <img class='qinglong' src='./assets/qinglong.jpeg'>

      </div>
    </div>
    <el-dialog
            title="提示"
            :visible.sync="dialogVisible"
            width="600px"
            :before-close="handleClose">
      <span>
       <div class="demo-input-suffix">
        请填写随机码(终身可用)
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
    <van-notice-bar left-icon="volume-o" :scrollable="false" class='notice-swipe-box'>
      <van-swipe
              vertical
              class="notice-swipe"
              :autoplay="3000"
              :show-indicators="false"
      >
        <van-swipe-item v-for='(item, index) in getLongList' :key='index'>🎉🎉🎉恭喜{{item.name}}喜中{{item.value}}🎉🎉🎉
        </van-swipe-item>
      </van-swipe>
    </van-notice-bar>
    <div>
      <img class='caishenye' src='./assets/caishenye.gif'>
      <img class='zhaocaimao' src='./assets/zhaocaimao.gif'>
    </div>
  </div>
</template>

<script>
  import {parseTime} from "./utils";
  import jsCookies from 'js-cookie'
  import {AllNum, randomMa, aaa, AllErNum} from "./utils/config";
  // import TableItem from "./components/table";

  export default {
    name: 'App',
    // components: {TableItem},
    // components: {TableItem},
    data() {
      return {
        frontArea: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35'],
        endArea: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
        getFrontArea: [],
        getEndArea: [],
        date: '',
        allNum: [],
        dialogVisible: false,
        randomMa: '',
        flag: false,
        getLongList: [],
        allNumString: [],
        content: [],
        show: false,
        index: 0,
        images: [require('./assets/bagua.jpeg')],
        timer: null,
        loading: false,
        selectNum: [],
        AllNum: AllNum,
        selectedNum: [],
        currentRow: null,
        front: [],
        end: [],
        num: 0, // 总中奖数
        nine: 0, // 9等奖中奖数
        eight: 0, // 8等奖中奖数
        seven: 0, // 7等奖中奖数
        six: 0, // 6等奖中奖数
        five: 0, // 5等奖中奖数
        four: 0, // 4等奖中奖数
        three: 0, // 3等奖中奖数
        two: 0, // 2等奖中奖数
        one: 0, // 1等奖中奖数
        history: [{}],
        aaa: aaa,
        AllErNum: AllErNum
      }
    },
    created() {
      // 总期数先转成json，再处理
      // this.getAAA()
      this.randomMa = jsCookies.get('randomMa')
      this.flag = !!this.randomMa
      if (process.env.NODE_ENV !== 'development') {
        window.oncontextmenu = function () {
          return false;
        }
        // 禁止任何键盘敲击事件（防止F12和shift+ctrl+i调起开发者工具）
        window.onkeydown = window.onkeyup = window.onkeypress = function (e) {
          var keyCode = e.keyCode || e.which || e.charCode;
          var ctrlKey = e.ctrlKey || e.metaKey;
          // console.log(keyCode, ctrlKey)
          if (event.code === 'F12' || ctrlKey && keyCode === 73 || keyCode === 123) {
            window.event.returnValue = false;
            return false;
          }
        }
      }

      this.date = parseTime(new Date().getTime(), '{y}-{m}-{d}')

      this.getLongList = [{
        name: '赵先生',
        value: '二等奖'
      }, {
        name: '刘女士',
        value: '三等奖'
      }, {
        name: '王小姐',
        value: '三等奖'
      }, {
        name: '周女士',
        value: '三等奖'
      }]
      // this.getStatic()

      // 赋值
      // for (let i = 1; i <= 47; i++) {
      //    i = i < 10 ? '0'+i : i.toString()
      //   this.history[0][i] = 0
      // }

      // this.calcSing()
    },
    methods: {
      getAAA() {
        this.aaa = this.aaa.map(value => {
          // value = value.slice(1, 8)
          value = {
            no: value[0],
            array: [value.slice(1, 6), value.slice(6, 8)]
          }
          return value
        }).reverse()
        console.log(JSON.stringify(this.aaa), 'this.aaa')
      },
      getStatic() {
        this.AllNum.map((val, i) => {
          return this.contrast(i, val.no, val.array, this.selectNum)
        })
        console.log(JSON.stringify(this.selectedNum), 'this.selectedNum')
        this.calcPrize()
      },
      contrast(i, no, array1, array2) {
        this.selectedNum.push({
          no: no,
          level: 0,
          prizeTotal: 0,
          array: [[], []],
          array2: [[], []],
        })
        array1[0].map((value) => {
          array2[0].map((val) => {
            if (value === val) {
              this.selectedNum[i].array[0].push(val)
            }
          })
        })
        array1[1].map((value) => {
          array2[1].map((val) => {
            if (value === val) {
              this.selectedNum[i].array[1].push(val)
            }
          })
        })
      },
      calcPrize() {
        // 计算中奖次数，即中什么奖
        this.selectedNum = this.selectedNum.map(value => {
          if (value.array[0].length === 1 && value.array[1].length === 2 ||
            value.array[0].length === 3 && value.array[1].length === 0 ||
            value.array[0].length === 2 && value.array[1].length === 1 ||
            value.array[0].length === 0 && value.array[1].length === 2) {
            value.level = 9
            this.num += 1
            this.nine += 1
          } else if (value.array[0].length === 2 && value.array[1].length === 2 ||
            value.array[0].length === 3 && value.array[1].length === 1) {
            value.level = 8
            this.num += 1
            this.eight += 1
          } else if (value.array[0].length === 4 && value.array[1].length === 0) {
            value.level = 7
            this.num += 1
            this.seven += 1
          } else if (value.array[0].length === 3 && value.array[1].length === 2) {
            value.level = 6
            this.num += 1
            this.six += 1
          } else if (value.array[0].length === 4 && value.array[1].length === 1) {
            value.level = 5
            this.num += 1
            this.five += 1
          } else if (value.array[0].length === 4 && value.array[1].length === 2) {
            value.level = 4
            this.num += 1
            this.four += 1
          } else if (value.array[0].length === 5 && value.array[1].length === 0) {
            value.level = 3
            this.num += 1
            this.three += 1
          } else if (value.array[0].length === 5 && value.array[1].length === 1) {
            value.level = 2
            this.num += 1
            this.two += 1
          } else if (value.array[0].length === 5 && value.array[1].length === 2) {
            value.level = 1
            this.num += 1
            this.one += 1
          } else {
            value.level = 0
          }
          return value
        })
      },
      newNumFunc() {
        this.loading = true
        this.timer = setInterval(() => {
          this.autoFunc()
        }, 2000)
      },
      stopAutoFunc() {
        clearInterval(this.timer)
        this.loading = false
      },
      autoFunc() {
        if (!this.flag) {
          return
        }
        if (this.getFrontArea.length <= 4) {
          let position = Math.floor((Math.random() * this.frontArea.length))
          let num = this.frontArea[position]
          this.frontArea.splice(position, 1)
          this.getFrontArea.push(num)
          this.getFrontArea.sort()
        } else if (this.getFrontArea.length >= 4 && this.getEndArea.length >= 0 && this.getEndArea.length < 2) {
          let position1 = Math.floor((Math.random() * this.endArea.length))
          let num1 = this.endArea[position1]
          this.endArea.splice(position1, 1)
          this.getEndArea.push(num1)
          this.getEndArea.sort()
        } else {
          this.allNum.push({
            date: this.date,
            front: this.getFrontArea,
            end: this.getEndArea
          })
          this.content.push(this.getFrontArea.join() + '|' + this.getEndArea.join())
          let frontAreaCopy = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35']
          let endAreaCopy = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
          this.frontArea = frontAreaCopy
          this.endArea = endAreaCopy
          this.getFrontArea = []
          this.getEndArea = []
          if (this.allNum.length >= 5) {
            clearInterval(this.timer)
            this.loading = false
          }
        }
      },
      newNum() {
        if (!this.flag) {
          return
        }
        if (this.getFrontArea.length <= 4) {
          let position = Math.floor((Math.random() * this.frontArea.length))
          let num = this.frontArea[position]
          this.frontArea.splice(position, 1)
          this.getFrontArea.push(num)
          this.getFrontArea.sort()
        } else if (this.getFrontArea.length >= 4 && this.getEndArea.length >= 0 && this.getEndArea.length < 2) {
          let position1 = Math.floor((Math.random() * this.endArea.length))
          let num1 = this.endArea[position1]
          this.endArea.splice(position1, 1)
          this.getEndArea.push(num1)
          this.getEndArea.sort()
        } else {
          this.allNum.push({
            date: this.date,
            front: this.getFrontArea,
            end: this.getEndArea
          })
          this.content.push(this.getFrontArea.join() + '|' + this.getEndArea.join())
          let frontAreaCopy = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35']
          let endAreaCopy = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
          this.frontArea = frontAreaCopy
          this.endArea = endAreaCopy
          this.getFrontArea = []
          this.getEndArea = []
        }
      },
      handleDet(index, items) {
        this.allNum.splice(index, 1)
        let deleteItem = items.front.join() + '|' + items.end.join()
        this.content = this.content.map(value => {
          value = value.replace('\n', '')
          return value
        })
        this.content = this.content.filter(val => val !== deleteItem)
      },
      handleClose() {
        this.dialogVisible = false
      },
      handleOpenDia() {
        this.dialogVisible = !this.flag;
        this.show = false
      },
      getMa() {
        window.location.href = 'https://www.xiaocifang.com/i/GOc7c9b8d86DV.html'
      },
      handleMa() {
        if (this.randomMa === randomMa) {
          jsCookies.set('randomMa', randomMa, {expires: 3})
          this.dialogVisible = false
          this.flag = true
          this.$message({
            message: '验证码正确，预祝您中的头彩',
            type: 'success'
          });
        } else {
          this.$message({
            message: '您输入的验证码错误，请点击链接获取验证码',
            type: 'warning'
          });
        }
      },
      copyNum() {
        if (this.allNum.length <= 0) {
          this.$message.error('先生成彩票号码再复制')
          return
        }

        this.content = this.content.map(val => {
          if (val.indexOf("\n") !== 0) {
            val = '\n' + val
            return val
          } else {
            return val
          }
        })

        this.allNumString = '风水大乐透_大乐透选号结果\n' + '中奖时间：' + this.date + '\n' + this.content + '\n\n以上数据来自风水大乐透; http://www.webrabbit.top' + '   ' + new Date().toLocaleString()

        setTimeout(() => {
          this.$refs.allNumRef.select()
          document.execCommand("Copy");
          this.$message.success('复制成功, 财神爷保佑🙏🙏🙏，此号码必中大奖')
        }, 100)
      },
      handleCurrentChange(val) {
        this.currentRow = val;
        this.reset()
        this.selectNum = [val.front, val.end]
        this.getStatic()
      },
      handleBi() {
        this.reset()
        this.selectNum = [this.front, this.end]
        this.getStatic()
      },
      reset() {
        this.selectedNum = []
        this.num = 0 // 总中奖数
        this.nine = 0 // 9等奖中奖数
        this.eight = 0 // 8等奖中奖数
        this.seven = 0 // 7等奖中奖数
        this.six = 0 // 6等奖中奖数
        this.five = 0 // 5等奖中奖数
        this.four = 0 // 4等奖中奖数
        this.three = 0 // 3等奖中奖数
        this.two = 0 // 2等奖中奖数
        this.one = 0 // 1等奖中奖数
      },

      // 历史个数字出现的概率
      calcSing() {
        for (let i = 0; i < this.AllErNum.length; i++) {
          this.singFun(i, this.AllErNum[i])
        }
        // return this.singFun(i, val)
      },
      singFun(i, val) {
        val.map((value) => {
          if(i < 10) {
            for (let ii = 1; ii <= 35; ii++) {
              ii = ii < 10 ? '0'+ii : ii.toString()
              this.copyFun(ii, value)
            }
          }
        })
      },
      copyFun(i, value) {
        // console.log(value, i)
        if(value === i) {
          this.history[0][i] += 1
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
    width: 100%;
    min-width: 1200px;
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
    margin-left: 125px;
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
    margin-top: 20px;
    width: 200px;
  }

  .zhuque {
    /*position: fixed;*/
    /*bottom: 20px;*/
    /*left: 50%;*/
    /*margin-left: -100px;*/
  }

  .baihu {
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
    filter: blur(40px);
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

  .notice-swipe-box {
    position: absolute;
    top: 100px;
    left: 90px;
    width: 260px;
  }

  .notice-swipe {
    height: 40px;
    line-height: 40px;
  }

  .caishenye {
    position: absolute;
    top: 40px;
    right: 320px;
    width: 120px;
  }

  .zhaocaimao {
    position: absolute;
    top: 50px;
    right: 140px;
    width: 100px;
  }

  .date-box {
    margin: 0 20px;
  }

  .delete-box {
    margin-left: 10px !important;
  }

  .result-item {
    margin-bottom: 10px;
  }

  .bagua {
    display: block;
    width: 120px;
    text-align: center;
    margin: 0 auto;
  }

  .flex-sb {
    display: flex;
    justify-content: flex-start;
    align-items: flex-start;
  }
  .el-select {
    margin-bottom: 10px;
  }
  .el-input {
    width: 400px !important;
  }
  .prize-content {
    height: 400px;
    overflow: auto;
  }
  .prize-box span {
    margin-right: 10px;
  }
</style>
