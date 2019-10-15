import consumer from "./consumer"

consumer.subscriptions.create("ProductsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // REFACTOR: Will have bad effects if store class is used anywhere else
    let storeElements = document.getElementsByClassName('store');
    if (storeElements && storeElements.length > 0) {
      storeElements[0].innerHTML = data.html;
    }
    //document.getElementsByTagName("main")[0].innerHTML = data.html;
  }
});
