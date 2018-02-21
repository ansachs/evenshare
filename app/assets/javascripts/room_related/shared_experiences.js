
chatWelcome();


$(document).ready(function(){
  addTweets();
  submitNewMessage();
  jcarouselControlls();
  scrollBottom();
  setInterval(addTweets, 60000);
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
  $('#submit-text').submit(
    
    function(e) {
      e.preventDefault();
      const curr_concert = window.location.pathname.match(/concerts\/(\d*)/)[1];
      const url = '/concerts/' + curr_concert + '/shared_experiences';
      const text = $('[data-textarea="message"]').val()
      const token = $('[name="authenticity_token"]').first().val()

      fetch(url, {
        method: 'POST',
        credentials: 'include',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-TOKEN': token
        },
        body: JSON.stringify({message: {statement: text}, concert_id: curr_concert})
      }).then((response) => {
        if (response.redirected == true) {
          $('.notice').html("please register or login before chatting")
          $('[data-textarea="message"]').val("")
          setTimeout(function(){document.querySelector('.notice').innerHTML = ""},10000);
        }
      }).catch( err =>{console.log(err)})
      return false;
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

