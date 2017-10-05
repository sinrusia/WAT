
import {Injectable} from "@angular/core";
import {AdItem} from "./ad-item";
import {HeroProfileComponent} from "./hero-profile.component";
import {HeroJobAdComponent} from "./hero-job-ad.component";

@Injectable()

export class AdService {
    getAds() {
        return [
            new AdItem(HeroProfileComponent, {name: 'Bombasto', bio: 'Brave as they come'}),
            new AdItem(HeroJobAdComponent, {name: 'D IQ', bio: 'Smart as they come'})
        ]
    }
}