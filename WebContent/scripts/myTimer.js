function startTimer(mins){
		if (mins == 0){
			clearInterval(time);
			document.getElementById("timer").innerHTML =  "00 : 00";}
		else{

			var min = mins-1;
			var sec = 59;
			var mdisp = min;
			var sdisp = "59";
			var time = setInterval(myTimer, 1000);
			function myTimer(){
				
				if (sec < 10){
					sdisp = "0"+sec; 
				}
				if (min < 10){
					mdisp = "0"+min;
				}
				
				document.getElementById("timer").innerHTML = mdisp +" : "+ sdisp;
	
				sec--;
				sdisp = sec;
	
				
				if ((min < 0) ||(min == 0 && sec == -1)){
					clearInterval(time);
					alert("Your Time is Out!");
					
					document.getElementById("button-submit2").click();
					
				}
				if (sec == -1){
					min--;
					mdisp = min
					
					sec = 59
					sdisp = sec;
				}
				
			}
		}
}