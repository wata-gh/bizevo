$ ->
  tmpls = null
  eid = null
  lid = null
  bind = ->
    params = window
    .location
    .search
    .substring 1
    .split '&'

    par = {
      id: eid
    }
    for eles in params
      ele = eles.split '='
      n = decodeURIComponent ele[0]
      v = decodeURIComponent ele[1]
      par[n] = v
    $.get '/api/feeling/bind', par
    .success((r) ->
      $ '#feelings'
      .prepend tmpls(r)
      if r.results.length
        eid = r.results[0].id
        if lid == null
          lid = r.results[r.results.length - 1].id
    )
    .done(->
      setTimeout bind, 10000
    )

  loading = 0
  more = ->
    return if loading
    params = window
    .location
    .search
    .substring 1
    .split '&'

    par = {
      last_id: lid,
    }
    for eles in params
      ele = eles.split '='
      n = decodeURIComponent ele[0]
      v = decodeURIComponent ele[1]
      par[n] = v
    loading = 1
    $.get '/api/feeling/more', par
    .success((r) ->
      $ '#feelings'
      .append tmpls(r)
      lid = r.results[r.results.length - 1].id if r.results.length
    )
    .done ->
      loading = 0

  init = ->
    setTimeout bind, 0
    $ window
    .bottom {proximity: 0.05}
    .on('bottom', more)


  $ 'select.dropdown'
  .dropdown()

  $ '#js-project'
  .on 'change', ->
    pid = $(this).val()
    $ '#feelings'
    .empty()
    eid = null
    lid = null
    history
    .pushState '', null, '/feeling?project_id=' + pid
    bind()

  $.ajax '/javascripts/views/feelings.html'
  .success((r) ->
    tmpls = Handlebars.compile r
    init()
  )