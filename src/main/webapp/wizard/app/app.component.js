"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var core_1 = require("@angular/core");
var app_service_1 = require("./app.service");
var ad_service_1 = require("./ad.service");
var input_text_1 = require("./input.text");
var container_row_1 = require("./container.row");
var ui_component_1 = require("./ui.component");
var view_directive_1 = require("./view.directive");
var layout_directive_1 = require("./layout.directive");
var container_component_1 = require("./container-component");
var AppComponent = (function () {
    function AppComponent(appService, adService, componentFactoryResoler) {
        this.appService = appService;
        this.adService = adService;
        this.componentFactoryResoler = componentFactoryResoler;
    }
    ;
    AppComponent.prototype.ngOnInit = function () {
        this.getApplication();
        this.ads = this.adService.getAds();
        this.componentMap = {};
        this.componentMap['text'] = input_text_1.InputText;
        this.componentMap['div'] = container_row_1.ContainerRow;
        this.selectedComponent = new ui_component_1.UIComponent();
    };
    AppComponent.prototype.getApplication = function () {
        var _this = this;
        this.appService.getApplication("id").then(function (application) {
            _this.application = application;
            _this.loadComponent();
        });
        //this.appService.getApplication("id").then(application => console.log(application.name));
    };
    AppComponent.prototype.ngAfterViewInit = function () {
        this.loadComponent();
    };
    AppComponent.prototype.loadComponent = function () {
        if (this.application) {
            this.generateComponent(this.application.contents);
        }
    };
    AppComponent.prototype.generateComponent = function (component) {
        console.log('generate Component ::' + component.type);
        console.log(this.componentMap);
        var componentFactory = this.componentFactoryResoler.resolveComponentFactory(this.componentMap[component.type]);
        var viewContainerRef = this.viewBody.viewContainerRef;
        viewContainerRef.clear();
        var childComponent = viewContainerRef.createComponent(componentFactory);
        childComponent.instance.data = component;
    };
    AppComponent.prototype.addContainer = function () {
        var componentFactory = this.componentFactoryResoler.resolveComponentFactory(container_row_1.ContainerRow);
        var layoutViewContainerRef = this.layoutEditor.viewContainerRef;
        var containerComponent = layoutViewContainerRef.createComponent(componentFactory);
        var c = new container_component_1.ContainerComponent();
        c.style = { height: '100px' };
        c.style["border"] = "1px solid blue";
        c.id = this.uuidv4();
        containerComponent.instance.data = c;
        containerComponent.instance.selectCallBack = this.selectedCallBack;
    };
    AppComponent.prototype.selectedCallBack = function (uiComponent) {
        console.log(uiComponent);
        this.selectedComponent = uiComponent;
    };
    AppComponent.prototype.uuidv4 = function () {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    };
    return AppComponent;
}());
__decorate([
    core_1.ViewChild(view_directive_1.ViewDirective),
    __metadata("design:type", view_directive_1.ViewDirective)
], AppComponent.prototype, "viewBody", void 0);
__decorate([
    core_1.ViewChild(layout_directive_1.LayoutDirective),
    __metadata("design:type", layout_directive_1.LayoutDirective)
], AppComponent.prototype, "layoutEditor", void 0);
AppComponent = __decorate([
    core_1.Component({
        selector: 'my-app',
        template: "\n        <div style=\"position: relative;\">\n            <div *ngIf=\"application\">\n                <h1>{{application.name}} loaded</h1>\n                <h1>{{application.contents.name}} </h1>\n                <div>\n                    <ul>\n                        <li *ngFor=\"let menu of application.menus\">{{menu.name}}</li>\n                    </ul>\n                </div>\n                <div>\n                    <ul>\n                        <li *ngFor=\"let component of application.contents.children\">{{component.name}}</li>\n                    </ul>\n                </div>\n            </div>\n\n            <ng-template view-body></ng-template>\n\n            <div style=\"position: absolute; top: 0; left: 0; background: rgba(0, 0, 0, 0); border: 1px solid red; width: 500px;\">\n                <ng-template layout-editor></ng-template>\n            </div>\n\n            <button (click)=\"addContainer()\">Add Container</button>\n            \n            <component-properties [(uiComponent)]=\"selectedComponent\" [uiId]=\"selectedComponent.id\"></component-properties>\n        </div>\n        \n    "
    }),
    __metadata("design:paramtypes", [app_service_1.AppService,
        ad_service_1.AdService,
        core_1.ComponentFactoryResolver])
], AppComponent);
exports.AppComponent = AppComponent;
//# sourceMappingURL=app.component.js.map