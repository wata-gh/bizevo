$ ->
  tmpls = null
  c_tmpls = null
  eid = null
  lid = null

  bind_event4feelings = ->
    $ '.ui.accordion'
    .accordion()
    $ 'form'
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
        id = s.data.split('&')[1].split('=')[1]
        s.urlData = {
          id: id,
        }
        s
      ,
      onSuccess: (r)->
        id = r.results.commented_id
        $("#js-feeling-#{id}-comments")
        .append c_tmpls(r.results)
        $("#js-feeling-#{id}").find('textarea').val('');
      onFailure: ->
        console.debug 'failure'
    }

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
        bind_event4feelings()
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
      if r.results.length
        lid = r.results[r.results.length - 1].id
        bind_event4feelings()
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

  pick_level = (tp, v)->
    f = $ ".js-feeling .js-#{tp}"
    f.find '.special.cards img.image:not(.disabled)'
    .addClass 'disabled'
    f.find "img.js-value-#{v}"
    .removeClass 'disabled'
    f.find '.card.blue'
    .removeClass 'blue'
    f.find ".card.js-value-#{v}"
    .addClass 'blue'
    f.find 'input[name=level]'
    .val v

  $ '.pointing.menu .item'
  .tab {
    context: '.feeling',
    auto: true,
    alwaysRefresh: true,
    cache: false,
    path: '/feeling',
    onTabLoad: (tp, pa, he)->
      $f = $ ".js-feeling .js-#{tp}"

      $ '.special.cards .image', ".js-feeling .js-#{tp}"
      .dimmer {
        on: 'hover'
      }
      $f.find '.button.select,.extra.content a'
      .on 'click', ->
        v = $ this
        .data 'value'
        pick_level tp, v

      $f.find 'form'
      .form {
        level: {
          identifier: 'level',
          rules: [
            type: 'empty',
            prompt: '気分を選択してください',
          ]
        },
        description: {
          identifier: 'description',
          rules: [
            type: 'empty',
            prompt: '進捗を記入してください',
          ]
        },
      }, {
        inline: true,
      }
      .api {
        action: 'update feeling',
        method: 'POST',
        serializeForm: true,
        beforeSend: (s)->
          s.urlData = {
          at: $f.find 'input[name=at]'
          .val(),
          }
          s.data = {
          description: $f.find 'textarea'
          .val(),
          level: $f.find 'input[name=level]'
          .val(),
          email: $f.find 'input[name=email]'
          .val(),
          }
          $f.addClass 'loading'
          s
        ,
        onSuccess: ->
          $f.removeClass 'loading'
          .slideUp 200
          .empty()
          .slideDown 0
          $tab = $ "a.item[data-tab=#{tp}]"
          txt = $tab.text()
          $tab.empty()
          .append $('<i class="checkmark icon"></i>')
          .append txt
        onFailure: ->
          $f.removeClass 'loading'
          .slideUp 200
          .empty()
          .slideDown 0
      }

      t = $f.find 'textarea'
      p = $f.find '.preview'
      $ document
      .on 'keyup', ".js-feeling .js-#{tp} textarea", {}, $.debounce 1000, ->
        if t.val().length == 0
          p
          .empty()
          .hide()
          .append $('<img class="ui wireframe image" src="/images/short-paragraph.png">')
          .fadeIn()
          return
        $.post '/api/feeling/wiki', {v: t.val()}, (r)->
          p.html r.results.html
  }

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

  $.ajax '/javascripts/views/comment.html'
  .success((r) ->
    c_tmpls = Handlebars.compile r
  )

  $.ajax '/javascripts/views/feelings.html'
  .success((r) ->
    tmpls = Handlebars.compile r
    init()
  )