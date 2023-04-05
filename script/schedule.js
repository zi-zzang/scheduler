var count = 0;
function closeModal(){
    var modal = document.getElementsByClassName("black-bg");

    //모든 black-bg
    for(var i = 0; i < modal.length; i++){
        modal[i].style.visibility = 'hidden';
    }
}

function addSchedule(){
    document.querySelector("#add-schedule-modal").style.visibility = 'visible';
}

function modifySchedule(){
    document.querySelector('#modify-schedule-modal').style.visibility='visible';
}

function deleteSchedule(){
    document.querySelector("#delete-schedule-modal").style.visibility='visible';
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


var choosenMonth = Number(document.querySelector('.choosen-month').textContent);
var choosenDay = Number(document.querySelector('.choosen-day').textContent);
console.log('현재 설정 날짜' + choosenMonth +'월'+choosenDay+'일');

function setLastDay(lastDay){
    console.log(lastDay);
}

function prevMonth(){
    choosenMonth --;
    document.querySelector('.choosen-month').textContent = choosenMonth;
    console.log(choosenMonth);
}

// for(let i = 1; i < choosenDay+1; i++){

//     var box = document.createElement('div');
//     var date = document.createElement('p');
//     var scheduleBox = document.createElement('div');
//     var scheduleContent = document.createElement('div');
//     var scheduleContent2 = document.createElement('div');
//     var scheduleItem = document.createElement('p');
//     var scheduleItem2 = document.createElement('p');
//     var modifyButton = document.createElement('button');
//     var deleteButton = document.createElement('button');
//     var line = document.createElement('span');

//     document.getElementById('wrap').appendChild(box);
//     box.appendChild(date);
//     box.appendChild(scheduleBox);
//     scheduleBox.appendChild(scheduleContent);
//     scheduleBox.appendChild(scheduleContent2);
//     scheduleContent.appendChild(scheduleItem);
//     scheduleContent.appendChild(scheduleItem2);

//     box.appendChild(line);

//     box.classList.add('box');
//     if(i === 1){
//         box.classList.add('first-box');
//     }
   
//     date.classList.add('date');
//     scheduleBox.classList.add('schedule-box');
//     scheduleContent.classList.add('schedule-content');
//     scheduleContent2.classList.add('schedule-content2');
//     scheduleItem.classList.add('schedule-item');
//     scheduleItem2.classList.add('schedule-item2');

    
//     date.innerHTML = `${choosenMonth}월 ${i}일`;
//     scheduleContent2.appendChild(modifyButton);
//     scheduleContent2.appendChild(deleteButton);
//     modifyButton.classList.add('buttons');
//     modifyButton.classList.add('modify');
//     modifyButton.classList.add('hide');
//     deleteButton.classList.add('buttons');
//     deleteButton.classList.add('delete');
//     deleteButton.classList.add('hide');
//     line.classList.add('line');
//     line.classList.add('hide');
//     scheduleItem.innerHTML = '09:00';
//     scheduleItem2.innerHTML = '기상하기';
//     modifyButton.innerHTML = '수정';
//     deleteButton.innerHTML = '삭제';
// }

var prevButton = document.getElementsByClassName('.arrow-left');
var nextButton = document.getElementsByClassName('.arrow-right');


console.log(document.getElementById('position').textContent);
if(document.getElementById('position').textContent == '팀장'){
    document.querySelector('.team').style.display = 'block';
}else{
    document.querySelector('.team').style.display = 'none';
}
