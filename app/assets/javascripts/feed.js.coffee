jQuery ->
  $(window).scroll ->
    if $(window).scrollTop() > $(document).height() - $(window).height() - 50
      $.getScript($('.pagination .next_page').attr('href'))