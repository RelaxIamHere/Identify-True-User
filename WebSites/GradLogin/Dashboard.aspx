<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Dashboard.aspx.cs" Inherits="_Dashboard" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<%
    string username = Membership.GetUser().UserName;
    if (!string.IsNullOrEmpty(Request.QueryString["u"]))
        username = Request.QueryString["u"];
%>
<asp:SqlDataSource ID="ActivityDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT TOP 10 Submission.Language, Submission.Date, Map.QuestionName, Map.Category, Submission.Score 
        FROM Map INNER JOIN Submission ON Map.Question = Submission.Question
        WHERE Submission.Username=@Username
        ORDER BY Submission.Date DESC"></asp:SqlDataSource>
<asp:SqlDataSource ID="NewCategoryDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT COUNT(DISTINCT Category) AS NewCategory 
                       FROM Map WHERE (Category NOT IN
                        (SELECT Map_1.Category FROM Map AS Map_1 
                         INNER JOIN Submission ON Map_1.Question = Submission.Question
                         WHERE(Submission.Username = @Username)))"></asp:SqlDataSource>
<asp:SqlDataSource ID="NewQuestionDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT COUNT(Id) AS NewQuestion 
                       FROM Map WHERE (Question NOT IN
                        (SELECT Map_1.Question FROM Map AS Map_1 
                         INNER JOIN Submission ON Map_1.Question = Submission.Question
                         WHERE (Submission.Username = @Username)))"></asp:SqlDataSource>
<asp:SqlDataSource ID="ScoreDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT TOP 4 a.Score, b.MaxScore FROM 
                        (SELECT SUM(Score) AS Score FROM Submission WHERE 
                        (Username = @Username)) AS a CROSS JOIN 
                        (SELECT COUNT(Id) * 100 AS MaxScore FROM Map AS MaxScore) AS b"></asp:SqlDataSource>
<asp:SqlDataSource ID="TasksDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT b.Score, a.MaxScore, a.Category FROM
                        (SELECT COUNT(Category) * 100 AS MaxScore, Category FROM
                            Map GROUP BY Category) AS a INNER JOIN
                        (SELECT SUM(Submission.Score) AS Score, Map_1.Category FROM
                            Map AS Map_1 INNER JOIN Submission ON Map_1.Question = Submission.Question
                            WHERE (Submission.Username = @Username) GROUP BY Map_1.Category) 
                         AS b ON a.Category = b.Category"></asp:SqlDataSource>
<body>
<div id="wrapper">
        <div id="page-wrapper">
            <div class="row">

            
                    <div style="right:0; position:absolute; overflow:hidden;">
                        <br />   
                        <div id="g1" style="height:100px; width:100px;"></div>
                    </div>

                <div class="col-lg-12" style="width:75%; float:left">
                    <h1 class="page-header"><%=username%></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-tasks fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                    <%  NewCategoryDataSource.SelectParameters.Add("Username",username); %>
                                    <%  System.Data.DataView dv = (System.Data.DataView)NewCategoryDataSource.Select(new DataSourceSelectArguments());%>
                                    <%=dv.Table.Rows[0]["NewCategory"].ToString() %>
                                    </div>
                                    <div>New Categories!</div>
                                </div>
                            </div>
                        </div>
                        <a href="#">
                            <div class="panel-footer">
                                <span class="pull-left">Challenge!</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-green">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-question-circle fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                    <%  NewQuestionDataSource.SelectParameters.Add("Username",username); %>
                                    <%  dv = (System.Data.DataView)NewQuestionDataSource.Select(new DataSourceSelectArguments());%>
                                    <%=dv.Table.Rows[0]["NewQuestion"].ToString() %>
                                    </div>
                                    <div>New Questions!</div>
                                </div>
                            </div>
                        </div>
                        <a href="#">
                            <div class="panel-footer">
                                <span class="pull-left">Challenge!</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-list-alt fa-fw"></i> Recent Activity
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body" style="width:auto;">
                            <div class="table-responsive table-bordered">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Challenge</th>
                                            <th>Category</th>
                                            <th>Language</th>
                                            <th>Score</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <%  ActivityDataSource.SelectParameters.Add("Username",username); %>
                                    <%  dv = (System.Data.DataView)ActivityDataSource.Select(new DataSourceSelectArguments());%>
                                    <%   foreach (System.Data.DataRow row in dv.Table.Rows)
                                         {%>
                                        <tr>
                                            <%  string prefix = "";
                                                int day = DateTime.Parse(row["Date"].ToString()).Day;
                                                if (day.ToString().EndsWith("11")) prefix = "th";
                                                if (day.ToString().EndsWith("12")) prefix = "th";
                                                if (day.ToString().EndsWith("13")) prefix = "th";
                                                if (day.ToString().EndsWith("1")) prefix = "st";
                                                if (day.ToString().EndsWith("2")) prefix = "nd";
                                                if (day.ToString().EndsWith("3")) prefix = "rd";
                                                if (prefix == "") prefix = "th";
                                             %>
                                            <td><%=DateTime.Parse(row["Date"].ToString()).ToString("MMM dd")+prefix+DateTime.Parse(row["Date"].ToString()).ToString(" yyyy hh:mm")%></td>
                                            <td><%=row["QuestionName"]%></td>
                                            <td><%=row["Category"]%></td>
                                            <td><%=row["Language"]%></td>
                                            <td><%=row["Score"]%>/100</td>
                                        </tr>
                                        <% }%>          
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                </div>
                <!-- /.col-lg-8 -->
                <div class="col-lg-4">
                <div class="chat-panel panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-tasks fa-fw"></i>Tasks
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body" style="overflow: hidden; height:auto">
                        <div class="row">
                        <div class="col-sm-12">
                            <%  string[] boostrap = { "\"progress-bar progress-bar-success\"", "\"progress-bar progress-bar-info\"", "\"progress-bar progress-bar-warning\"", "\"progress-bar progress-bar-danger\"" };%>
                            <%  int index = 0; %>
                            <%  TasksDataSource.SelectParameters.Add("Username",username); %>
                            <%  dv = (System.Data.DataView)TasksDataSource.Select(new DataSourceSelectArguments());%>
                            <%   foreach (System.Data.DataRow row in dv.Table.Rows)
                                    {
                                        int value = (Convert.ToInt32(row["Score"]) * 100 / Convert.ToInt32(row["MaxScore"])); %>
                            <div>
                                <p>
                                    <strong><%=row["Category"]%></strong>
                                    <span class="pull-right text-muted"><%=value %>% Complete</span>
                                </p>
                                <div class="progress progress-striped active">
                                    <div class=<%=boostrap[index++]%> role="progressbar" aria-valuenow="<%=value%>" aria-valuemin="0" aria-valuemax="100" style="width:<%=value%>%">
                                        <span class="sr-only"><span><%=value%></span>% Complete (success)</span>
                                    </div>
                                </div>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    </div>
                    <!-- /.panel-body -->
                    <div class="panel-footer" style="overflow:hidden">
                                            
                    </div>
                </div>
                <!-- /.panel .chat-panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Line Chart Example
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="flot-chart">
                                <div class="flot-chart-content" id="pie"></div>
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->

                </div>
                <!-- /.col-lg-4 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->
        </div>
        <!--gauge-->
        <script src="js/raphael-2.1.4.min.js"></script>
        <script src="js/justgage.js"></script>
        
        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>

        <!-- Flot Charts JavaScript -->
        <script src="bower_components/flot/jquery.flot.js"></script>
        <script src="bower_components/flot/jquery.flot.pie.js"></script>
        <script src="bower_components/flot/jquery.flot.resize.js"></script>
        <script src="bower_components/flot.tooltip/js/jquery.flot.tooltip.min.js"></script>

        <script>
        <%  ScoreDataSource.SelectParameters.Clear();
            ScoreDataSource.SelectParameters.Add("Username", username);
            DataSourceSelectArguments args = new DataSourceSelectArguments();
            dv = (System.Data.DataView)ScoreDataSource.Select(args);          
        %>
        var g1 = new JustGage({
            id: "g1",
            value: <%=dv.Table.Rows[0]["Score"] %>,
            min: 0,
            max: <%=dv.Table.Rows[0]["MaxScore"] %>,
            title: "Total Score",
            donut: true,
            levelColors: ["#ff0000", "#ffff00", "#008000"]
        });
        </script>
        
        <script>
            var data = [
            {
                label: "Series 0",
                data: 3
            }, 
            {
                label: "Series 1",
                data: 6
            }
            ];

            var plotObj = $.plot($("#pie"), data, {
                series: {
                    pie: {
                        show: true
                    }
                },
                grid: {
                    hoverable: true
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%p.0%, %s", // show percentages, rounding to 2 decimal places
                    shifts: {
                        x: 20,
                        y: 0
                    },
                    defaultTheme: false
                }
            });  
        </script>     
        </body>
</asp:Content>
