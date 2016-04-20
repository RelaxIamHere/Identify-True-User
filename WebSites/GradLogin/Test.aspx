<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Test.aspx.cs" Inherits="_Test" %>

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
        SelectCommand="SELECT * FROM [Submission] WHERE [Username]=@Username AND [Question]=@Question"
        UpdateCommand="UPDATE [Submission] SET [Score]=@Score,[SubmissionId]=@SubmissionId WHERE [Username]=@Username AND [Question]=@Question"
        InsertCommand="INSERT INTO [Submission] ([Username],[Question],[Score],[SubmissionId]) VALUES (@Username,@Question,@Score,@SubmissionId)"></asp:SqlDataSource>

    <body>
        <div id="wrapper">
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Contest</h1>
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
                    <div class="col-md-12">
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
                                runat="server" TextMode="MultiLine" Enabled="False"></asp:TextBox><br />
                        </div>
                    </div>
                    <div class=col-md-12>
                        <div class="col-md-6">
                        <asp:Button ID="ButtonCompile" class="btn btn-primary" runat="server"
                            OnClick="ButtonCompile_Click" Text="Compile" />
                        <br />
                        <br />
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
    </body>
</asp:Content>
