function ajax_post() {
    var data ={};
    request = new XMLHttpRequest();
    request.open('POST', "ajax_posts", true);
    request.setRequestHeader("Content-Type", "application/json");
    request.setRequestHeader("Accept", "application/json");
    request.onreadystatechange = function() {
        console.log(request.readyState);
        var element = document.getElementById('post');
        if (request.readyState == 4 && request.status == 200) {
            var responce = JSON.parse(request.responseText);
            console.log(responce.body);
            //element.insertAdjacentHTML("afterbegin", "test____test");
            //element.innerHTML = "";
            element.insertAdjacentHTML("afterbegin", responce.body);
        } else if(request.readyState != 4){
            //element.innerHTML = "loading...";
        }
    }
    request.onerror = function(e) {
         console.error(request.statusText);
    }
    console.log('hogehoge');

    console.log('hogehoge');
    data.body = document.getElementById("ajax_body").value;
    console.log(data);
    //request.send('body=' + encodeURIComponent(document.ajax.body.value));
    request.send(JSON.stringify(data));
    //request.send();
}