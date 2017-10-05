
import {Directive, ViewContainerRef} from "@angular/core";

@Directive({
    selector: '[container]'
})

export class ContainerDirective {
    constructor(public viewContainerRef:ViewContainerRef){}
}