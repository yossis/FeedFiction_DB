jQuery ->
  $('#new_image').fileupload
  	dataType: "script"
  	add: (e, data) ->
      
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('#new_image').append(data.context)
        data.submit()
        if $('#start-story-container #start-story-form').length>0
          $('#start-story-form').appendTo($('#UploadModal'))
        $('#start-story-form').show()
      else
        alert("#{file.name} is not a gif, jpeg, or png image file")

    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      data.context.remove() if data.context # remove progress bar
