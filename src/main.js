import Vue from 'vue'
import App from './App.vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

Vue.config.productionTip = false

Vue.use(ElementUI)


import Vant from 'vant';
import 'vant/lib/index.css';

Vue.use(Vant);

new Vue({
  render: h => h(App),
}).$mount('#app')
