
import {AfterViewInit, Component, ComponentFactoryResolver, Input, OnDestroy, ViewChild} from "@angular/core";
import {AdDirective} from "./ad.directive";
import {AdItem} from "./ad-item";
import {AdComponent} from "./ad.component";

@Component({
    selector: 'add-banner',
    template:`
        <div class="ad-banner">
            <h3>Advertisements</h3>
            <ng-template ad-host></ng-template>
        </div>
    `,
})

export class AdBannerComponent implements AfterViewInit, OnDestroy {
    @Input() ads: AdItem[];
    currentAddIndex: number = -1;
    //
    @ViewChild(AdDirective) adHost: AdDirective;
    subscription: any;
    interval: any;

    constructor(private componentFactoryResoler:ComponentFactoryResolver){}

    ngAfterViewInit() {
        this.loadComponent();
        this.getAds();
    }

    ngOnDestroy() {
        clearInterval(this.interval);
    }

    loadComponent() {
        this.currentAddIndex = (this.currentAddIndex + 1) % this.ads.length;
        let adItem = this.ads[this.currentAddIndex];

        // component is Component definition
        // generate Component Factory
        let componentFactory = this.componentFactoryResoler.resolveComponentFactory(adItem.component);

        // fetch Template Container Reference;
        let viewContainerRef = this.adHost.viewContainerRef;
        viewContainerRef.clear();

        // View Component 생성
        let componentRef = viewContainerRef.createComponent(componentFactory);

        // view component에 데이터 설정
        (<AdComponent>componentRef.instance).data = adItem.data;
    }

    getAds() {
        this.interval = setInterval(() => {
            this.loadComponent();
        }, 3000);
    }
}