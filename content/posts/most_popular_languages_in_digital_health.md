---
title: The Most Popular Languages in Digital Health
excerpt: "Do you ever wonder how other healthcare companies build their technology?"
author_name: Sam Yount
author_email: sam@aptible.com
author_id: sam
posted: 2015-10-06
section: Blog
posts: true
---
*This is the first in a series of blog posts exploring the state of the digital health landscape from a technical perspective.*

Working exclusively with companies in digital health, we are regularly asked about technical trends. One common question is, "What types of languages and frameworks do you see the most?"  As a deployment platform for nearly 100 (as of October 2015) digital health companies with over 550 deployed applications, we have some interesting data.

For this survey, we examined the primary language for apps deployed on Aptible. We have tried to only include primary production apps and exclude any helper or logging apps (e.g., the [ELK logging stack](https://www.elastic.co/products) is a popular utility to run on Aptible, but doesn’t us much about the main app.) Finally, of course, these data only represent apps deployed on Aptible, so  ASP.NET-specific languages are not represented.

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

As this is the first time we have collected this data, we can’t make any definitive claims about trends. There are other sources of data for the general tech community, such as [RedMonk's survey](http://redmonk.com/sogrady/2015/07/01/language-rankings-6-15/) on popular programming languages and [BuiltWith’s Framework Usage Statistics](http://trends.builtwith.com/framework).

<table class="simple-ranking-table">
  <thead>
    <tr><th colspan="2">RedMonk Language Ranks</th></tr>
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
    <tr><th colspan="2">BuiltWith Top 10k - Frameworks</th></tr>
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

Ruby and JavaScript dominate the Aptible sample, which makes sense because Aptible is used primarily to deploy web apps and mobile APIs. PHP is also popular, as it is on the open web. Java and PHP are used less frequently on Aptible than on the open web. To speculate, this may be because many Aptible apps were built recently, whereas top 10k sites may be older, with more legacy code.
