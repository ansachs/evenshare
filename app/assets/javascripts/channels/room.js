// console.log('running')

App.messages = App.cable.subscriptions.create('RoomChannel', {  
  received: function(data) {
    $("#messages").removeClass('hidden')
    // return $('#messages').append(this.renderMessage(data));
    console.log(data);
    return $('#messages').append(data.chat);
  },

  // renderMessage: function(data) {
  //   return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
  // }
});


