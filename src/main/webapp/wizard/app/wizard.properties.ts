
import {Component, Input, OnChanges, SimpleChanges} from "@angular/core";
import {UIComponent} from "./ui.component";

@Component({
    selector: 'component-properties',
    template:`
        <div>
            <ul *ngIf="uiComponent">
                <li><input [value]="uiComponent.id"/></li>
            </ul>
        </div>
    `
})

export class WizardProperties implements OnChanges{

    @Input() uiComponent:UIComponent = new UIComponent();

    @Input() uiId:String;

    ngOnChanges (changes: SimpleChanges) {
        console.log('ngOnChanges');
        for (let propName in changes) {
            let chng = changes[propName];
            let cur  = JSON.stringify(chng.currentValue);
            let prev = JSON.stringify(chng.previousValue);
            console.log(`${propName}: currentValue = ${cur}, previousValue = ${prev}`)
        }
    }
}