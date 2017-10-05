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
var WizardProperties = (function () {
    function WizardProperties() {
        this.uiComponent = new ui_component_1.UIComponent();
    }
    WizardProperties.prototype.ngOnChanges = function (changes) {
        console.log('ngOnChanges');
        for (var propName in changes) {
            var chng = changes[propName];
            var cur = JSON.stringify(chng.currentValue);
            var prev = JSON.stringify(chng.previousValue);
            console.log(propName + ": currentValue = " + cur + ", previousValue = " + prev);
        }
    };
    return WizardProperties;
}());
__decorate([
    core_1.Input(),
    __metadata("design:type", ui_component_1.UIComponent)
], WizardProperties.prototype, "uiComponent", void 0);
__decorate([
    core_1.Input(),
    __metadata("design:type", String)
], WizardProperties.prototype, "uiId", void 0);
WizardProperties = __decorate([
    core_1.Component({
        selector: 'component-properties',
        template: "\n        <div>\n            <ul *ngIf=\"uiComponent\">\n                <li><input [value]=\"uiComponent.id\"/></li>\n            </ul>\n        </div>\n    "
    })
], WizardProperties);
exports.WizardProperties = WizardProperties;
//# sourceMappingURL=wizard.properties.js.map