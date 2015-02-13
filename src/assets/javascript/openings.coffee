addJobs = (job_data) ->
  posting_html = []
  index = 0
  for posting in job_data
    excerpt = $.trim(posting.description).split('\n')[0]
    location = posting.categories.location
    commitment = posting.categories.commitment
    team = posting.categories.team
    link = posting.hostedUrl

    if index is 0 || index%2 is 0
      posting_html.push('<div class="row">')

    posting_html.push(
      '<div class="job col-md-6 col-sm-12 col-xs-12">' +
          "<a class='job-title' href='#{link}'>#{posting.text}</a>" +
          "<p class='tags'><span>#{team}</span><span>#{location}</span><span>#{commitment}</span></p>" +
          "<p class='description'>#{excerpt}</p>" +
          "<a class='btn btn-primary' href='#{link}'>Learn more</a>" +
      '</div>'
    )

    if index != 0 && ((index+1)%2 is 0 || index is (job_data.length - 1))
      posting_html.push('</div>')

    index++
  $('.openings').html posting_html.join('')


$(document).ready ->
  $.ajax
    dataType: 'json'
    url: 'https://api.lever.co/v0/postings/aptible?mode=json'
    success: addJobs
