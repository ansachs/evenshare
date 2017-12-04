
if(!App.messages) {
  var curr_room = window.location.pathname.match(/concerts\/(\d*)/)[1];
  App.messages = App.cable.subscriptions.create(
    { channel: "RoomChannel", room: curr_room }, 
    {  
      received: function(data) {
        $("#messages").removeClass('hidden');
        $('[data-textarea="message"]').val(" ");
        console.log(data);
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
