
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	
	<script type="text/javascript" src="./scripts/que.js"></script>
	<script type="text/javascript" src="./scripts/generateQues.js"></script>
	
	
	<title>Test Evaluate</title>
</head>
<style>
	.progress{
		position: absolute;left:50.5%;top:10%;width:10%;height:80%;opacity: 1; filter: alpha(opacity=80);
	}
	.progress-bar{
		position:absolute; width: 100%;
		height: ;
		top: ;
	}
</style>
<body>
	
	<% 
		
	%>
	
	<h1> Thank You!  </h1>
	<!-- Bootstrap-Modal -->
	<div class="modal fade" id="myModal-result">
		<div class="modal-dialog modal-xl modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Your Score is Here!</h4>
				</div>
				<div class="modal-body">
					<div class = "container">
						<div class = "row">
							<div class="col-md-6">
								<p>Test Successfully complete</p>
								<p id="total-ques"></p>
								<p id = "attempted-count"></p>
								<p>You have marked <b id="corrects"></b> questions correctly</p>
								<br>
								<p id = "percentage" style="font-size:25px; font-weight:bold"></p>
							</div>
							<div class = "col-md-6">
								<div class="progress">
					  				<div class="progress-bar bg-info" style="width:100%" id = "progress-bar"></div>
								</div>
							</div>
							
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-lg btn-primary" id="button-submit2" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>


<script>

</script>

<script>

	$(document).ready(function(){
		$("#myModal-result").modal('show');
		$("#myModal-result").on('hidden.bs.modal',function(){

		});
	});
	var corrects = localStorage.getItem("corrects");
	var count = localStorage.getItem("count");
	var totalQues = localStorage.getItem("total");
	//alert("In TestEvaluate corrects:"+corrects);
	console.log("In TestEvaluate corrects:", corrects);
	document.getElementById("total-ques").innerHTML = "Total number of Questions: " +totalQues;
	document.getElementById("attempted-count").innerHTML = "Number of questions attempted: "+count;
	document.getElementById("corrects").innerHTML = corrects;
	var percentage = corrects/totalQues * 100;
	document.getElementById("percentage").innerHTML = "Your Performance is " + percentage+"%"; 
	
	var x = document.getElementById("progress-bar")
	x.innerHTML = percentage+"%";
	x.style.height = percentage + "%";
	x.style.top = 100-percentage + "%";

	
</script>
</html>