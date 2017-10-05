
import {Injectable} from "@angular/core";
import {Http} from "@angular/http";
import {Application} from "./Application";

import 'rxjs/add/operator/toPromise';

@Injectable()
export class AppService {
    private appUrl = "/restful/apps";
    private headers = new Headers({'Content-type': 'application/json'});
    constructor(private http:Http) {}

    getApplication(id:String):Promise<Application> {
        console.log('called....');
        const url = `${this.appUrl}/${id}`;
        return this.http.get(url).toPromise()
            .then(response => response.json() as Application)
            .catch(function() {
                console.error('An error occured');
            });

    }

}