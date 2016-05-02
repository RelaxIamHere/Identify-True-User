<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Compiler.aspx.cs" Inherits="_Compiler" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <head>
    <!--Code Mirror-->
    <link href="js/codemirror-5.8/lib/codemirror.css" rel="stylesheet" type="text/css" />
    <link href="js/codemirror-5.8/theme/ambiance.css" rel="stylesheet" type="text/css" />
    <!-- Overlay-->
    <link href="Styles/overlay.css" rel="stylesheet" type="text/css" />
    </head>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <body>
        <div id="overlay" class="overlay">
            <div class="overlay-content">
                <a href="javascript:void(0);">
                    <image src="Styles/comp.gif"></image>
                </a>
                <a href="javascript:void(0);"> Please Wait ...</a>
            </div>
        </div>
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
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                        <div class="panel-heading">
                            <label><i class="fa fa-keyboard-o fa-fw"></i> Code</label>
                            <asp:DropDownList ID="DropDownLanguage" class="btn btn-primary dropdown-toggle pull-right" runat="server" style="-moz-appearance: none;">
                            </asp:DropDownList><br /><br />
                        </div>
                        <!-- /.panel-heading -->
                        <asp:TextBox ID="TextBoxCode" class="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
                        <div class="panel-footer" style="height:auto; overflow:hidden;">
                            <asp:Button ID="ButtonCompile" class="btn btn-primary pull-right" runat="server"
                            OnClick="ButtonCompile_Click" OnClientClick="openOverlay()" Text="Compile" />
                        </div>
                        </div>
                    </div>

                    <div class="col-lg-3">
                     <div class="panel panel-default">
                        <div class="panel-heading">
                            <label><i class="fa fa-arrow-circle-right fa-fw"></i> Input</label>
                        </div>
                        <!-- /.panel-heading -->
                        
                        <div class="panel-footer" style="height:auto; overflow:hidden;">
                                  <div class="col-sm-12" style="margin:0 0 15px 0">
                                    <asp:TextBox ID="TextBoxInput" Style="font-size: 12px; width: 100%; height: 150px;" class="form-control"
                                    runat="server" TextMode="MultiLine" Placeholder="Type input here ..."></asp:TextBox>
                                   </div>  
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="panel panel-default">
                        <div class="panel-heading">
                            <label><i class="fa fa-gears fa-fw"></i> Result</label>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body" style="height:auto; overflow:hidden;">
                                  <div class="col-sm-12">
                                    <asp:TextBox ID="TextBoxCompiler" Style="font-size: 12px; width: 100%; height: 150px;" class="form-control"
                                runat="server" TextMode="MultiLine" Enabled="False"></asp:TextBox>
                                </div>
                                
                        </div>
                        </div>
                    </div>

                    <div class="col-lg-3">
                        <div class="panel panel-default">
                        <div class="panel-heading">
                            <label><i class="fa fa-arrow-circle-left fa-fw"></i> Output</label>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body" style="height:auto; overflow:hidden;">
                            <div class="col-sm-12">
                                    <asp:TextBox ID="TextBoxOutput" Style="font-size: 12px; width: 100%;  height: 150px;" class="form-control"
                                    runat="server" TextMode="MultiLine" Enabled="False"></asp:TextBox>
                            </div>  
                        </div>
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
        <script>
            function openOverlay() {
                document.getElementById("overlay").style.height = "100%";
            }
    </script>
    </body>
</asp:Content>
