
import {AfterViewInit, Component, ComponentFactoryResolver, OnInit, Renderer, ViewChild} from "@angular/core";
import {AppService} from "./app.service";
import {Application} from "./Application";
import {AdItem} from "./ad-item";
import {AdService} from "./ad.service";
import {InputText} from "./input.text";
import {ContainerRow} from "./container.row";
import {UIComponent} from "./ui.component";
import {ViewDirective} from "./view.directive";
import {AdComponent} from "./ad.component";
import {LayoutDirective} from "./layout.directive";
import {ContainerComponent} from "./container-component";

@Component({
    selector: 'my-app',
    template: `
        <div style="position: relative;">
            <div *ngIf="application">
                <h1>{{application.name}} loaded</h1>
                <h1>{{application.contents.name}} </h1>
                <div>
                    <ul>
                        <li *ngFor="let menu of application.menus">{{menu.name}}</li>
                    </ul>
                </div>
                <div>
                    <ul>
                        <li *ngFor="let component of application.contents.children">{{component.name}}</li>
                    </ul>
                </div>
            </div>

            <ng-template view-body></ng-template>

            <div style="position: absolute; top: 0; left: 0; background: rgba(0, 0, 0, 0); border: 1px solid red; width: 500px;">
                <ng-template layout-editor></ng-template>
            </div>

            <button (click)="addContainer()">Add Container</button>
            
            <component-properties [(uiComponent)]="selectedComponent" [uiId]="selectedComponent.id"></component-properties>
        </div>
        
    `
})

export class AppComponent implements OnInit, AfterViewInit {
    // loading app configuration

    application:Application;

    ads: AdItem[];

    componentMap:Object;

    selectedComponent:UIComponent;

    @ViewChild(ViewDirective) viewBody:ViewDirective;

    @ViewChild(LayoutDirective) layoutEditor:LayoutDirective;

    constructor(
        private appService:AppService,
        private adService:AdService,
        private componentFactoryResoler:ComponentFactoryResolver
    ){};


    ngOnInit():void {
        this.getApplication();
        this.ads = this.adService.getAds();

        this.componentMap = {};

        this.componentMap['text'] = InputText;
        this.componentMap['div'] = ContainerRow;

        this.selectedComponent = new UIComponent();
    }

    getApplication():void {
        this.appService.getApplication("id").then(application => {
            this.application = application;
            this.loadComponent();
        });
        //this.appService.getApplication("id").then(application => console.log(application.name));
    }

    ngAfterViewInit():void {
        this.loadComponent();
    }

    loadComponent():void {
        if(this.application) {
            this.generateComponent(this.application.contents);
        }
    }

    generateComponent(component:UIComponent):void {
        console.log('generate Component ::' + component.type);
        console.log(this.componentMap);

        let componentFactory = this.componentFactoryResoler.resolveComponentFactory(this.componentMap[component.type])

        let viewContainerRef = this.viewBody.viewContainerRef;

        viewContainerRef.clear();

        let childComponent = viewContainerRef.createComponent(componentFactory);
        (<AdComponent>childComponent.instance).data = component;

    }

    addContainer():void {

        let componentFactory = this.componentFactoryResoler.resolveComponentFactory(ContainerRow);

        let layoutViewContainerRef = this.layoutEditor.viewContainerRef;

        var containerComponent = layoutViewContainerRef.createComponent(componentFactory);


        let c = new ContainerComponent();
        c.style = {height: '100px'};
        c.style["border"] = "1px solid blue";
        c.id = this.uuidv4();

        (<ContainerRow>containerComponent.instance).data = c;

        containerComponent.instance.selectCallBack = this.selectedCallBack;

    }

    selectedCallBack(uiComponent:UIComponent):void {
        console.log(uiComponent);
        this.selectedComponent = uiComponent;
    }

    uuidv4():string {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
            var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    }


}