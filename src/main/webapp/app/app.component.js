"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var core_1 = require("@angular/core");
var AppComponent = (function () {
    function AppComponent() {
        this.title = 'Tour of Heroes';
        // layout 정보 로딩
        // 다양한 레이아웃을 정의하며 Application은 하나의 레이아웃만을 가진다.
        // 레이아웃 편집
        // 메뉴 편집
        // 화면 편집
        // 분야에 따라서 따로 편집을 진행 해야 한다.
        // 레이아웃 편집하고 가져오는 부분부터 개발한다.
    }
    return AppComponent;
}());
AppComponent = __decorate([
    core_1.Component({
        selector: 'my-app',
        template: "\n      <h1>{{title}}</h1>\n      <nav>\n        <a routerLink=\"/dashboard\" routerLinkActive=\"active\">Dashboard</a>\n        <a routerLink=\"/heroes\" routerLinkActive=\"active\">Heroes</a>\n        <a routerLink=\"/dashboard\" routerLinkActive=\"active\">\uD504\uB808\uC784 \uD3B8\uC9D1</a>\n        <a routerLink=\"/heroes\" routerLinkActive=\"active\">\uBA54\uB274 \uD3B8\uC9D1</a>\n        <a routerLink=\"/heroes\" routerLinkActive=\"active\">\uD654\uBA74 \uD3B8\uC9D1</a>\n      </nav>\n      <router-outlet></router-outlet>\n    ",
        styleUrls: ['./app.component.css']
    })
], AppComponent);
exports.AppComponent = AppComponent;
//# sourceMappingURL=app.component.js.map