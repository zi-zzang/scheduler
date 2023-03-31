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
}
function closeNavigationMenu(){
    document.querySelector(".menu-bar").style.left = '-61%';
}

function menuOpen(){
    count++;
    document.querySelector('.member').style.display = 'block';
    if(count%2==0){
    document.querySelector('.member').style.display = 'none';
    }
}


// 일정 출력 (추후 Lastday 구할 예정)
for(let i = 1; i < 32; i++){

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
    scheduleContent2.appendChild(modifyButton);
    scheduleContent2.appendChild(deleteButton);
    box.appendChild(line);

    box.classList.add('box');
    date.classList.add('date');
    scheduleBox.classList.add('schedule-box');
    scheduleContent.classList.add('schedule-content');
    scheduleContent2.classList.add('schedule-content2');
    scheduleItem.classList.add('schedule-item');
    scheduleItem2.classList.add('schedule-item2');
    modifyButton.classList.add('buttons');
    modifyButton.classList.add('modify');
    deleteButton.classList.add('buttons');
    deleteButton.classList.add('delete');
    line.classList.add('line');

    date.innerHTML = `3월 ${i}일`;
    scheduleItem.innerHTML = '09:00';
    scheduleItem2.innerHTML = '기상하기';
    modifyButton.innerHTML = '수정';
    deleteButton.innerHTML = '삭제';
    console.log(i);
}
