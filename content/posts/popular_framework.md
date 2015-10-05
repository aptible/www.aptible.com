---
title: Digital Health’s Most Popular Frameworks
excerpt: "Working exclusively with companies in the digital health space, we are regularly asked about the technical trends in the space and one of the more common questions goes something like, “I’m thinking about building my new app in Go.  Are you seeing other companies use it?”"
author_name: Sam Yount
author_email: sam@aptible.com
author_id: sam
posted: 2015-10-01
section: Blog
posts: true
---
*This is the first in a series of blog posts exploring the state of the digital health landscape from a technical perspective.*

Working exclusively with companies in the digital health space, we are regularly asked about the technical trends in the space and one of the more common questions goes something like, “I’m thinking about building my new app in Go.  Are you seeing other companies use it?”  As a deployment platform for nearly 100 (as of October 2015) digital health companies with over 550 deployed applications, we have visibility into a fairly large sample.

Our methodology for the survey is fairly simple.  We make language determinations based on  Git repos deployed on Aptible.  We have made an effort to only include the primary production applications and exclude any helper or logging apps--the [ELK logging stack](https://www.elastic.co/products) is popular, but that doesn’t tell you much about how applications are being built.

Finally, a caveat, we make no claims about this being the de facto survey of the digital health space.  It’s only as accurate as the data source.  

<div id="piechart"></div>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
  google.load("visualization", "1", {packages:["corechart"]});
  google.setOnLoadCallback(drawChart);
  function drawChart() {
    var data = google.visualization.arrayToDataTable([
      ['Language', 'Percentage'],
      ['Ruby',            41.3],
      ['Node.js',         33.2],
      ['Python',          12.6],
      ['PHP',              8.1],
      ['Java',             3.5],
      ['Go',               1.3]
    ]);

    var options = {
      colors: ['#dc3912', '#36c', '#f90', '#109618', '#909', '#0099c6'],
      //colors: ['#054d9f', '#0762cb', '#0865cf', '#669ddc', '#adc0d7', '#cce1f9'],
      //colors: ['#cc342d', '#80bd01', '#ffd343', '#4f5b93', '#333', '#375eab'],
      height: 350,
      pieSliceText: 'label',
      tooltip: { text: 'percentage' }
    };

    var chart = new google.visualization.PieChart(document.getElementById('piechart'));
    chart.draw(data, options);
  }
</script>

As this is the first time we have collected this data, we can’t make any definitive claims about trends.  That said there are a couple similar surveys done on broader audiences, [RedMonk survey on popular programming languages](http://redmonk.com/sogrady/2015/07/01/language-rankings-6-15/) and [BuiltWith’s Framework Usage Statistics](http://trends.builtwith.com/framework) The differences are somewhat illustrative.  

<table class="simple-ranking-table">
  <thead>
    <tr><th colspan="2">RedMonk Rank</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>JavaScript</td></tr>
    <tr><td>2</td><td>Java</td></tr>
    <tr><td>3</td><td>PHP</td></tr>
    <tr><td>4</td><td>Python</td></tr>
    <tr><td>5</td><td>C#</td></tr>
    <tr><td>6</td><td>C++</td></tr>
    <tr><td>7</td><td>Ruby</td></tr>
    <tr><td>8</td><td>CSS</td></tr>
    <tr><td>9</td><td>C</td></tr>
    <tr><td>10</td><td>Objective-C</td></tr>
    <tr><td>11</td><td>Perl</td></tr>
    <tr><td>12</td><td>Shell</td></tr>
    <tr><td>13</td><td>R</td></tr>
    <tr><td>14</td><td>Scala</td></tr>
    <tr><td>15</td><td>Go</td></tr>
  </tbody>
</table>
<table class="simple-ranking-table clearfix">
  <thead>
    <tr><th colspan="2">BuiltWith Top 10k</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>PHP</td>
    <tr><td>2</td><td>ASP.NET</td>
    <tr><td>3</td><td>J2EE</td>
    <tr><td>4</td><td>ASP.NET Ajax</td>
    <tr><td>5</td><td>Ruby on Rails Token</td>
    <tr><td>6</td><td>Shockwave Flash Embed</td>
    <tr><td>7</td><td>Ruby on Rails</td>
    <tr><td>8</td><td>ASP.NET MVC</td>
    <tr><td>9</td><td>Adobe Dreamweaver</td>
    <tr><td>10</td><td>Classic ASP</td>
    <tr><td>11</td><td>Adobe ColdFusion</td>
    <tr><td>12</td><td>Express</td>
    <tr><td>13</td><td>DAV</td>
    <tr><td>14</td><td>Django CSRF</td>
    <tr><td>15</td><td>Telerik Controls</td>
  </tbody>
</table>
