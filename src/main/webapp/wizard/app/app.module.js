"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var core_1 = require("@angular/core");
var app_component_1 = require("./app.component");
var platform_browser_1 = require("@angular/platform-browser");
var forms_1 = require("@angular/forms");
var app_service_1 = require("./app.service");
var http_1 = require("@angular/http");
var hero_job_ad_component_1 = require("./hero-job-ad.component");
var hero_profile_component_1 = require("./hero-profile.component");
var ad_banner_component_1 = require("./ad-banner.component");
var ad_directive_1 = require("./ad.directive");
var ad_service_1 = require("./ad.service");
var container_row_1 = require("./container.row");
var input_text_1 = require("./input.text");
var view_directive_1 = require("./view.directive");
var layout_directive_1 = require("./layout.directive");
var wizard_properties_1 = require("./wizard.properties");
var AppModule = (function () {
    function AppModule() {
    }
    return AppModule;
}());
AppModule = __decorate([
    core_1.NgModule({
        imports: [
            platform_browser_1.BrowserModule,
            forms_1.FormsModule,
            http_1.HttpModule
        ],
        declarations: [
            app_component_1.AppComponent,
            ad_banner_component_1.AdBannerComponent,
            hero_job_ad_component_1.HeroJobAdComponent,
            hero_profile_component_1.HeroProfileComponent,
            ad_directive_1.AdDirective,
            container_row_1.ContainerRow,
            input_text_1.InputText,
            view_directive_1.ViewDirective,
            layout_directive_1.LayoutDirective,
            wizard_properties_1.WizardProperties
        ],
        providers: [
            app_service_1.AppService,
            ad_service_1.AdService
        ],
        entryComponents: [
            hero_job_ad_component_1.HeroJobAdComponent,
            hero_profile_component_1.HeroProfileComponent,
            container_row_1.ContainerRow,
            input_text_1.InputText
        ],
        bootstrap: [app_component_1.AppComponent]
    })
], AppModule);
exports.AppModule = AppModule;
//# sourceMappingURL=app.module.js.map