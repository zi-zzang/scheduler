function confirmModal(message){
    var blackBg = document.createElement('div');
    var modal = document.createElement('div');
    var bold = document.createElement('p');
    var form = document.createElement('form');
    var submit = document.createElement('input');
    var button = document.createElement('input');

    document.getElementById('wrap').appendChild(blackBg);
    blackBg.appendChild(modal);
    modal.appendChild(bold);
    modal.appendChild(form);
    form.appendChild(submit);
    form.appendChild(button);

    blackBg.classList.add('black-bg');
    modal.classList.add('modal');
    bold.classList.add('bold');
    submit.classList.add('buttons');
    button.classList.add('buttons');
    
}