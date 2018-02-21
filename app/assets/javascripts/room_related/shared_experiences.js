
chatWelcome();


// $(document).on('turbolinks:load', function() {
//   console.log(window.location.pathname)
//   addTweets();
//   jcarouselControlls();
//   scrollBottom();
//   submitNewMessage();
//   // setInterval(addTweets, 60000);
  
// });

class someStuff extends HTMLElement {
  constructor() {
    super();
  }
    connectedCallback() {
      addTweets();
      jcarouselControlls();
      scrollBottom();
      setInterval(addTweets, 60000);
    
  }
}

customElements.define('some-stuff', someStuff);

document.body.appendChild(new someStuff);  

$(document).on('keydown', '[data-textarea="message"]', function(event) {
      if (event.keyCode == 13) {
          $('[data-send="message"]').click();
          event.preventDefault();
          $('[data-textarea="message"]').val("");
   }
})


function scrollBottom(){
  chatBox = $('#chatbox');
  chatBox.scrollTop(chatBox.prop("scrollHeight"));
}

function jcarouselControlls() {
  $('.jcarousel').jcarousel({
    animation: 'fast',
    wrap: 'circular'
  });
  $('.jcarousel-control-prev')
            .on('jcarouselcontrol:active', function() {
                $(this).removeClass('inactive');
            })
            .on('jcarouselcontrol:inactive', function() {
                $(this).addClass('inactive');
            })
            .jcarouselControl({
                target: '-=1'
            });

        $('.jcarousel-control-next')
            .on('jcarouselcontrol:active', function() {
                $(this).removeClass('inactive');
            })
            .on('jcarouselcontrol:inactive', function() {
                $(this).addClass('inactive');
            })
            .jcarouselControl({
                target: '+=1'
            });

        $('.jcarousel-pagination')
            .on('jcarouselpagination:active', 'a', function() {
                $(this).addClass('active');
            })
            .on('jcarouselpagination:inactive', 'a', function() {
                $(this).removeClass('active');
            })
            .jcarouselPagination();
}

function addTweets(){

    var curr_concert = window.location.pathname.match(/concerts\/(\d*)/)[1];
    fetch("/concerts/" + curr_concert + "/shared_experiences/tweet_feed")
    .then(function(response){ 
      if (!response.ok) {
          throw Error(response.statusText);
        } else {
          return(response.json());
        }
      })
    .then(
      function(json) {
        $('#no-tweets').remove()
        json.forEach(
          function(obj){postMessage(obj)}
          )
      })
    .catch(function(error) {});    

    
        
}

function postMessage(json) {
  if (document.querySelector("[name='" + json.twitterID + "']") === null) {
    var tweet_area = document.querySelector('#tweets');
    var new_tweet = document.createElement('div');
    new_tweet.classList.add('list-group-item')
    new_tweet.innerHTML = json.message;
    new_tweet.setAttribute('name', json.twitterID);
    tweet_area.prepend(new_tweet);
  }
}

function submitNewMessage(){
  $('[data-textarea="message"]').keydown(
    function(event) {
      if (event.keyCode == 13) {
          $('[data-send="message"]').click();
          event.preventDefault();
          $('[data-textarea="message"]').val("");
     }
  });
}

function scrollBottom(){
  chatBox = $('#chatbox');
  chatBox.scrollTop(chatBox.prop("scrollHeight"));
}

function chatWelcome() {
  welcome = document.createElement('p')
  welcome_message =  "<b class='font-weight-bold text-dark'>Gigshare:</b>Welcome to gigshare, chat about this great concert or share a link by pasting it in the chat box in the form: <br /> <b class='font-weight-bold text-dark'>http://www.youtube.com/embed/[youtube id]</b> <br /> <b class='font-weight-bold text-dark'>http://www.youtu.be/[youtube id]</b>"
  welcome.innerHTML = welcome_message;
  document.querySelector('#messages').append(welcome);
}

