jQuery ->
  $('#new_image').fileupload
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('#new_image').append(data.context)
        data.submit()
        $('#start-story-form').show()
      else
        alert("#{file.name} is not a gif, jpeg, or png image file")
    
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    
    done: (e, data) ->
      data.context.remove() if data.context # remove progress bar
    
    fail: (e, data) ->
      alert("#{data.files[0].name} failed to upload.")
      console.log("Upload failed:")
      console.log(data)