$(document).ready(function(){
  if($(".pagination .next_page").size() > 0){
    $(window).on('scroll', function(){
      more_posts_url = $('.pagination .next_page a').attr('href')
      if(more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60){
        fetch(more_posts_url)
        .then(response => response.json())
        .then(json => updateList(json));

        updateList(json);
      }
      return
    })
  }
});
