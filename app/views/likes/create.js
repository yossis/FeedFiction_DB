$("#like-<%=@story.id%> ").html("<%= escape_javascript(render('stories/like_actions' , :story => @story ))%>");
