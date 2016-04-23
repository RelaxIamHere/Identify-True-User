<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Challange.aspx.cs" Inherits="_Challange" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <head>
    <!--Code Mirror-->
    <link href="js/codemirror-5.8/lib/codemirror.css" rel="stylesheet" type="text/css" />
    <link href="js/codemirror-5.8/theme/ambiance.css" rel="stylesheet" type="text/css" />
    </head>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    
    <asp:SqlDataSource ID="SubmissionDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
        SelectCommand="SELECT [SubmissionId],[Score] FROM [Submission] WHERE [Username]=@Username AND [Question]=@Question"
        UpdateCommand="UPDATE [Submission] SET [Score]=@Score,[SubmissionId]=@SubmissionId, [Date]=@Date WHERE [Username]=@Username AND [Question]=@Question"
        InsertCommand="INSERT INTO [Submission] ([Username],[Question],[Score],[SubmissionId],[Date]) VALUES (@Username,@Question,@Score,@SubmissionId,@Date)"></asp:SqlDataSource>
    
    <asp:SqlDataSource ID="MapDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT [Category] FROM [MAP] WHERE [Question]=@Question"></asp:SqlDataSource>

    <body>
        <div id="wrapper">
            <div id="page-wrapper">
                <div class="row">
                    <div style="right:0; position:absolute; overflow:hidden;">
                    <br />
                        <a href="Leaderboard.aspx?p=<%=Request.QueryString["p"]%>">
                            <div id="g1" style="height:100px; width:100px;"></div>
                        </a>
                        </div>
                    <div style="width:75%; float:left">
                        <h2 class="page-header" id="header" runat="server">
                            Contest</h2>
                    </div>
                    
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
                    
                   <div runat="server" id="problem" style="width: 80%; border-left-color: #5bc0de; padding: 20px; margin: 0 auto;
                        border: 1px solid #eee; border-left-width: 5px; border-radius: 3px;"></div>

                    <br />
                    <div class="col-md-12">
                        <label for="comment">
                            Select Language:</label><br />
                        <asp:DropDownList ID="DropDownLanguage" class="btn btn-primary" runat="server">
                        </asp:DropDownList><br /><br />
                    </div>
                    <div class="col-md-12">
                        <label for="comment">
                            Code:</label><br />
                        <asp:TextBox ID="TextBoxCode" class="form-control" runat="server" TextMode="MultiLine"></asp:TextBox><br />
                    </div>
                    <div class=col-md-12>
                        <div class="col-md-3">
                        <asp:Button ID="ButtonCompile" class="btn btn-primary btn-block" runat="server"
                            OnClick="ButtonCompile_Click" Text="Compile" />
                        </div>
                    </div>
                    
                    <div class="col-md-12">
                    <br />
                        <div class="col-md-6">
                            <label for="comment">
                                Result:</label><br />
                            <asp:TextBox ID="TextBoxCompiler" Style="font-size: 12px; width: 100%; height: 150px;" class="form-control"
                                runat="server" TextMode="MultiLine" Enabled="False"></asp:TextBox><br />
                        </div>
                        <div class="col-md-3">
                            <label for="comment">
                                Output (First Test Case):</label><br />
                            <asp:TextBox ID="TextBoxOutput" Style="font-size: 12px; width: 100%;  height: 150px;" class="form-control"
                                runat="server" TextMode="MultiLine" Enabled="False"></asp:TextBox><br />
                        </div>
                        <div class="col-md-3">
                            <label for="comment">
                                Score:</label><br />
                            <asp:TextBox ID="TextBoxScore" Style="font-size: 12px; width: 100%;  height: 150px;" class="form-control"
                                runat="server" TextMode="MultiLine" Enabled="False"></asp:TextBox><br /><br /><br />
                        </div>
                    </div>
                </div>
            </div>
            <!-- /#page-wrapper -->
        </div>
    <script src="js/codemirror-5.8/lib/codemirror.js" type="text/javascript"></script>
    <script src="js/codemirror-5.8/mode/clike/clike.js" type="text/javascript"></script>
    <script src="js/codemirror-5.8/addon/edit/matchbrackets.js" type="text/javascript"></script>
    <script src="js/Programing_Lang.js" type="text/javascript"></script>

    <script src="js/raphael-2.1.4.min.js"></script>
    <script src="js/justgage.js"></script>
        
    <script>
        <%  SubmissionDataSource.SelectParameters.Clear();
            SubmissionDataSource.SelectParameters.Add("Question", Request.QueryString["p"]);
            SubmissionDataSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
            DataSourceSelectArguments args = new DataSourceSelectArguments();
            System.Data.DataView dv = (System.Data.DataView)SubmissionDataSource.Select(args);
            if(dv.Table.Rows.Count==1) {                  
        %>
        var g1 = new JustGage({
            id: "g1",
            value: <%=dv.Table.Rows[0]["Score"] %>,
            min: 0,
            max: 100,
            title: "Score",
            donut: true,
            levelColors: ["#ff0000", "#ffff00", "#008000"]
        });
        <% }%>        
    </script>
    </body>
</asp:Content>
