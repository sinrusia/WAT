import { Component }    from '@angular/core';


@Component({
  selector: 'my-app',
    template: `
      <h1>{{title}}</h1>
      <nav>
        <a routerLink="/dashboard" routerLinkActive="active">Dashboard</a>
        <a routerLink="/heroes" routerLinkActive="active">Heroes</a>
        <a routerLink="/dashboard" routerLinkActive="active">프레임 편집</a>
        <a routerLink="/heroes" routerLinkActive="active">메뉴 편집</a>
        <a routerLink="/heroes" routerLinkActive="active">화면 편집</a>
      </nav>
      <router-outlet></router-outlet>
    `,
    styleUrls: ['./app.component.css']
})

export class AppComponent {

    title = 'Tour of Heroes';

    // layout 정보 로딩
    // 다양한 레이아웃을 정의하며 Application은 하나의 레이아웃만을 가진다.
    // 레이아웃 편집
    // 메뉴 편집
    // 화면 편집
    // 분야에 따라서 따로 편집을 진행 해야 한다.

    // 레이아웃 편집하고 가져오는 부분부터 개발한다.
}
