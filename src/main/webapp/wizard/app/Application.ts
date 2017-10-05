import {Menu} from "./Menu";
import {UIComponent} from "./ui.component";

export class Application {

    // primary key
    id:string;

    // application name
    name:string;

    // application menu list
    menus:Menu[];

    // application configuration
    contents:UIComponent;
}