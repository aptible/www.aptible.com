addJobs = (job_data) ->
  posting_html = []

  for posting in job_data
    excerpt = $.trim(posting.descriptionPlain).split('\n')[0]
    location = posting.categories.location
    commitment = posting.categories.commitment
    team = posting.categories.team
    link = posting.hostedUrl

    posting_html.push([
      '<div class="card grid-item">',
        '<div class="card__header">',
          '<h3 class="card__subtitle">',
            team, ' ', location, ' ', commitment,
          '</h3>',
          '<h2 class="card__title">', posting.text, '</h2>',
        '</div>',
        '<div class="card__body">',
          '<p>',
            excerpt,
          '</p>',
          '<p>',
            '<a class="arrow-link--right" href="', link, '">Learn More</a>',
          '</p>',
        '</div>',
      '</div>'].join(''))

  $('.openings').html posting_html.join('')

$(document).on 'turbolinks:load', ->
  if $('.openings').length > 0
    $.ajax
      dataType: 'json'
      url: 'https://api.lever.co/v0/postings/aptible?mode=json'
      success: addJobs
