jQuery ->
 if $('.pagination').length 
  $(window).scroll ->
    url = $('.pagination .next_page a').attr('href')
    if url != undefined && url.length>1 &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
      $('.pagination').text('Fetching more stories...')
      $.getScript(url)
  $(window).scroll