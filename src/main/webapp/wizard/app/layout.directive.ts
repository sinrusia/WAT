
import {Directive, ViewContainerRef} from "@angular/core";

@Directive({
    selector: '[layout-editor]'
})

export class LayoutDirective {
    constructor(public viewContainerRef:ViewContainerRef){}
}