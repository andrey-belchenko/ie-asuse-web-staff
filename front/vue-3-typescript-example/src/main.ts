import { createApp } from "vue";
import App from "@/App.vue";
import "bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";
import router from "@/router";
import "devextreme/dist/css/dx.light.css";

createApp(App).use(router).mount("#app");
