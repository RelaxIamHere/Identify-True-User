<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Category.aspx.cs" Inherits="_Category" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<asp:SqlDataSource ID="MapDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT [Question], [QuestionName] FROM [MAP] WHERE [Category]=@Category ORDER BY [Category] ASC"></asp:SqlDataSource>

<asp:SqlDataSource ID="SubmissionSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT [Score] FROM [Submission] WHERE [Question]=@Question AND [Username]=@Username"></asp:SqlDataSource>

<asp:SqlDataSource ID="ScoreDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT a.Score, b.MaxScore FROM (SELECT SUM(Score) AS Score FROM Submission INNER JOIN Map ON 
                        Map.Question = Submission.Question WHERE (Submission.Username = @Username) AND (Map.Category=@Category)) 
                        AS a CROSS JOIN (SELECT COUNT(Id) * 100 AS MaxScore FROM Map AS MaxScore WHERE Category=@Category) AS b"></asp:SqlDataSource>
<body>
<div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div style="right:5px; position:absolute; overflow:hidden;">
                        <br />   
                        <a href="Leaderboard.aspx?c=<%= Request.QueryString["c"]%>">
                            <div id="g1" style="height:100px; width:100px;"></div>
                        </a>
                    </div>

                <div class="col-lg-12" style="width:75%; float:left">
                    <h1 class="page-header">Category: <span><%= Request.QueryString["c"]%></span></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <br />
            <div id="populate" class="row" runat="server">
            </div>
        </div>
        <!-- /#page-wrapper -->
        </div>
        <!--gauge-->
        <script src="js/raphael-2.1.4.min.js"></script>
        <script src="js/justgage.js"></script>

        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>

         <script>
        <%  ScoreDataSource.SelectParameters.Clear();
            ScoreDataSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
            ScoreDataSource.SelectParameters.Add("Category", Request.QueryString["c"]);
            DataSourceSelectArguments args = new DataSourceSelectArguments();
            System.Data.DataView dv = (System.Data.DataView)ScoreDataSource.Select(args);          
        %>
        var g1 = new JustGage({
            id: "g1",
            value: <%=dv.Table.Rows[0]["Score"] %>,
            min: 0,
            max: <%=dv.Table.Rows[0]["MaxScore"] %>,
            title: "<%=Request.QueryString["c"]%>",
            donut: true,
            levelColors: ["#ff0000", "#ffff00", "#008000"]
        });
        </script>


        </body>
</asp:Content>
