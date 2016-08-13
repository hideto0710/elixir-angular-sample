import { Component } from '@angular/core';
import './styles.css';

import "phoenix_html";
import { Socket } from "phoenix";
let socket = new Socket("/socket", {params: {token: ''}});
socket.connect();
let channel = socket.channel("room:lobby", {});
channel.on("new_msg", payload => {
  console.log(payload);
});
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) });

@Component({
  selector: 'my-app',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {

}
