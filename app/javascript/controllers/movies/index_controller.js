import BaseController from "../base_controller";
import consumer from "../../channels/consumer";

export default class extends BaseController {
  static values = {
    senderId: Number
  }

  connect() {
    this.subscription = consumer.subscriptions.create({ channel: "MoviesChannel" }, {
      connected: this._connected.bind(this),
      disconnected: this._disconnected.bind(this),
      received: this._received.bind(this),
    })
  }

  get flashMessagesController() {
    return this.findController("flash-messages", "components--flash-messages")
  }

  disconnect() {
    console.log("Disconnected to the MoviesChannel!");
    consumer.subscriptions.remove(this.subscription)
  }

  _connected() {
    console.log("Connected to the MoviesChannel!");
  }

  _disconnected() {
    console.log("Disconnected to the MoviesChannel!");
  }

  _received(data) {
    const listMessagesTarget = document.getElementById('list-messages-of-channel')
    this.element.insertAdjacentHTML('afterbegin', data.movie)

    if (data.sender.id !== this.senderIdValue) {
      this.flashMessagesController.flashesValue = [['notice', [`${data.sender.name} shared the video ${data.description}`]]]
      this.flashMessagesController.showFlashMessages()
    }
  }
}
