
var curr_room = window.location.pathname.match(/concerts\/(\d*)/)[1];

if(!App.messages || (JSON.parse(App.messages.identifier).room !== curr_room)) {
  
  App.messages = App.cable.subscriptions.create(
    { channel: "RoomChannel", room: curr_room }, 
    {  
      received: function(data) {
        $("#messages").removeClass('hidden');
        $('[data-textarea="message"]').val(" ");
          if (data.media) {
            $('#media-browser').append(data.media);
            $('.jacrousel').jcarousel('reload')
          } else {
            $('#messages').append(data.chat);
            this.scrollBottom();   
          }
      },
      scrollBottom: function() {
        chatBox = $('#chatbox');
        chatBox.scrollTop(chatBox.prop("scrollHeight"));
      }
    }
  )
};
