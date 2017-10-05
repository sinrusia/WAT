
import {Directive, ViewContainerRef} from "@angular/core";

@Directive({
    selector:'[view-body]'
})

export class ViewDirective {
    constructor(public viewContainerRef:ViewContainerRef){}
}