import Vue from 'vue';
import { Component } from 'vue-property-decorator';

@Component
export default class ReportComponent extends Vue {
    report: string = 'Matrix';
    url: string = '';
    show: boolean = false;

    Clicked() {
        if (this.report != null) {
            this.show = true;
            this.url = "api/SampleData/DisplayReport?name=" + this.report;
        }
    }
}