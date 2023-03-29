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

var scheduleBox = document.getElementsByClassName('box');
for(let i = 0; i < scheduleBox.length; i++){
    
}