/**
 * Created by gojaehag on 2017. 6. 30..
 */
import { Component, OnInit } from '@angular/core';
import { Hero } from './hero';
import { HeroService } from './hero.service';

@Component({
    selector: 'my-dashboard',
    templateUrl: './dashboard.component.html',
    styleUrls: ['./dashboard.component.css']
})

export class DashboardComponent implements OnInit {
    heroes: Hero[];

    constructor(private heroService:HeroService) {};

    ngOnInit(): void {

        this.heroService.getHeroes().then(
            heroes => this.heroes = heroes.slice(1, 5));
            //heroes => console.log(heroes) );

    }
}