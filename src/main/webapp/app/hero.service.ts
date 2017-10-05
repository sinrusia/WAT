import { Injectable } from '@angular/core';
import { Hero } from './hero';
import { Headers, Http} from "@angular/http";

import 'rxjs/add/operator/toPromise';

@Injectable()
export class HeroService {
    private heroesUrl = '/restful/heroes'
    private headers = new Headers({'Content-type': 'application/json'});

    constructor(private http: Http) {}

    getHeroes(): Promise<Hero[]> {
        return this.http.get(this.heroesUrl)
            .toPromise()
            //.then(response => console.log(response.json()))
            .then(response => response.json() as Hero[])
            .catch(this.handleError);
    }

    getHero(id:Number): Promise<Hero> {
        const url = `${this.heroesUrl}/${id}`;
        return this.http.get(url)
            .toPromise()
            .then(response => response.json() as Hero)
            .catch(this.handleError);
    }

    update(hero:Hero): Promise<Hero> {
        const url = `${this.heroesUrl}/${hero.id}`;
        return this.http.put(url, JSON.stringify(hero), {headers:this.headers})
            .toPromise()
            .then(() => hero)
            .catch(this.handleError);
    }

    create(name:string): Promise<Hero> {
        return this.http.post(this.heroesUrl, JSON.stringify({name:name}), {headers: this.headers})
            .toPromise()
            .then(res => res.json() as Hero)
            .catch(this.handleError);
    }

    delete(id:Number): Promise<void> {
        const url = `${this.heroesUrl}/${id}`;
        return this.http.delete(url)
            .toPromise()
            .then(() => null)
            .catch(this.handleError);
    }

    private handleError(error: any): Promise<any> {
        console.error('An error occured');
        return Promise.reject(error.message || error);
    }
}
