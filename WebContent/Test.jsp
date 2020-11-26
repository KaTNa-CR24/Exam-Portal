<%@page import="com.user.QueAnswers"%>
<%@ page import = "java.io.*,java.util.*,javax.script.*" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.DriverManager" %>



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Test</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	
	
	<script type="text/javascript" src="./scripts/generateQues.js"></script>
	<script type="text/javascript" src="./scripts/myTimer.js"></script>
</head>
<script>
	var activeQuestion = null;
	var buttonsActivated ;
	var answeredQues = 0;
	var qno = 1;
	var total;
	var queIds = [];
	var Questions;
	var qA = {};
	
</script>

<style>
	.spinners-div{
	margin: 0;
    position: absolute;
    top: 50%;
    left: 56%;
    margin-right: -50%;
    transform: translate(-50%, -50%)
	}
	.jumbo{
		background:linear-gradient(#ffbebec9,white);
		padding-top:2%;
		height:100%;
		margin-bottom:50px;
		border-radius:2px;
	}
	
	.box{
		background-color:white;
		width:100%;
		border:1px solid green;
		box-shadow:-17px 16px 20px 0px rgba(0,0,0,.25);
		margin-top:50px;
		padding:22px;
		}  
	button.btn.btn-outline-secondary, button.btn.btn-secondary {
		margin:2px;
		width:40px;
	}
	.cendiv{
		border-left:solid 2px #ffcbcb;
		border-right:solid #ffcbcb;
		background-color:#ebf39a21;
	}
	.question-item{
		display:none;
		font-size:20px;
		
	}
	.question-item p {
		font-size:25px;
		font-weight:bold;
		margin-bottom:30px;
		font-family: "Times New Roman", Times, serif;
		
	}
	input[type=radio] {
	   width:20px;
	   height:20px;
	}
	#questions-container{
		height:270px;
	}
	.second-row{
		margin-top:30px;
	}
	.box-icon{
		width:40px;
		height:40px;
		margin-bottom:5px;
		border-radius:5px;
	}
	.nav-btn{
		margin:10px;
	}
	#button-submit-test{
		margin-top: 180px;
	}
	.labels{
		font-size:25px;
		margin-left:5px;
		margin-bottom:20px;		
	}
	.navigation-btns{
		margin-top:30px;	
		display:none;
	}
</style>
<body style="background:#c2f3fd36">
	<!-- Bootstrap-Modal at the START of test -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-xl modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">General Instructions</h4>
				</div>
				<div class="modal-body">
					<ul>
					    <li>Total time for Exam is 20 Minutes</li>
					    <li>Negative Marking: <b>NO</b></li>
						<li>The Question Palette displayed on the left side of the screen show the status of each question
						    <ol><li>White - You have not visited the question yet</li>
						    <li>Grey - You have visited the question and not answered</li>
						    <li>Green - You have answered the question</li></ol>
						</li>
						<li>Click on the question number in the Question Palette to go to that numbered question directly,
						    Note that using this option does NOT save your answer to the current question</li>
						<li>Click on <b>Save&Next</b> button to save the selected option for each question</li>
						<li>Click on Submit to complete the test. However the test automatically gets submitted once the timer ends</li>
					</ul>
					Once you click on <b>Start</b>, the countdown timer starts immediately. Good Luck!
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="modal-start" data-dismiss="modal"  >Start</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function(){
			$("#myModal").modal('show');
			
			//console.log(queIds);
			
			$("#myModal").on('hidden.bs.modal',function(){
				$.ajax({
					type:'GET',
					url:'/examportal/MakeQuestionPaper',
					data:{},
					success:function(response){
						console.log(response);
						var Questions = response;
						total = Questions.length;
						localStorage.setItem("total",total);
						$("#questions-answered").text("0 answered out of "+total);
						for (var i=0; i<total;i++){
							queIds.push(Questions[i].qid);
							var qEle = createQuestionElement(Questions[i],Questions[i].qid, i+1);
							document.getElementById('questions-container').appendChild(qEle);
							var btnBox = createButtonBox(i+1, Questions[i].qid);
							document.getElementById('buttons-container').appendChild(btnBox);
						}
						$(".spinners-div").css("display","none");
						//start timer
						startTimer(20); //minutes as parameter
						// display first question
						$("#question-item-1").show();
						activeQuestion = $("#question-item-1");
						$("#1").removeClass("btn-outline-secondary");
						$("#1").addClass("btn-secondary");
						$(".navigation-btns").css("display","flex");
						buttonsActivated = true;
						qno = 1;
					}
				});
				
			});
		});
		
	</script>
	
	<div class="spinners-div" id="spinners">
		<div class="spinner-grow text-primary"></div>
		<div class="spinner-grow text-success"></div>
		<div class="spinner-grow text-info"></div>
	</div>
	
	<div class="container-fluid" >
		<div class="row jumbo">
			<div class="col-md-10 title">
				<h1 style="font-size:60px; color:#003671;">The First Level</h1>
				<b>*attempt all questions</b>
			</div>
			<div class="col-md-2 timer-section">
				<h4>Time Remaining</h4>
				<h1 id="timer" style="font-size:50px">20 : 00</h1>
				
			</div>
		</div>
		<div class="row col-md-12 main-div">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-3">
						<div class="container box" id="buttons-container" >
							
						</div>
						<p id="questions-answered" style="margin-top:20px"></p>
					</div>
					
					<div class="col-md-8 cendiv" >
						<div class="container">
						<form action="TestEvaluate.jsp" method="post" id="myForm">
							<div class="row col-md-12" id="questions-container">
										
							</div>
							<div class="row second-row navigation-btns">
								<div class="col-md-4"><button type="button" class="btn btn-info btn-lg nav-btn" id="previous" disabled>Previous</button></div>
								<div class="col-md-4"></div>
								<div class="col-md-4"><button type="button" class="btn btn-info btn-lg nav-btn" id="next">Save&Next</button></div>
							</div>
						
						</div>
					</div>
					<div class="col-md-1">
						<div class="box-icon" style="background:#6c757d"></div><span>Visited<span><br><br>
						<div class="box-icon" style="background:#28a745"></div><span>Answered</span>
						<button type="submit" class="btn btn-primary" id="button-submit-test" style="background:#337ab7" >Submit</button>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- Bootstrap-Modal for SUBMIT confirmation -->
	<div class="modal fade" id="myModal-submit">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Confirm Submission</h4>
				</div>
				<div class="modal-body">
					<p>Do you really want to submit the test?</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-lg btn-danger" id="modal-no" data-dismiss="modal" >No</button>
					<button type="button" class="btn btn-lg btn-primary" id="button-submit2">Submit</button>
				</div>
			</div>
		</div>
	</div>
</body>



<script>

	function getChosenAnswers(){
		qA = {};
		var x = 0;
		var flag;;
		while(x<total){
			var ele = document.getElementsByName("options-for-"+(x+1));
			flag = 0;
			for (i=0;i<ele.length;i++){
				if (ele[i].checked){
					qA[queIds[x]] = ele[i].value;
					flag = 1;
					break;
				}
				if (flag == 0) qA[queIds[x]] = null;
			}
			x++;
			
		}
		
	}	
</script>

<script>
	var qno;
	$(document).ready(function(){
		//activeQuestion = null;
		$("body").on("click",".sno",function(){
			//if (!buttonsActivated) {
			//	$(".navigation-btns").css("display","flex");
			//	buttonsActivated = true;	
			//}
			
			if (activeQuestion != null){
				activeQuestion.hide();
			}
			qno = $(this).text();
			console.log(qno);
			if(qno > 1){
				$("button#previous").attr("disabled",false);
			}else{
				$("button#previous").attr("disabled",true);}
			
			if(qno==total){
				$("button#next").text("Save&Finish");
			}else{
				$("button#next").text("Save&Next");}
			
			var questionItemId = "question-item-"+qno;
			$("#"+questionItemId).show();
			activeQuestion = $("#"+questionItemId);
			
			$("#"+qno).removeClass("btn-outline-secondary");
			$("#"+qno).addClass("btn-secondary");
		
		});	
		$("#next").on("click", function(){
			// if some radio value is checked, mark it as green 
			// and move to next question
			
			var ele = document.getElementsByName("options-for-"+qno);
			console.log(ele.length);
			for (var i=0;i<ele.length;i++){
				if (ele[i].checked){
					if (! $("#"+qno).hasClass("btn-success")){
						$("#"+qno).addClass("btn-success");
						answeredQues += 1;
						$("#questions-answered").text(answeredQues+" answered out of "+total);
					}
				}
			}
			
			activeQuestion.hide();
			qno = parseInt(qno)+1;
			qno = qno.toString();
			var questionItemId = "question-item-"+qno;
			$("#"+questionItemId).show();
			activeQuestion = $("#"+questionItemId);
			
			$("#"+qno).removeClass("btn-outline-secondary");
			$("#"+qno).addClass("btn-secondary");
			
			if(qno >= total){
				qno = total;
				$("button#next").text("Save&Finish");
			}
			if(qno > 1){
				$("button#previous").attr("disabled",false);
			}
			
		});
		
		$("#previous").on("click", function(){
			activeQuestion.hide();
			qno = parseInt(qno)-1;
			if(qno <= 0) qno = 1;
			qno = qno.toString();
			var questionItemId = "question-item-"+qno;
			$("#"+questionItemId).show();
			activeQuestion = $("#"+questionItemId);
			
			$("#"+qno).removeClass("btn-outline-secondary");
			$("#"+qno).addClass("btn-secondary");
			
			if(qno == 1){
				$("button#previous").attr("disabled",true);
			}
			if(qno == total){
				$("button#next").text("Save&Finish");
			}else{
				$("button#next").text("Save&Next");
			}
			
		});	
		
		
		
	});
	
</script>
	
<script>
$(document).ready(function(){
	$("form").submit( function(event){
		event.preventDefault();
		$("#myModal-submit").modal();
	});
	$("button#button-submit2").click( function(){
		$("#myModal-submit").modal('hide');
		startTimer(0);
		$(".timer-section, .main-div").css("display","none");
		$(".spinners-div").css("display","flex");
		getChosenAnswers();
		//console.log("answers marked: ",qA);
		$.ajax({
			url: '/examportal/EvaluateResult',
			type: 'POST',
			dataType: 'json',
			data: JSON.stringify(qA),
			contentType: 'application/json',
			mimeType: 'application/json',
			success: function(response){
				console.log("corrects: " + response);
				//alert("corrects: " + response);
				localStorage.setItem("corrects",parseInt(response));
				localStorage.setItem("count",answeredQues);
				window.location = "/examportal/TestEvaluate.jsp"
			}
		})
		
		
		
		
	});
});
</script>
</html>


