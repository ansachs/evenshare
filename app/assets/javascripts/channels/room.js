// console.log('running')
if(!App.messages) {
  var curr_room = window.location.pathname.match(/concerts\/(\d*)/)[1];
  // console.log(curr_concert)
  App.messages = App.cable.subscriptions.create({ channel: "RoomChannel", room: curr_room }, {  
    received: function(data) {
      $("#messages").removeClass('hidden')
      $('[data-textarea="message"]').val(" ")
      // return $('#messages').append(this.renderMessage(data));
      // console.log(data);
      
      // return $('#messages').append(data.chat);
      $('#messages').append(data.chat);
      this.scrollBottom();    
      // return false;
    },

    scrollBottom: function() {
      // console.log($('#chatbox').prop('scrollHeight'))
      chatBox = $('#chatbox');
      chatBox.scrollTop(chatBox.prop("scrollHeight"));
    }

    // renderMessage: function(data) {
    //   return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
    // }
  })};

// function scrollBottom(){
//   chatBox = $('#chatbox');
//   chatBox.scrollTop(chatBox.prop("scrollHeight"));
// }

