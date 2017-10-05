
import {Component, Input} from "@angular/core";
import {AdComponent} from "./ad.component";

@Component({
    template: `
        <div class="hero-provile">
            <h3>Featured Hero Profile</h3>
            <strong>Hire this hero today!</strong>
        </div>
    `
})

export class HeroProfileComponent implements AdComponent {
    @Input() data: any;
}