import {NgModule} from "@angular/core";

import {RouterModule, Routes} from "@angular/router";
import {DashboardComponent} from "./dashboard.component";
import {HeroDetailComponent} from "./hero-detail.component";
import {HeroesComponent} from "./heroes.component";

/**
 * Created by gojaehag on 2017. 7. 13..
 */

const routes: Routes = [
    {path: '', redirectTo: '/heroes', pathMatch: 'full'},
    {path: 'dashboard', component: DashboardComponent},
    {path: 'detail/:id', component: HeroDetailComponent},
    {path: 'heroes', component: HeroesComponent}

];

@NgModule({
    imports: [
        RouterModule.forRoot(routes)
    ],
    exports: [
        RouterModule
    ]
})

export class AppRoutingModule {}