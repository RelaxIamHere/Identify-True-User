<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Dashboard.aspx.cs" Inherits="_Dashboard" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<asp:SqlDataSource ID="ActivityDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT TOP 10 Submission.Language, Submission.Date, Map.QuestionName, Map.Category, Submission.Score, Map.Question 
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
        SelectCommand="SELECT a.Score, b.MaxScore FROM 
                        (SELECT SUM(Score) AS Score FROM Submission WHERE 
                        (Username = @Username)) AS a CROSS JOIN 
                        (SELECT COUNT(Id) * 100 AS MaxScore FROM Map AS MaxScore) AS b"></asp:SqlDataSource>
<asp:SqlDataSource ID="TasksDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT TOP 4 (b.Score*100)/a.MaxScore AS Score, a.Category FROM
                        (SELECT COUNT(Category) * 100 AS MaxScore, Category FROM
                            Map GROUP BY Category) AS a INNER JOIN
                        (SELECT SUM(Submission.Score) AS Score, Map_1.Category FROM
                            Map AS Map_1 INNER JOIN Submission ON Map_1.Question = Submission.Question
                            WHERE (Submission.Username = @Username) GROUP BY Map_1.Category) 
                         AS b ON a.Category = b.Category WHERE b.Score<>0 ORDER BY Score DESC"></asp:SqlDataSource>
<asp:SqlDataSource ID="PieLanguageDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT SUM(Score) AS TotalScore, Language FROM Submission WHERE (Username = @Username)
                       AND (Score <> 0) GROUP BY Language ORDER BY TotalScore DESC"></asp:SqlDataSource>
<asp:SqlDataSource ID="PieCategoryDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="SELECT SUM(Submission.Score) AS Score, Map.Category FROM Map INNER JOIN 
                       Submission ON Map.Question = Submission.Question WHERE (Submission.Username = @Username) 
                       AND (Submission.Score <> 0) GROUP BY Map.Category ORDER BY Score DESC"></asp:SqlDataSource>
<asp:SqlDataSource ID="CalendarDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT CAST(Date AS DATE) AS Date, COUNT(Date) AS Sum FROM Submission 
                       WHERE (Username = @Username) AND (YEAR(Date) = YEAR(GETDATE()))
                       GROUP BY CAST(Date AS DATE)"></asp:SqlDataSource>

<asp:SqlDataSource ID="ContactDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="SELECT Name, Surname, Birthday, Phone, Mail, Website, Country, City, Address, Company, School
                       FROM Contact WHERE (Username = @Username)"></asp:SqlDataSource>
<!-- Progress Bar dolu sutun sayısı -->                 
<asp:SqlDataSource ID="ContactProgress" runat="server"
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="SELECT cast(((CASE WHEN Name IS NULL THEN 0 ELSE 1 END) + (CASE WHEN Surname IS NULL THEN 0 ELSE 1 END) + (CASE WHEN Birthday IS NULL THEN 0 ELSE 1 END) 
                         + (CASE WHEN Phone IS NULL THEN 0 ELSE 1 END) + (CASE WHEN Mail IS NULL THEN 0 ELSE 1 END) + (CASE WHEN Website IS NULL THEN 0 ELSE 1 END) 
                         + (CASE WHEN Country IS NULL THEN 0 ELSE 1 END) + (CASE WHEN City IS NULL THEN 0 ELSE 1 END) + (CASE WHEN Address IS NULL THEN 0 ELSE 1 END) 
                         + (CASE WHEN Company IS NULL AND School IS NULL THEN 0 ELSE 1 END)) as float) AS filled_fields
                       FROM Contact WHERE (Username = @Username)"></asp:SqlDataSource>


<%
    string username = Membership.GetUser().UserName;
    if (!string.IsNullOrEmpty(Request.QueryString["u"]))
        username = Request.QueryString["u"];
%>

<body>
<div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                    <div style="right:5px; position:absolute; overflow:hidden;">
                        <br />   
                        <div id="g1" style="height:100px; width:100px;"></div>
                    </div>

                <div class="col-lg-12" style="width:75%; float:left">
                    <h1 class="page-header"><%=username%></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <br />
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <label><i class="fa fa-list-alt fa-fw"></i> Recent Activity</label>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body" style="height:auto;">
                                <div class="col-sm-12">
                                    <table aria-describedby="dataTables-example_info" role="grid"
                                        class="table table-responsive table-striped table-bordered table-hover dataTable no-footer dtr-inline"
                                        width="100%">
                                        <thead>
                                            <tr role="row">
                                                <th style="width: 100px;">
                                                    Date
                                                </th>
                                                <th style="width: 100px;">
                                                    Challenge
                                                </th>
                                                <th style="width: 100px;">
                                                    Category
                                                </th>
                                                <th style="width: 100px;">
                                                    Language
                                                </th>
                                                <th style="width: 100px;">
                                                    Score
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="table">
                                        <%  ActivityDataSource.SelectParameters.Add("Username",username); %>
                                        <%  System.Data.DataView dv = (System.Data.DataView)ActivityDataSource.Select(new DataSourceSelectArguments());%>
                                        <%   foreach (System.Data.DataRow row in dv.Table.Rows)
                                         {%>
                                        <tr role="row" class="gradeA odd">
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
                                            <td><%=DateTime.Parse(row["Date"].ToString()).ToString("MMM dd")+prefix+DateTime.Parse(row["Date"].ToString()).ToString(" yyyy HH:mm")%></td>
                                            <td><a href="Challange.aspx?p=<%=row["Question"]%>"><%=row["QuestionName"]%></a></td>
                                            <td><a href="Category.aspx?c=<%=row["Category"]%>"><%=row["Category"]%></a></td>
                                            <td><%=row["Language"]%></td>
                                            <td><a href="Leaderboard.aspx?p=<%=row["Question"]%>"><%=row["Score"]%>/100</a></td>
                                        </tr>
                                        <% }%>          
                                    </tbody>
                                    </table>
                                </div>    
                            </div>
                            
                        </div>
                        <!-- /.panel-body -->

                        <div class="panel panel-default" id="panel">
                            <div class="panel-heading">
                                <label><i class="fa fa-user fa-fw"></i> User Profile</label>
                            </div>
                        <!-- /.panel-heading -->
                            <div class="panel-body" id="resize" style="height:auto">
                                <div class="col-sm-12">
                                    <div class="col-sm-10">
                                    <div role="button" tabindex="0" aria-label="Download" class="Download" data-progressbar-label="Profile Progress..."></div>
                                    </div>
                                    <div class="col-sm-2">
                                    <a style="float:right" href="ChangePassword.aspx" class="btn btn-primary">Update</a>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <table>
                                    <%  ContactDataSource.SelectParameters.Add("Username", username); %>
                                    <%  dv = (System.Data.DataView)ContactDataSource.Select(new DataSourceSelectArguments());%>
                                    <%   foreach (System.Data.DataRow line in dv.Table.Rows)
                                         {
                                             DateTime dt = (DateTime)line["Birthday"];   //TO DO : textboxa default "mm/dd/yyyy" stringi giderse patlar düzelt.
                                             int age = DateTime.Today.Year - dt.Year; %>
                                        <tr>
                                            <td>Name:</td>
                                            <td><%=line["Name"]%></td>
                                        </tr>
                                        <tr>
                                            <td>Surname:</td>
                                            <td><%=line["Surname"]%></td>
                                        </tr>
                                        <tr>
                                            <td>Age:</td>
                                            <td><% =age%></td>
                                        </tr>
                                        <tr>
                                            <td>Phone:</td>
                                            <td><%=line["Phone"]%></td>
                                        </tr>
                                        <tr>
                                            <td>Mail:</td>
                                            <td><%=line["Mail"]%></td>
                                        </tr>
                                        <tr>
                                            <td>Website:</td>
                                            <td><%=line["Website"]%></td>
                                        </tr>
                                        <tr>
                                            <td>Country:</td>
                                            <td><%=line["Country"]%></td>
                                        </tr>
                                        <tr>
                                            <td>City:</td>
                                            <td><%=line["City"]%></td>
                                        </tr>
                                        <tr>
                                            <td>Address:</td>
                                            <td><%=line["Address"]%></td>
                                        </tr>
                                        <tr>
                                            <td>Company:</td>
                                            <td><%=line["Company"]%></td>
                                        </tr>
                                        <tr>
                                            <td>School:</td>
                                            <td><%=line["School"]%></td>
                                        </tr>
                                        <% }%>  
                                    </table>
                                </div>    
                            </div>
                        </div>
                        <!-- /.panel-body -->

                    </div>
                <!-- /.col-lg-8 -->
                <div class="col-lg-4">
                <div class="row">
                <div class="col-lg-6">
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
                                    <div>New Question</div>
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
                 <div class="col-lg-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-tasks fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                    <%  NewCategoryDataSource.SelectParameters.Add("Username",username); %>
                                    <%  dv = (System.Data.DataView)NewCategoryDataSource.Select(new DataSourceSelectArguments());%>
                                    <%=dv.Table.Rows[0]["NewCategory"].ToString() %>
                                    </div>
                                    <div>New Category</div>
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


                <div class="panel panel-default">
                    <div class="panel-heading">
                        <label><i class="fa fa-line-chart fa-fw"></i> Task</label>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body" style="height:auto">
                        <div class="row">
                        <div class="col-sm-12">
                            <%  string[] boostrap = { "\"progress-bar progress-bar-success\"", "\"progress-bar progress-bar-info\"", "\"progress-bar progress-bar-warning\"", "\"progress-bar progress-bar-danger\"" };%>
                            <%  int index = 0; %>
                            <%  TasksDataSource.SelectParameters.Add("Username",username); %>
                            <%  dv = (System.Data.DataView)TasksDataSource.Select(new DataSourceSelectArguments());%>
                            <%   foreach (System.Data.DataRow row in dv.Table.Rows)
                                    { %>
                            <div>
                                <p>
                                    <a href="Category.aspx?c=<%=row["Category"]%>"><strong><%=row["Category"]%></strong></a>
                                    <span class="pull-right text-muted"><%=row["Score"]%>% Complete</span>
                                </p>
                                <div class="progress progress-striped active">
                                    <div class=<%=boostrap[index++]%> role="progressbar" aria-valuenow="<%=row["Score"]%>" aria-valuemin="0" aria-valuemax="100" style="width:<%=row["Score"]%>%">
                                        <span class="sr-only"><span><%=row["Score"]%></span>% Complete (success)</span>
                                    </div>
                                </div>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel .chat-panel -->
                    <div style="width:48%; float:left;">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <label><i class="fa fa-code fa-fw"></i> Language</label>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body" style="height:auto">
                            <div class="flot-chart">
                                <div class="flot-chart-content" id="pieLanguage"></div>
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    </div>
                    <div style="float:right; width:48%">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <label><i class="fa fa-tasks fa-fw"></i> Category</label>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body" style="height:auto">
                            <div class="flot-chart">
                                <div class="flot-chart-content" id="pieCategory"></div>
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    
                    <div id="referance"></div>
                    </div> 
                </div>
                <!-- /.col-lg-4 -->

                <div class="col-lg-12" id="hide">
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <label><i class="fa fa-calendar fa-fw"></i> Activity Calendar</label>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body" style="height:auto;">
                                <div class="col-sm-12">
                                    <center><div id="calendar" style="width:950px; height:auto;"></div></center>
                                </div>    
                            </div>
                        </div>
                        <!-- /.panel-body -->
                </div>
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->
        </div>

        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>

        <!-- Elastic Progress JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.17.0/TweenMax.min.js"></script>
        <script src="dist/js/elastic-progress.js"></script>

        <!--gauge-->
        <script src="js/raphael-2.1.4.min.js"></script>
        <script src="js/justgage.js"></script>

        <!-- Flot Charts JavaScript -->
        <script src="bower_components/flot/jquery.flot.js"></script>
        <script src="bower_components/flot/jquery.flot.pie.js"></script>
        <script src="bower_components/flot/jquery.flot.resize.js"></script>
        <script src="bower_components/flot.tooltip/js/jquery.flot.tooltip.min.js"></script>
        
        <!-- Calendar -->
        <script type="text/javascript" src="js/loader.js"></script>
        

        <script type="text/javascript">      
        $(document).ready(function() {
        <%  ContactProgress.SelectParameters.Add("Username", username); %>
        <%  dv = (System.Data.DataView)ContactProgress.Select(new DataSourceSelectArguments());%>
        var x = <% =dv.Table.Rows[0]["filled_fields"] %>;
		$(".Download").eq(0).ElasticProgress({
				buttonSize: 60,
				fontFamily: "Montserrat",
				colorBg: "#adeca8",
				colorFg: "#7cc576",
				onClick: function(event) {
						$(this).ElasticProgress("open");
				},
				onOpen: function(event) {
						$(this).ElasticProgress("setValue",x/10);
				},
				onFail: function(event) {
						$(this).ElasticProgress("open");
				},
				onCancel: function(event) {
						$(this).ElasticProgress("open");
				}
		});

		$(".Download").ElasticProgress("open");
        });
        
        $("#page-wrapper").resize(function (e) {
            var x = $("#referance").position().top - $("#resize").position().top;
            $("#resize").height(x-50);
            if ($("#page-wrapper").width() < 950)
                document.getElementById("hide").style.display = "none";
            else
                document.getElementById("hide").style.display = "block";
            if($("#page-wrapper").width() < 875)
                document.getElementById("panel").style.display = "none";
            else
                document.getElementById("panel").style.display = "block";
        });

        google.charts.load("current", { packages: ["calendar"] });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var dataTable = new google.visualization.DataTable();
            dataTable.addColumn({ type: 'date', id: 'Date' });
            dataTable.addColumn({ type: 'number', id: 'Won/Loss' });
            dataTable.addRows([
                <%  CalendarDataSource.SelectParameters.Add("Username",username); %>
                <%  dv = (System.Data.DataView)CalendarDataSource.Select(new DataSourceSelectArguments());%>
                <%  foreach (System.Data.DataRow row in dv.Table.Rows){ %>
                <%  DateTime date1; %>
                <%  DateTime.TryParse(row["Date"].ToString(), out date1); %>
                    [new Date(<%=date1.Year%>, <%=date1.Month-1%>, <%=date1.Day %>), <%=row["Sum"] %>]
                <%if(row!=dv.Table.Rows[dv.Table.Rows.Count-1]){ %>,<%} %> 
                <% } %>
            ]);

            var chart = new google.visualization.Calendar(document.getElementById('calendar'));

            var options = {
                colorAxis: {minValue: 0,  colors: ["#ff0000", "#ffff00", "#008000"]},
                height: 200,
                calendar: {
                    monthOutlineColor: {
                        stroke: '#981b48',
                        strokeOpacity: 0.8,
                        strokeWidth: 2
                    },
                    unusedMonthOutlineColor: {
                        stroke: '#bc5679',
                        strokeOpacity: 0.8,
                        strokeWidth: 1
                    },
                    focusedCellColor: {
                        stroke: 'red',
                        strokeOpacity: 0.8,
                        strokeWidth: 2
                    }
                  }
                
            };
            chart.draw(dataTable, options);
        }
        </script>


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
        <%  PieLanguageDataSource.SelectParameters.Add("Username",username); %>
        <%  dv = (System.Data.DataView)PieLanguageDataSource.Select(new DataSourceSelectArguments());%>
            
            var data = [
            <%   foreach (System.Data.DataRow row in dv.Table.Rows){ %>
                {
                    label: "<%=row["Language"].ToString().Split(' ')[0]%>",
                    data: "<%=row["TotalScore"] %>"
                }
             <%if(row!=dv.Table.Rows[dv.Table.Rows.Count-1]){ %>,<%} %> 
            <% } %>
            ];

            var plotObj = $.plot($("#pieLanguage"), data, {
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
                    content: "%p.0% %s", // show percentages, rounding to 2 decimal places
                    shifts: {
                        x: 20,
                        y: 0
                    }
                }
            });
            
        <%  PieCategoryDataSource.SelectParameters.Add("Username",username); %>
        <%  dv = (System.Data.DataView)PieCategoryDataSource.Select(new DataSourceSelectArguments());%>
            
            data = [
            <%   foreach (System.Data.DataRow row in dv.Table.Rows){ %>
                {
                    label: "<%=row["Category"]%>",
                    data: "<%=row["Score"] %>"
                }
             <%if(row!=dv.Table.Rows[dv.Table.Rows.Count-1]){ %>,<%} %> 
            <% } %>
            ];

            plotObj = $.plot($("#pieCategory"), data, {
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
                    content: "%p.0% %s", // show percentages, rounding to 2 decimal places
                    shifts: {
                        x: 20,
                        y: 0
                    }
                }
            });  
              
        </script>     
        
        </body>
</asp:Content>
