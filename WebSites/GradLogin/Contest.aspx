<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Contest.aspx.cs" Inherits="_Contest" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<asp:SqlDataSource ID="QuestionSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT Question FROM Submission WHERE (Username = @SimilarUser) AND (Question NOT IN
                             (SELECT Question FROM Submission AS Submission_1
                             WHERE (Username = @Username)))"></asp:SqlDataSource>



<asp:SqlDataSource ID="SimilarQuestionsSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT Username, COUNT(*) AS QuestionSimilarity FROM (SELECT Username, 
                          Question FROM Submission WHERE (Username <> @Username) AND (Question IN
                          (SELECT Question FROM Submission AS Submission_1 WHERE (Username = @Username)))
                          GROUP BY Username, Question) AS derivedtbl_1 GROUP BY Username 
                          ORDER BY QuestionSimilarity DESC"></asp:SqlDataSource>

<asp:SqlDataSource ID="SimilarCategorySource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT Username, COUNT(*) AS CategorySimilarity FROM (SELECT Submission.Username, 
                          Map.Category FROM Submission INNER JOIN Map ON Submission.Question = Map.Question
                          WHERE (Submission.Username <> @Username) AND (Map.Category IN (SELECT Map_1.Category
                          FROM Submission AS Submission_1 INNER JOIN Map AS Map_1 ON 
                          Submission_1.Question = Map_1.Question WHERE (Submission_1.Username = @Username)))
                          GROUP BY Submission.Username, Map.Category) AS derivedtbl_1 GROUP BY Username
                          ORDER BY CategorySimilarity DESC"></asp:SqlDataSource>

<asp:SqlDataSource ID="SimilarLanguageSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT Username, COUNT(*) AS LanguageSimilarity FROM (SELECT Username, Language
                          FROM Submission WHERE (Username <> @Username) AND (Language IN (SELECT Language
                          FROM Submission AS Submission_1 WHERE (Username = @Username)))
                          GROUP BY Username, Language) AS derivedtbl_1 GROUP BY Username 
                          ORDER BY LanguageSimilarity DESC"></asp:SqlDataSource>

<asp:SqlDataSource ID="UnsolvedQuestionSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"  
        SelectCommand="SELECT Question FROM Map WHERE (Question NOT IN (SELECT Map_1.Question FROM Map AS Map_1 INNER JOIN
                          Submission ON Submission.Question = Map_1.Question WHERE (Submission.Username = @Username)))"></asp:SqlDataSource>

<body>
<div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12" style="width:75%; float:left">
                    <h1 class="page-header">Contest</h1>
                    <p>In this section, you will encounter the questions that have been solved by the most similar user to you according to the your experiences on questions by using customized similarity algorithms.</p>
                    <br />
                    <center><div style="width:200px;">
                    <asp:Button type="submit" class="btn btn-primary btn-block" ID="QButton" OnClick="QButton_Click"
                    runat="server" Text="See the Question"/>
                    </div> 
                    <br />
                    <span runat="server" id="warn"></span></center>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <br />

            
        </div>
        <!-- /#page-wrapper -->
        </div>
        <!--gauge-->
        <script src="js/raphael-2.1.4.min.js"></script>
        <script src="js/justgage.js"></script>

        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>
        </body>
</asp:Content>
