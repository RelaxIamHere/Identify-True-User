<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Compiler.aspx.cs" Inherits="_Compiler" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <head>
    <!--Code Mirror-->
    <link href="js/codemirror-5.8/lib/codemirror.css" rel="stylesheet" type="text/css" />
    <link href="js/codemirror-5.8/theme/ambiance.css" rel="stylesheet" type="text/css" />
    </head>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <body>
        <div id="wrapper">
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Test Compiler</h1>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
                 <div class="col-md-12">
                        <div class="col-md-3">
                            <label for="comment">
                                Input:</label><br />
                            <asp:TextBox ID="TextBoxInput" Style="font-size: 12px; width: 100%; height: 150px;" class="form-control"
                                runat="server" TextMode="MultiLine"></asp:TextBox><br />
                        </div>
                   </div>
                    <br /><br />
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
                        <div class="col-md-6">
                            <label for="comment">
                                Output:</label><br />
                            <asp:TextBox ID="TextBoxOutput" Style="font-size: 12px; width: 100%;  height: 150px;" class="form-control"
                                runat="server" TextMode="MultiLine" Enabled="False"></asp:TextBox><br />
                        </div>
                    </div>
                  
                </div>
            </div>
            <!-- /#page-wrapper -->
        </div>
        <br /><br />
    <script src="js/codemirror-5.8/lib/codemirror.js" type="text/javascript"></script>
    <script src="js/codemirror-5.8/mode/clike/clike.js" type="text/javascript"></script>
    <script src="js/codemirror-5.8/addon/edit/matchbrackets.js" type="text/javascript"></script>
    <script src="js/Programing_Lang.js" type="text/javascript"></script>
    </body>
</asp:Content>
