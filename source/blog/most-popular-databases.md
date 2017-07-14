---
title: The Most Popular Databases in Digital Health
excerpt: "How are some of the newest applications in digital health being built?"
author_name: Sam Yount
author_email: sam@aptible.com
author_id: sam
posted: 2015-10-27
section: Blog
posts: true
type: blog post
---
*This is the second in a series of blog posts exploring the state of the digital health landscape from a technical perspective.  Our first post on [popular languages](https://www.aptible.com/blog/most_popular_languages_in_digital_health.html) has already proven to be one of our most read blog posts.  If there are other analysis you would like to see on the state of digital health, please get [in touch](https://www.aptible.com/company/contact/)*

One of the things we have noticed in working with a variety of digital health companies is that there is much more willingness to explore database technologies when architechting a new application.  While developing in a new language typically takes a serious investment and will greatly slow initial progress, a different database variant may present lots of benefits with a minimal learning curve.  As such, I expect we'll see some interesting trends emerge as we repeat this survey over the coming months and years.

For this survey, we examined the database layer for applications deployed on Aptible. The pupulation of databases is limited by what Aptible (and AWS) support. That said, we are very quick to add support for any database requested by users.

<div id="piechart"></div>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
  google.load("visualization", "1", {packages:["corechart"]});
  google.setOnLoadCallback(drawChart);
  function drawChart() {
    var data = google.visualization.arrayToDataTable([
      ['Database', 'Percentage'],
      ['PostgreSQL',            45.4],
      ['Redis',         20.8],
      ['MongoDB',          12.3],
      ['MySQL',              12.0],
      ['CouchDB',             0.3],
      ['RethinkDB',               0.2]
    ]);

    var options = {
      colors: ['#dc3912', '#36c', '#f90', '#109618', '#909', '#0099c6'],
      height: 350,
      pieSliceText: 'label',
      tooltip: { text: 'percentage' }
    };

    var chart = new google.visualization.PieChart(document.getElementById('piechart'));
    chart.draw(data, options);
  }
</script>

As this is the first time we have collected this data, we can’t make any definitive claims about trends. However, DB-Engine is a great source for [trends in database popularity](http://db-engines.com/en/ranking). [Their methodology](http://db-engines.com/en/ranking_definition), however is much squishier than our directly measured metrics.

<table style="margin: 0 0 20px 25%;" class="simple-ranking-table">
  <thead>
    <tr><th colspan="2">DB-Engine October 2015 Ranking</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>Oracle</td></tr>
    <tr><td>2</td><td>MySQL</td></tr>
    <tr><td>3</td><td>Microsoft SQL</td></tr>
    <tr><td>4</td><td>MongoDB</td></tr>
    <tr><td>5</td><td>PostgreSQL</td></tr>
    <tr><td>6</td><td>DB2</td></tr>
    <tr><td>7</td><td>Microsoft Access</td></tr>
    <tr><td>8</td><td>Cassandra</td></tr>
    <tr><td>9</td><td>SQLite</td></tr>
    <tr><td>10</td><td>Redis</td></tr>

  </tbody>
</table>

The most interesting difference in these lists is with Redis.  The Aptible data is based on web and mobile applications while the DB-Engine list is based on a much broader variety of factors.  So Redis may make more sense for the types of applications currently "hot" in the health tech world.  It'll be interesting to see how the list changes and whether the Aptible list is a leading indicator of rapidly growing Redis popularity.
