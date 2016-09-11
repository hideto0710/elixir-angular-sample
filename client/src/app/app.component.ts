import { Component, OnInit } from '@angular/core';
import Issue from "./issue";
import './styles.css';
import { Channel } from "phoenix";
import { Socket } from "phoenix";

@Component({
  selector: 'my-app',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  stacks: Issue[];
  issueText: string;
  messages: string[];
  messageText: string;

  channel: Channel;

  constructor() {
    this.stacks = (<any>window).IssuesGlobal || [];
    this.issueText = '';
    this.messages = [];
    this.messageText = '';
  }

  ngOnInit() {
    const socket = new Socket("/socket", { params: { token: '' } });
    socket.connect();
    this.channel = socket.channel("room:lobby", {});
    this.channel.on("new_msg", payload => {
      this.addMessage(`<br/>[${Date()}] ${payload.body}`);
    });
    this.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) });
  }

  addMessage(message: string) {
    this.messages.push(message)
  }

  onMessageInputEnter(event: KeyboardEvent) {
    this.channel.push("new_msg", {body: (<HTMLInputElement>event.target).value});
    this.messageText = '';
  }

  onIssueInputEnter(event: KeyboardEvent) {
    this.channel.push("new_issue", { body: (<HTMLInputElement>event.target).value });
    this.issueText = '';
  }
}
