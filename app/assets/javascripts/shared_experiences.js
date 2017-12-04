
chatWelcome();
addTweets(); 

$(document).on('turbolinks:load', function() {
  
  
  jcarouselControlls();
  scrollBottom();
  submitNewMessage();
  
  // uncomment below to initiate polling for tweets
  // setInterval(addTweets, 5000);
  
});



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
    .then(function(response) {return response.json()})
    .then(function(json) {json.forEach(function(obj){postMessage(obj)})})    
}

function postMessage(json) {
  if (document.querySelector("[name='" + json.twitterID + "']") === null) {
    let tweet_area = document.querySelector('#tweets');
    let new_tweet = document.createElement('div');
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
          // return false;
     }
  });
}

function scrollBottom(){
  chatBox = $('#chatbox');
  chatBox.scrollTop(chatBox.prop("scrollHeight"));
}

function chatWelcome() {
  welcome = document.createElement('p')
  // welcome_message = "test"
  welcome_message =  "<b class='font-weight-bold text-dark'>Gigshare:</b>Welcome to gigshare, chat about this great concert or share a link by pasting it in the chat box in the form <b class='font-weight-bold text-dark'>http://www.youtube.com/embed/[youtube id]:</b>"
  welcome.innerHTML = welcome_message;
  document.querySelector('#messages').append(welcome);
}

