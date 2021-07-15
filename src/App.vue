<template>
  <div id='app'>
  <h1 class='top'>神仙保佑🙏，追虎擒龙， 风水大师，得水为上，藏风次之。左青龙右白虎，前朱雀后玄武</h1>
  <h1 class='title'>大乐透预测</h1>
  <div class='taCenter'>
    <img class='xuanwu' src='./assets/xuanwu.jpeg'>
  </div>
  <div class='taCenter'>
    <div>
      <h3 class='front-area' v-for='(item, index) in frontArea' :key='index'>
        {{item}}
      </h3>
    </div>
    <div>
      <h3 class='front-area' v-for='(item, index) in endArea' :key='index'>
        {{item}}
      </h3>
    </div>
    <div>
      <button @click='newNum'>点击生成</button>
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

  <img class='baihu' src='./assets/baihu.jpeg'>
  <img class='qinglong' src='./assets/qinglong.jpeg'>

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
      allNum: []
    }
  },
  methods: {
    newNum() {
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
    }
  }

}
</script>

<style>
#app {
  position: relative;
}
.top {
  display: block;
  text-align: center;
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
  margin-top: 30px;
}

.get-item {
  margin-bottom: 20px;
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

</style>
