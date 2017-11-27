// $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) -> 
//       console.log(event)
//       event.preventDefault() 
//       if event.keyCode is 13 # return/enter = send

//         App.room.speak event.target.value 
//         event.target.value = ''
//         console.log('wtf') 

// $(document).on('turbolinks:load', function() {
//   submitNewMessage();
// });

// function submitNewMessage(){
  // $('document').keydown(function(event) {
  //   if (event.keyCode == 13) {
  //       App.room.speak event.target.value 
  //       event.target.value = ''
  //    }
  // });

$(document).on('turbolinks:load', function() {
  // scrollBottom();  
  submitNewMessage();

});

function submitNewMessage(){
  // console.log('test')
  $('[data-textarea="message"]').keydown(function(event) {
    if (event.keyCode == 13) {
        $('[data-send="message"]').click();
        return false;
     }
  });
}

function scrollBottom(){
  console.log($('test'))
  chatBox = $('#chatbox');
  chatBox.scrollTop(chatBox.prop("scrollHeight"));
}
