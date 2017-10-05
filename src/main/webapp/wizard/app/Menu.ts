export class Menu {

    // memu primary key
    id:String;

    // menu name & display name
    name:String;

    // link url
    url:String;

    // menu type
    type:String;

    // 하위 메뉴 목록
    childrens:Menu[];
}