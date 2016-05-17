<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Challange.aspx.cs" Inherits="_Challange" %>

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
	.absolute       { background-color: rgba(0,0,0, 1);}
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
    
    <asp:SqlDataSource ID="SubmissionDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
        SelectCommand="SELECT [SubmissionId],[Score] FROM [Submission] WHERE [Username]=@Username AND [Question]=@Question"
        UpdateCommand="UPDATE [Submission] SET [Language]=@Language, [Score]=@Score,[SubmissionId]=@SubmissionId, [Date]=@Date WHERE [Username]=@Username AND [Question]=@Question"
        InsertCommand="INSERT INTO [Submission] ([Username],[Question],[Score],[SubmissionId],[Date],[Language]) VALUES (@Username,@Question,@Score,@SubmissionId,@Date,@Language)"></asp:SqlDataSource>

    <asp:SqlDataSource ID="MapDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT [Category] FROM [MAP] WHERE [Question]=@Question"></asp:SqlDataSource>

    <body class="no-scrollbar">
     

        <div id="wrapper" class="no-padding">
            <div id="page-wrapper" class="no-padding">
            
        <div id="overlay" class="overlay" style="height:0%;">
            <div class="overlay-content">
                <a href="javascript:void(0);">
                    <image src="Styles/comp.gif"></image>
                </a>
                <a href="javascript:void(0);"> Please Wait ...</a>
            </div>
        </div>

        <div id="overlay2" class="overlay absolute"  style="height:100%;">
            <div class="overlay-content">
                <a href="javascript:void(0);">
                    <image src="Styles/comp.gif" style="visibility:hidden;"></image>
                </a>
                <a href="javascript:void(0);"> Please Wait ...</a>
            </div>
        </div>

               <div id="tabs-center" class="full-height ui-layout-center add-scrollbar no-padding" style="border: 0; min-width:500px;">
	            <div class="ui-layout-center ui-widget-content add-scrollbar no-padding" style="border: 0; overflow-x:hidden; max-width:100%;">
		            <div class="col-lg-12">
                    <br /><br />
                        <div class="panel panel-default">
                        <div class="panel-heading">
                            <label><i class="fa fa-keyboard-o fa-fw"></i> Code</label>
                            
                            <asp:DropDownList ID="DropDownLanguage" class="btn btn-primary dropdown-toggle pull-right" runat="server" style="-moz-appearance: none;">
                            </asp:DropDownList><br /><br />
                        </div>
                        <!-- /.panel-heading -->
                        <asp:TextBox ID="TextBoxCode" class="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
                        <div class="panel-footer" style="height:auto; overflow:hidden;">
                            <asp:LinkButton ID="ButtonCompile" class="btn btn-primary btn-outline pull-right" runat="server"
                            OnClick="ButtonCompile_Click" OnClientClick="openOverlay()"><i class='fa fa-gear fa-fw'></i> Compile</asp:LinkButton>
                        </div>
                        </div>
                    </div>
	            </div>
            </div>


            <div id="tabs-east" class="ui-layout-east no-padding add-scrollbar">
	            <div class="ui-widget-header no-scrollbar add-padding" style="margin: 0 1px;">
		            <%     MapDataSource.SelectParameters.Clear(); //Select
                            MapDataSource.SelectParameters.Add("Question", Request.QueryString["p"]);
                            DataSourceSelectArguments args2 = new DataSourceSelectArguments();
                            System.Data.DataView dv2 = (System.Data.DataView)MapDataSource.Select(args2);%>
		                <span><%=dv2.Table.Rows[0]["Category"].ToString()%></span>
	            </div>
	            <ul class="allow-overflow">
		            <li><a href="#tab-panel-east-1"><label><i class="fa fa-question-circle fa-fw"></i> Question</label></a></li>
		            <li><a href="#tab-panel-east-2"><label><i class="fa fa-gears fa-fw"></i> Results</label></a></li>
	            </ul>
	            <div class="ui-layout-content ui-widget-content no-scrollbar" style="border-top: 0;">
		            <div id="tab-panel-east-1" class="full-height no-padding add-scrollbar">
			            <div class="ui-tabs-panel">
                            
                            <div class="pull-right" style="right:10px; top:0;">
                                <br />
                                <a href="Leaderboard.aspx?p=<%=Request.QueryString["p"]%>">
                                    <div id="g1" style="height:100px; width:100px;"></div>
                                </a>
                            </div>
                            <div runat="server" id="problem" style="width: 100%; border-left-color: #5bc0de; padding: 20px; margin: 0 auto;
                                border: 2px solid #eee; border-left-width: 8px; border-radius: 50px;"></div>
			            </div>
		            </div>

		            <div id="tab-panel-east-2" class="full-height add-padding add-scrollbar">
			            <div id="accordion-east" class="full-height no-padding">
		
					            <h5><a href="#"><label><i class="fa fa-gear fa-fw"></i>Compile Info</label></a></h5>
					            <div class="no-padding" style="border:0;">
                                    <span runat="server" id="compInfo"></span>
					            </div>

                                <%=testCases%>                                
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
    <script>
        function openOverlay() {
            document.getElementById("overlay").style.height = "100%";
        }
        function closeOverlay() {
            document.getElementById("overlay2").style.height = "0%";
        }
    </script>
     <!--layout-->
    <script type="text/javascript" src="js/jquery-ui.js"></script> 
	<script type="text/javascript" src="js/jquery.layout.js"></script>

	<!-- load the Tabs & Accordions callbacks so we can use them below-->
	<script type="text/javascript" src="js/jquery.layout.resizeTabLayout.js"></script>
	<script type="text/javascript" src="js/jquery.layout.resizePaneAccordions.js"></script>

	<script type="text/javascript">
	    var repeat = 0;
	    $(document).ready(function () {
	        // alias callback for convenience
	        resizePaneAccordions = $.layout.callbacks.resizePaneAccordions;
	        resizeTabLayout = $.layout.callbacks.resizeTabLayout;

	        // OUTER/PAGE LAYOUT
	        pageLayout = $("#page-wrapper").layout({ // DO NOT use "var pageLayout" here
	            east__size: .45
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
	        setTimeout(resize, 50); /* allow time for browser to re-render with new theme */
	    });

	    function resize() {
	        setTimeout(pageLayout.resizeAll, 50);
	        repeat++;
	        if (repeat < 20)
	            setTimeout(resize, 50);
	        else
	            closeOverlay();
	    }

	</script> 
    </body>
</asp:Content>
