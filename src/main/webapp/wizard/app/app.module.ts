
import {NgModule} from "@angular/core";
import {AppComponent} from "./app.component";
import {BrowserModule} from "@angular/platform-browser";
import {FormsModule} from "@angular/forms";
import {AppService} from "./app.service";
import {HttpModule} from "@angular/http";
import {HeroJobAdComponent} from "./hero-job-ad.component";
import {HeroProfileComponent} from "./hero-profile.component";
import {AdBannerComponent} from "./ad-banner.component";
import {AdDirective} from "./ad.directive";
import {AdService} from "./ad.service";
import {ContainerRow} from "./container.row";
import {InputText} from "./input.text";
import {ViewDirective} from "./view.directive";
import {LayoutDirective} from "./layout.directive";
import {WizardProperties} from "./wizard.properties";

@NgModule ({
    imports: [
        BrowserModule,
        FormsModule,
        HttpModule
    ],
    declarations : [
        AppComponent,
        AdBannerComponent,
        HeroJobAdComponent,
        HeroProfileComponent,
        AdDirective,
        ContainerRow,
        InputText,
        ViewDirective,
        LayoutDirective,
        WizardProperties
    ],
    providers: [
        AppService,
        AdService
    ],
    entryComponents: [
        HeroJobAdComponent,
        HeroProfileComponent,
        ContainerRow,
        InputText
    ],
    bootstrap: [AppComponent]
})

export class AppModule {

}