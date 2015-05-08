$ ->
  tmpls = null
  $.ajax '/javascripts/views/comment.html'
  .success((r) ->
    tmpls = Handlebars.compile r
    init()
  )

  init = ->
    $f = $ 'form'
    .form {
      comments: {
        identifier: 'comments',
        rules: [
          type: 'empty',
          prompt: 'コメントを記入してください',
        ]
      },
    }, {
      inline: true,
    }
    .api {
      action: 'update comment',
      method: 'POST',
      serializeForm: true,
      beforeSend: (s)->
        s.urlData = {
          id: $f.find 'input[name=id]'
          .val(),
        }
        s.data = {
          comments: $f.find 'textarea'
          .val(),
        }
        #    $f.addClass 'loading'
        s
      ,
      onSuccess: (r)->
        console.debug 'success'
        $ '.ui.comments'
        .append tmpls(r.results)
      onFailure: ->
        console.debug 'failure'
    }

  $ '#js-remove-btn'
  .on 'click', ->
    $ '#js-remove-confirm'
    .modal 'show'
  b = $ '.ui.green.basic.inverted.button.js-yes'
  .on 'click', ->
    $.ajax '/api/feeling/' + b.data('id'), {
      method: 'DELETE',
    }
    .done ->
      if history.length == 1
        window.close()
      else
        history.back()
