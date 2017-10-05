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
var ui_component_1 = require("./ui.component");
var input_text_1 = require("./input.text");
var view_directive_1 = require("./view.directive");
var ContainerRow = (function () {
    function ContainerRow(componentFactoryResolver, renderer, element) {
        this.componentFactoryResolver = componentFactoryResolver;
        this.renderer = renderer;
        this.element = element;
    }
    ContainerRow.prototype.ngAfterViewInit = function () {
        console.log('ngAfterViewInit');
        console.log(this.data);
        // generate children
        if (this.data && this.data.children) {
            this.viewContainer.viewContainerRef.clear();
            for (var i = 0; i < this.data.children.length; i++) {
                this.generateChildComponent(this.data.children[i]);
            }
        }
        if (this.data && this.data.style) {
            for (var key in this.data.style) {
                this.element.nativeElement.children[0].style[key] = this.data.style[key];
            }
        }
    };
    ContainerRow.prototype.generateChildComponent = function (component) {
        var componentFactory = this.componentFactoryResolver.resolveComponentFactory(input_text_1.InputText);
        var childComponent = this.viewContainer.viewContainerRef.createComponent(componentFactory);
        childComponent.instance.data = component;
    };
    ContainerRow.prototype.selectHandler = function () {
        if (this.selectCallBack) {
            this.selectCallBack(this.data);
            console.log(this.data.id);
        }
    };
    return ContainerRow;
}());
__decorate([
    core_1.Input(),
    __metadata("design:type", ui_component_1.UIComponent)
], ContainerRow.prototype, "data", void 0);
__decorate([
    core_1.ViewChild(view_directive_1.ViewDirective),
    __metadata("design:type", view_directive_1.ViewDirective)
], ContainerRow.prototype, "viewContainer", void 0);
ContainerRow = __decorate([
    core_1.Component({
        template: "\n        <div class=\"container container-row\" style=\"position: relative;\"\n        (click)=\"selectHandler()\">\n            <ng-template view-body></ng-template>\n        </div>\n    ",
        styleUrls: ['../../css/container-row.css']
    }),
    __metadata("design:paramtypes", [core_1.ComponentFactoryResolver, core_1.Renderer, core_1.ElementRef])
], ContainerRow);
exports.ContainerRow = ContainerRow;
//# sourceMappingURL=container.row.js.map