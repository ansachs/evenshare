// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('turbolinks:load', function() {
  // scrollBottom();
  addTweets();  
  console.log('score')
  scrollBottom();
  jcarouselControlls();
  submitNewMessage();
  setInterval(addTweets, 30000);
  
});



function scrollBottom(){
  // console.log($('test'))
  chatBox = $('#chatbox');
  chatBox.scrollTop(chatBox.prop("scrollHeight"));
}

function jcarouselControlls() {
  $('.jcarousel').jcarousel({
    animation: 'fast',
    wrap: 'circular'
  });
  $('.jcarousel').jcarouselAutoscroll({
    interval: 3000
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
    console.log("add tweets was run")
    var curr_concert = window.location.pathname.match(/concerts\/(\d*)/)[1];
    fetch(`/concerts/${curr_concert}/shared_experiences/tweet_feed`)
    .then((response) => (response.json()))
    .then((json)=>(json.forEach((obj)=>postMessage(obj))))
          
}

function postMessage(json) {
  console.log(json.twitterID)
  // console.log(document.querySelector("[name='${json.twitterID}']"))
  if (document.querySelector("[name=" + json.twitterID + "]") === null) {
    console.log(json.twitterID)
    let tweet_area = document.querySelector('#tweets');
    let new_tweet = document.createElement('div');
    new_tweet.classList.add('list-group-item')
    new_tweet.innerHTML = json.message;
    console.log(json.twitterID)
    new_tweet.setAttribute('name', json.twitterID);
    tweet_area.prepend(new_tweet);
  }

}

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
