<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Compiler.aspx.cs" Inherits="_Compiler" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <head>
    <!--Code Mirror-->
    <link href="js/codemirror-5.8/lib/codemirror.css" rel="stylesheet" type="text/css" />
    <link href="js/codemirror-5.8/theme/ambiance.css" rel="stylesheet" type="text/css" />
    <!-- Overlay-->
    <link href="Styles/overlay.css" rel="stylesheet" type="text/css" />
    <!-- layout-->
    <link rel="stylesheet" type="text/css" href="Styles/layout-default.css">
    <style type="text/css">

	/* neutralize pane formatting BEFORE loading UI Theme */
	.ui-layout-pane ,
	.ui-layout-content {
		background:	none;
		border:		0;
		padding:	0;
		overflow:	visible;
	}

	/* use !important to override UI theme styles */
	.add-padding	{ padding:		10px !important; }
	.no-padding		{ padding:		0 !important; }
	.add-scrollbar	{ overflow:		auto !important;}
	.no-scrollbar	{ overflow:		hidden !important; }
	.allow-overflow	{ overflow:		visible !important; }
	.full-height	{ height:		100%; }
	button			{ cursor:		pointer; }

	</style>
    <link rel="stylesheet" type="text/css" href="Styles/jquery-ui.css">
    
    </head>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <body class="no-scrollbar">
        <div id="overlay" class="overlay">
            <div class="overlay-content">
                <a href="javascript:void(0);">
                    <image src="Styles/comp.gif"></image>
                </a>
                <a href="javascript:void(0);"> Please Wait ...</a>
            </div>
        </div>
        <div id="wrapper" class="no-padding">
            <div id="page-wrapper" class="no-padding">

            <div id="tabs-center" class="full-height ui-layout-center add-scrollbar no-padding" style="border: 0; min-width:500px;">
	            <div class="ui-layout-center ui-widget-content add-scrollbar no-padding" style="border: 0; overflow-x:hidden; max-width:100%;">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Test Compiler</h1>
                    </div>
                    <!-- /.col-lg-12 -->
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
	            </div>
            </div>


            <div id="tabs-east" class="ui-layout-east no-padding add-scrollbar">
	            <div class="ui-widget-header no-scrollbar add-padding" style="margin: 0 1px;">
		            TABS HEADER
	            </div>
	            <ul class="allow-overflow">
		            <li><a href="#tab-panel-east-1"><label><i class="fa fa-arrow-circle-right fa-fw"></i> Input</label></a></li>
		            <li><a href="#tab-panel-east-2"><label><i class="fa fa-gears fa-fw"></i> Result</label></a></li>
		            <li><a href="#tab-panel-east-3"><label><i class="fa fa-arrow-circle-left fa-fw"></i> Output</label></a></li>
	            </ul>
	            <div class="ui-layout-content ui-widget-content no-scrollbar" style="border-top: 0;">
		            <div id="tab-panel-east-1" class="full-height no-padding add-scrollbar">
			            <div class="ui-tabs-panel">

                            <asp:TextBox ID="TextBoxInput" Style="resize:vertical; font-size: 12px; width: 100%; min-height: 300px;" class="form-control"
                            runat="server" TextMode="MultiLine" Placeholder="Type input here ..."></asp:TextBox>   

			            </div>
		            </div>
		            <div id="tab-panel-east-3" class="full-height no-padding add-scrollbar">
			            <div class="ui-tabs-panel">
                            <asp:TextBox ID="TextBoxCompiler" disabled Style="resize:vertical; font-size: 12px; width: 100%; min-height: 300px;" class="form-control"
                            runat="server" TextMode="MultiLine"></asp:TextBox>

			            </div>
		            </div>

		            <div id="tab-panel-east-2" class="full-height add-padding add-scrollbar">
			            <div id="accordion-east" class="full-height">
		
					            <h4><a href="#">Section 1</a></h4>
					            <div>
	
                                    <asp:TextBox ID="TextBoxOutput" disabled Style="resize:vertical; font-size: 12px; width: 100%;  min-height: 300px;" class="form-control"
                                    runat="server" TextMode="MultiLine"></asp:TextBox>

					            </div>
		
					            <h4><a href="#">Section 2</a></h4>
					            <div>
						            //text 2
					            </div>
		
					            <h4><a href="#">Section 3</a></h4>
					            <div>
						            //text 3
					            </div>
			            </div>
		            </div>
	            </div>
            </div>

            </div>
            <!-- /#page-wrapper -->
        </div>
    <!-- jQuery -->
    <script src="bower_components/jquery/dist/jquery.min.js"></script>
    <script src="js/codemirror-5.8/lib/codemirror.js" type="text/javascript"></script>
    <script src="js/codemirror-5.8/mode/clike/clike.js" type="text/javascript"></script>
    <script src="js/codemirror-5.8/addon/edit/matchbrackets.js" type="text/javascript"></script>
    <script src="js/Programing_Lang.js" type="text/javascript"></script>
        <script>
            function openOverlay() {
                document.getElementById("overlay").style.height = "100%";
            }
    </script>

    <script type="text/javascript" src="js/jquery-ui.js"></script> 
	<script type="text/javascript" src="js/jquery.layout.js"></script>

	<!-- load the Tabs & Accordions callbacks so we can use them below-->
	<script type="text/javascript" src="js/jquery.layout.resizeTabLayout.js"></script>
	<script type="text/javascript" src="js/jquery.layout.resizePaneAccordions.js"></script>

	<script type="text/javascript">

	    $(document).ready(function () {
	        // alias callback for convenience
	        resizePaneAccordions = $.layout.callbacks.resizePaneAccordions;
	        resizeTabLayout = $.layout.callbacks.resizeTabLayout;

	        // OUTER/PAGE LAYOUT
	        pageLayout = $("#page-wrapper").layout({ // DO NOT use "var pageLayout" here
	            east__size: .26
		        , east__onresize: resizePaneAccordions // east accordion nested inside a tab-panel
	        });

	        // TABS IN CENTER-PANE
	        // create tabs before wrapper-layout so elems are correct size before creating layout
	        pageLayout.panes.center.tabs({
	            activate: resizeTabLayout // tab2-accordion is wrapped in a layout
	        });

	        // WRAPPER-LAYOUT FOR TABS/TAB-PANELS, INSIDE OUTER-CENTER PANE
	        pageLayout.panes.center.layout({
	            closable: false
		      , resizable: false
		      , spacing_open: 0
		      , center__onresize: resizeTabLayout // tabs/panels are wrapped with an inner-layout
	        });


	        // TABS INSIDE EAST-PANE
	        pageLayout.panes.east.tabs({
	            activate: resizePaneAccordions // resize tab2-accordion when tab is activated
	        });
	        pageLayout.sizeContent("east"); // resize pane-content-elements after creating east-tabs

	        // INIT ALL ACCORDIONS - EVEN THOSE NOT VISIBLE

	        $("#accordion-east").accordion({ heightStyle: "fill" });
	        setTimeout(pageLayout.resizeAll, 100); /* allow time for browser to re-render with new theme */
	        setTimeout(pageLayout.resizeAll, 200); /* allow time for browser to re-render with new theme */
	        setTimeout(pageLayout.resizeAll, 500); /* allow time for browser to re-render with new theme */
	    });

	</script> 
    

    </body>
</asp:Content>
