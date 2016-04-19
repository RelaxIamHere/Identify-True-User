<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Contest.aspx.cs" Inherits="_Contest" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <head>
        <!--Code Mirror-->
        <link href="js/codemirror-5.8/lib/codemirror.css" rel="stylesheet" type="text/css" />
        <link href="js/codemirror-5.8/theme/ambiance.css" rel="stylesheet" type="text/css" />


        <script src="js/codemirror-5.8/lib/codemirror.js" type="text/javascript"></script>
        <script src="js/codemirror-5.8/mode/clike/clike.js" type="text/javascript"></script>
        <script src="js/codemirror-5.8/addon/edit/matchbrackets.js" type="text/javascript"></script>
      
        <script src="js/Programing_Lang.js" type="text/javascript"></script>
    </head>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

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
                    
                    <div style="width: 80%; border-left-color: #5bc0de; padding: 20px; margin: 0 auto;
                        border: 1px solid #eee; border-left-width: 5px; border-radius: 3px;">
                        <strong>Example challenge</strong></h3>
                        <p>
                            You are given some natural numbers as input. For each number n, the program should
                            compute the sum 1<sup>2</sup> + 2<sup>2</sup> + 3<sup>2</sup> + … + n<sup>2</sup>,
                            listing all partial sums and the global sum.
                        </p>
                        <br />
                        <strong>Sample input:</strong><br />
                        4 5<br />
                        <br />
                        <strong>Sample output:</strong>
                        <br />
                        1 5 14 30<br />
                        1 5 14 30 55<br />
                    </div>
                    <br />
                    <div style="margin: 0 20px;">
                        <label for="comment">
                            Select Language:</label><br />
                        <asp:DropDownList ID="DropDownLanguage" class="btn btn-primary" runat="server">
                        </asp:DropDownList>
                    </div>
                    <div style="margin: 0 20px;">
                        <label for="comment">
                            Code:</label><br />
                        <asp:TextBox ID="TextBoxCode" class="form-control" runat="server" TextMode="MultiLine"></asp:TextBox><br />
                    </div>
                    <div>
                        <div style="float: left; width: 50%; margin: 0 10px 0 20px; overflow: hidden;">
                            <label for="comment">
                                Result:</label>
                            <asp:TextBox ID="TextBoxCompiler" Style="font-size: 12px; height: 150px;" class="form-control"
                                runat="server" TextMode="MultiLine" Enabled="False"></asp:TextBox><br />
                        </div>
                        <div style="overflow: hidden; margin: 0 20px 0 10px;">
                            <label for="comment">
                                Output:</label>
                            <asp:TextBox ID="TextBoxOutput" Style="font-size: 12px; height: 150px;" class="form-control"
                                runat="server" TextMode="MultiLine" Enabled="False"></asp:TextBox><br />
                        </div>
                    </div>
                    <asp:Button Style="margin: 0 20px" ID="ButtonCompile" class="btn btn-primary" runat="server"
                        OnClick="ButtonCompile_Click" Text="Compile" />
                    <br />
                    <br />
                  
                </div>
            </div>
            <!-- /#page-wrapper -->
        </div>
    </body>
</asp:Content>
