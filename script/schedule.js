// var count = 0;
// function closeModal(){
//     var modal = document.getElementsByClassName("black-bg");

//     //모든 black-bg
//     for(var i = 0; i < modal.length; i++){
//         modal[i].style.visibility = 'hidden';
//     }
// }

// function addSchedule(){
//     document.querySelector("#add-schedule-modal").style.visibility = 'visible';
// }

// function modifySchedule(){
//     document.querySelector('#modify-schedule-modal').style.visibility='visible';
// }

// // function deleteModal(){
// //     document.querySelector('#delete-schedule-modal').style.visibility= "visible";
// // }

// function realDelete(){
//     window.location='deleteScheduleAction.jsp?schedule_idx='+scheduleIdx;
// }
// function navigationMenu(){
//     document.querySelector(".menu-bar").style.left = 0;
//     document.querySelector("#menu-bar").style.visibility='visible';
// }
// function closeNavigationMenu(){
//     document.querySelector(".menu-bar").style.left = '-61%';
//     document.querySelector("#menu-bar").style.visibility='hidden';
// }

// function menuOpen(){
//     count++;
//     document.querySelector('.member').style.display = 'block';
//     if(count%2==0){
//     document.querySelector('.member').style.display = 'none';
//     }
// }

// function setLastDay(lastDay){
//     console.log(lastDay);
// }

// function prevMonth(){
//     choosenMonth --;
//     document.querySelector('.choosen-month').textContent = choosenMonth;
//     console.log(choosenMonth);
// }

// var prevButton = document.getElementsByClassName('.arrow-left');
// var nextButton = document.getElementsByClassName('.arrow-right');


// if(document.getElementById('position').textContent == '팀장'){
//     document.querySelector('.team').style.display = 'block';
// }else{
//     document.querySelector('.team').style.display = 'none';
// }

for(let j = 1; j <31+1; j++){
    var choosenDay = Number('<%=choosenDay%>');
    var choosenMonth = Number('<%=choosenMonth%>');
    var box = document.createElement('div');
    var date = document.createElement('p');
    var scheduleBox = document.createElement('div');
    var scheduleContent = document.createElement('div');
    var scheduleContent2 = document.createElement('div');
    var scheduleItem = document.createElement('p');
    var scheduleItem2 = document.createElement('p');
    var modifyButton = document.createElement('button');
    var deleteButton = document.createElement('button');
    var line = document.createElement('span');
    
    document.getElementById('wrap').appendChild(box);
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
    
    scheduleContent2.classList.add('schedule-content2');
    scheduleItem.classList.add('schedule-item');
    scheduleItem2.classList.add('schedule-item2');
    
    
    date.innerHTML = '<%=choosenMonth%>월'+j+'일';
    
    
    
    modifyButton.classList.add('buttons');
    modifyButton.classList.add('modify');
    modifyButton.id='modify-schedule-modal';
    modifyButton.onclick = modifyModal;
    
    deleteButton.classList.add('buttons');
    deleteButton.classList.add('delete');
    deleteButton.id='delete-schedule-modal';
    deleteButton.onclick = deleteModal;
    }
