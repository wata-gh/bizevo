$ ->
  $.ajaxPrefilter( (options, originalOptions, xhr) ->
    if !options.crossDomain
      token = $('meta[name="csrf-token"]').attr 'content'
      if token
        xhr.setRequestHeader 'X-CSRF-Token', token
  )
  $.fn.api.settings.api = {
    'update feeling': '/api/feeling/{at}',
    'update comment': '/api/feeling/{id}/comment',
  }
  $ '.message .close'
  .on 'click', ->
    $ this
    .closest '.message'
    .fadeOut()
