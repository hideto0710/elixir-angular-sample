import { Component } from '@angular/core';
import './styles.css';

interface Issue {
  id: number;
  url: string;
  repositoryUrl: string;
  labelsUrl: string;
  commentsUrl: string;
  htmlUrl: string;
  number: number;
  state: string;
  title: string;
  body: string;
}

@Component({
  selector: 'my-app',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  stacks: Issue[];

  constructor() {
    this.stacks = (<any>window).IssuesGlobal || [];
  }
}
