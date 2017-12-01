// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('turbolinks:load', function() {
  // scrollBottom();  
  scrollBottom();
  jcarouselControlls();
  // setInterval(addTweets, 10000);
        

});



function scrollBottom(){
  console.log($('test'))
  chatBox = $('#chatbox');
  chatBox.scrollTop(chatBox.prop("scrollHeight"));
}

function jcarouselControlls() {
  $('.jcarousel').jcarousel();
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
    let curr_concert = window.location.pathname.match(/concerts\/(\d*)/)[1];
    fetch(`/concerts/${curr_concert}/shared_experiences/tweet_feed`)
    .then((response) => (response.json()))
    .then((json)=>(json.forEach((obj)=>postMessage(obj))))
          
}

function postMessage(json) {
  let tweet_area = document.querySelector('#tweets');
  let new_tweet = document.createElement('div');
  new_tweet.innerHTML = json.message;
  tweet_area.prepend(new_tweet)
}
