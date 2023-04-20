// 모달 닫기
function closeModal(){
    var modal = document.getElementsByClassName("black-bg");
    //모든 black-bg
    for(var i = 0; i <modal.length; i++){
        modal[i].style.visibility = 'hidden';
    }
}

//일정 추가
function addSchedule(){
    document.querySelector("#add-schedule-modal").style.visibility = 'visible';
}

// 내비게이션 메뉴
function navigationMenu(){
    document.querySelector(".menu-bar").style.left = 0;
    document.querySelector("#menu-bar").style.visibility='visible';
}

// 메뉴 닫기
function closeNavigationMenu(){
    document.querySelector(".menu-bar").style.left = '-61%';
    document.querySelector("#menu-bar").style.visibility='hidden';
}

// 메뉴 열기
function menuOpen(){
        count++;
        document.querySelector('.member').style.display = 'block';
    if(count%2==0){
        document.querySelector('.member').style.display = 'none';
    }
}

// 팀장, 관리자만 팀원 이름 조회
if(document.getElementById('position').textContent == '팀장' ||document.getElementById('position').textContent == '관리자'){
    document.querySelector('.team').style.display = 'block';
    }else{
        document.querySelector('.team').style.display = 'none';
        document.querySelector('.member').style.display = 'none';
    }


//일정 삭제             
function deleteModal(idx){
    console.log(idx)
    document.querySelector('#delete-schedule-modal').style.visibility='visible';
    var yesButton = document.getElementById('delete-modal-yes');
    var noButton = document.getElementById('delete-modal-no');
    ;
    yesButton.onclick = function() {
        document.querySelector('#delete-schedule-modal').style.visibility = 'hidden';
        
        window.location='deleteScheduleAction.jsp?schedule_idx='+idx;
    };

    noButton.onclick = function() {
        document.querySelector('#delete-schedule-modal').style.visibility = 'hidden';
    };
}

//일정 수정
function modifyModal(idx,contents){
    console.log(idx, contents)
    // console.log(idx,contents.childNodes[0].innerText);
    document.querySelector('#modify-schedule-modal').style.visibility='visible';
    var yesButton = document.getElementById('modify-modal-yes');
    var noButton = document.getElementById('modify-modal-no');
    
    yesButton.onclick = function() {
        document.querySelector('#modify-schedule-modal').style.visibility = 'hidden';
        var changeScheduleItem = document.createElement("input"); //11
        var changeScheduleItem3 = document.createElement("input");//00
        var changeScheduleItem4 = document.createElement("input"); //내용

        var hour = contents.previousSibling.childNodes[0];
        var minute = contents.previousSibling.childNodes[2];
        var content = contents.previousSibling.childNodes[3];

        var saveButton = contents.childNodes[2]
        var cancelButton = contents.childNodes[3]
        var modifyButton = contents.childNodes[0]
        var deleteButton = contents.childNodes[1]
        changeScheduleItem.type = "text";
        changeScheduleItem3.type = "text";
        changeScheduleItem4.type = "text";

        changeScheduleItem.value = hour.innerText;
        changeScheduleItem3.value = minute.innerText;
        hour.parentNode.replaceChild(changeScheduleItem,hour);

        minute.parentNode.replaceChild(changeScheduleItem3,minute);
        changeScheduleItem.classList.add('time');
        changeScheduleItem3.classList.add('time');
            
        
        changeScheduleItem4.value = content.innerText;
        // console.log(changeScheduleItem4)
        content.parentNode.replaceChild(changeScheduleItem4,content);
        changeScheduleItem4.classList.add('content');
        
        saveButton.classList.remove('hide'); // 저장버튼 활성화
        cancelButton.classList.remove('hide'); // 취소버튼 활성화
        
        modifyButton.classList.add('hide'); // 수정버튼 비활성화
        deleteButton.classList.add('hide'); // 삭제버튼 비활성화
        
        saveButton.onclick = function(){
            window.location='modifyScheduleAction.jsp?schedule_idx='+idx+'&hour='+changeScheduleItem.value+'&minute='+changeScheduleItem3.value+'&content='+changeScheduleItem4.value;
        }
        cancelButton.onclick = ()=>{
            changeScheduleItem.parentNode.replaceChild(hour,changeScheduleItem);
            changeScheduleItem3.parentNode.replaceChild(minute,changeScheduleItem3);
            changeScheduleItem4.parentNode.replaceChild(content,changeScheduleItem4);
            saveButton.classList.add('hide')
            cancelButton.classList.add('hide')
            
            modifyButton.classList.remove('hide')
            deleteButton.classList.remove('hide')
        };
    };
}