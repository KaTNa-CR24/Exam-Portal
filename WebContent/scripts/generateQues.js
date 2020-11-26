function createContainer(){
	var containerDiv = document.createElement("div");
	containerDiv.classList.add("container");
	return containerDiv;
}

function createRow(){
	var row = document.createElement("div");
	row.classList.add('row');
	return row;
}

function createColMD(size) {
	var col = document.createElement('div');
	col.classList.add('col-md-'+size);
	return col;
}

function createQuestionElement(data, qno, sno){
	var containerDiv = createContainer();
	containerDiv.setAttribute("id","question-item-"+sno);
	containerDiv.setAttribute("name",qno);
	containerDiv.classList.add("question-item");

// first row
	var row1 = createRow();
	var col_11 = createColMD(12);
	var queDesc = document.createElement("p");
		queDesc.innerHTML = data.description;
// second row
	var row2 = createRow();
	var col_21 = createColMD(6);
	var input1 = document.createElement("input");
		input1.setAttribute("type","radio");
		input1.setAttribute("id","optA");
		input1.setAttribute("name","options-for-"+sno);
		input1.setAttribute("value",data.optionA);	
	var label1 = document.createElement("label");
		label1.innerHTML = data.optionA;
		label1.classList.add("labels");

	var col_22 = createColMD(6);
	var input2 = document.createElement("input");
		input2.setAttribute("type","radio");
		input2.setAttribute("id","optB");
		input2.setAttribute("name","options-for-"+sno);
		input2.setAttribute("value",data.optionB);
	var label2 = document.createElement("label");
		label2.innerHTML = data.optionB;
		label2.classList.add("labels");
// third row
	var row3 = createRow();
	var col_31 = createColMD(6);
	var input3 = document.createElement("input");
		input3.setAttribute("type","radio");
		input3.setAttribute("id","optC");
		input3.setAttribute("name","options-for-"+sno);
		input3.setAttribute("value",data.optionC);
	var label3 = document.createElement("label");
		label3.innerHTML = data.optionC;
		label3.classList.add("labels");

	var col_32 = createColMD(6);
	var input4 = document.createElement("input");
		input4.setAttribute("type","radio");
		input4.setAttribute("id","optD");
		input4.setAttribute("name","options-for-"+sno);
		input4.setAttribute("value",data.optionD);
	var label4 = document.createElement("label");
		label4.innerHTML = data.optionD;
		label4.classList.add("labels");



	col_11.appendChild(queDesc);
	row1.appendChild(col_11);
	containerDiv.appendChild(row1);

	col_21.appendChild(input1);
	col_21.appendChild(label1);
	row2.appendChild(col_21);
	col_22.appendChild(input2);
	col_22.appendChild(label2);
	row2.appendChild(col_22);
	containerDiv.appendChild(row2);

	col_31.appendChild(input3);
	col_31.appendChild(label3);
	row3.appendChild(col_31);
	col_32.appendChild(input4);
	col_32.appendChild(label4);
	row3.appendChild(col_32);
	containerDiv.appendChild(row3);

	return containerDiv;

}


function createButton(){
	var btn = document.createElement("button");
	btn.classList.add("btn", "btn-outline-secondary", "sno");
	return btn;
}
//button 
function createButtonBox(sno,qno){
		var qbutton = createButton();
		qbutton.setAttribute("id",sno);
		qbutton.innerHTML = sno;
		
		return qbutton;
}


