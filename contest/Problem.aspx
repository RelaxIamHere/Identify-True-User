<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Problem.aspx.cs" Inherits="Graduation_Project._Problem" MaintainScrollPositionOnPostBack = "true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <!--Meta-->
    <meta charset="utf-8" content=""/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>Project</title>
    <!--Code Mirror-->
    <link href="Scripts/codemirror-5.8/lib/codemirror.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/codemirror-5.8/theme/ambiance.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/codemirror-5.8/lib/codemirror.js" type="text/javascript"></script>
    <script src="Scripts/codemirror-5.8/mode/clike/clike.js" type="text/javascript"></script>
    <script src="Scripts/codemirror-5.8/addon/edit/matchbrackets.js" type="text/javascript"></script>
    <!--Boostrap-->
    <link href="Scripts/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js" type="text/javascript"></script>
    <script src="Scripts/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="Scripts/Programing_Lang.js" type="text/javascript"></script>
    <!--Remove Ads-->
    <script type="text/javascript">
        $(document).ready(function () {
            $("div[style='opacity: 0.9; z-index: 2147483647; position: fixed; left: 0px; bottom: 0px; height: 65px; right: 0px; display: block; width: 100%; background-color: #202020; margin: 0px; padding: 0px;']").remove();
            $("div[style='margin: 0px; padding: 0px; left: 0px; width: 100%; height: 65px; right: 0px; bottom: 0px; display: block; position: fixed; z-index: 2147483647; opacity: 0.9; background-color: rgb(32, 32, 32);']").remove();
            $("div[onmouseover='S_ssac();']").remove();
            $("center").remove();
        });
    </script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <form id="form1" runat="server" style="width: 100%;">
    <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span> 
      </button>
      <a class="navbar-brand" href="Default.aspx">Home</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a href="Problem.aspx">Categories</a></li>
        <li><a href="#">Contest</a></li> 
        <li><a href="#">Rank</a></li> 
        <li><a href="#">Leaderboard</a></li> 
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><span class="glyphicon glyphicon-user"></span> My Profile </a></li>
        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
      </ul>
    </div>
  </div>
    </nav>

    </form>
</body>
</html>
