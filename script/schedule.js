var choosenDay = Number('<%=choosenDay%>');
var choosenMonth = Number('<%=choosenMonth%>');
//데이터 array
var data = <%=array%>;
let i;
console.log(data[i]);
// let scheduleIdx;
var count = 0;

function closeModal(){
    var modal = document.getElementsByClassName("black-bg");
    //모든 black-bg
    for(var i = 0; i <modal.length; i++){
        modal[i].style.visibility = 'hidden';
    }
}
function addSchedule(){
document.querySelector("#add-schedule-modal").style.visibility = 'visible';
}
function modifySchedule(){
    // window.location='modifyScheduleAction.jsp?schedule_idx='+scheduleIdx+'&month='+month+'&day='+day+'&hour='+hour+'&minute='+minute+'&content='+content;
}
function deleteSchedule(){
window.location=`deleteScheduleAction.jsp?schedule_idx=`;
// console.log(data[index][5]);
}
function modifyModal(){
document.querySelector('#modify-schedule-modal').style.visibility='visible';
}

function deleteModal(){
document.querySelector('#delete-schedule-modal').style.visibility='visible';
var yesButton = document.getElementById('delete-modal-yes');
var noButton = document.getElementById('delete-modal-no');

yesButton.onclick = function() {
    document.querySelector('#delete-schedule-modal').style.visibility = 'hidden';
    deleteSchedule(data[i][5]);
};

noButton.onclick = function() {
    modal.style.visibility = 'hidden';
};
}

function modifyAction(){
    // var modifyContent = document.querySelector('.schedule-content[name="''"]');
}

function navigationMenu(){
document.querySelector(".menu-bar").style.left = 0;
document.querySelector("#menu-bar").style.visibility='visible';
}

function closeNavigationMenu(){
document.querySelector(".menu-bar").style.left = '-61%';
document.querySelector("#menu-bar").style.visibility='hidden';
}

function menuOpen(){
count++;
document.querySelector('.member').style.display = 'block';
if(count%2==0){
document.querySelector('.member').style.display = 'none';
}
}

if(document.getElementById('position').textContent == '팀장'){
document.querySelector('.team').style.display = 'block';
}else{
document.querySelector('.team').style.display = 'none';
}
for(i = 0; i < data.length; i++){
    console.log(data,data[i],data[i][5]);
    var box = document.createElement('div');
    document.getElementById('wrap').appendChild(box);
    var date = document.createElement('p');
    var scheduleBox = document.createElement('form');
    var scheduleContent = document.createElement('div');
    var scheduleContent2 = document.createElement('div');
    var scheduleItem = document.createElement('p');
    var scheduleItem2 = document.createElement('p');
    var modifyButton = document.createElement('input');
    var deleteButton = document.createElement('input');
    var line = document.createElement('span');
    box.appendChild(date);
    box.appendChild(scheduleBox);
    scheduleBox.appendChild(scheduleContent);
    scheduleBox.appendChild(scheduleContent2);
    scheduleContent.appendChild(scheduleItem);
    scheduleContent.appendChild(scheduleItem2);
    box.appendChild(line);
    box.classList.add('box');
    date.classList.add('date');
    scheduleBox.classList.add('schedule-box');
    scheduleContent.classList.add('schedule-content');
    scheduleBox.setAttribute('action','deleteScheduleAction.jsp?schedule_idx='+data[i][5]);
    scheduleContent.setAttribute('name',data[i][5]);
    // console.log(scheduleIdx);
    scheduleContent2.classList.add('schedule-content2');
    scheduleItem.classList.add('schedule-item');
    scheduleItem2.classList.add('schedule-item2');
    date.innerHTML = data[i][0]+'월'+ data[i][1]+'일';
    scheduleContent2.appendChild(modifyButton);
    scheduleContent2.appendChild(deleteButton);
    modifyButton.classList.add('buttons');
    modifyButton.classList.add('modify');
    modifyButton.onclick = modifyModal;
    modifyButton.setAttribute('type','button');
    deleteButton.classList.add('buttons');
    deleteButton.classList.add('delete');
    deleteButton.setAttribute('type','button');
    deleteButton.onclick = deleteModal;
    line.classList.add('line');
    scheduleItem.innerHTML = data[i][2]+":"+data[i][3];
    scheduleItem2.innerHTML = data[i][4];   
    modifyButton.value = '수정';
    deleteButton.value = '삭제';
}