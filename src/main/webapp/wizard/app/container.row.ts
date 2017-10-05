
import {
    AfterViewInit, Component, ComponentFactoryResolver, ElementRef, Input, OnChanges, Renderer,
    ViewChild
} from "@angular/core";
import {AdComponent} from "./ad.component";
import {UIComponent} from "./ui.component";
import {InputText} from "./input.text";
import {ViewDirective} from "./view.directive";
import {Node} from "@angular/compiler";

@Component({
    template: `
        <div class="container container-row" style="position: relative;"
        (click)="selectHandler()">
            <ng-template view-body></ng-template>
        </div>
    `,
    styleUrls: ['../../css/container-row.css']
})

export class ContainerRow implements AdComponent, AfterViewInit {
    //
    @Input() data:UIComponent;

    @ViewChild(ViewDirective) viewContainer:ViewDirective;

    public selectCallBack:Function;

    constructor(private componentFactoryResolver:ComponentFactoryResolver, private renderer:Renderer, private element: ElementRef) {}

    ngAfterViewInit() {
        console.log('ngAfterViewInit');
        console.log(this.data);
        // generate children
        if(this.data && this.data.children) {
            this.viewContainer.viewContainerRef.clear();
            for(var i = 0; i < this.data.children.length; i++) {
                this.generateChildComponent(this.data.children[i]);
            }
        }

        if(this.data && this.data.style) {
            for (let key in this.data.style) {
                this.element.nativeElement.children[0].style[key] = this.data.style[key];
            }
        }
    }

    generateChildComponent(component:UIComponent) {
        let componentFactory = this.componentFactoryResolver.resolveComponentFactory(InputText);

            let childComponent = this.viewContainer.viewContainerRef.createComponent(componentFactory);

        (<AdComponent>childComponent.instance).data = component;

    }

    selectHandler():void {
        if(this.selectCallBack) {
            this.selectCallBack(this.data);
            console.log(this.data.id);
        }
    }

}