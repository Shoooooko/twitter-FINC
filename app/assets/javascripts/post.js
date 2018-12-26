function ajax_post() {
  var data = {};
  request = new XMLHttpRequest();
  request.open('POST', "/api/posts", true);
  request.setRequestHeader("Content-Type", "application/json");
  request.setRequestHeader("Accept", "application/json");
  var element = document.getElementById('post');
  request.onreadystatechange = function () {
    console.log("statechange");
    var element = document.getElementById('post');
    if (request.readyState == 4 && request.status == 200) {
      var response = JSON.parse(request.responseText);
      element.insertAdjacentHTML("afterBegin", `
      <tr><td></td>
      <td>${response.body}</td>
      <td colspan="2"></td>
      <td><a href="/posts/${response.id}">Show</a></td>
      <td><a href="/posts/${response.id}/edit">Edit</a></td>
      <td><a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/posts/${response.id}">Destroy</a></td>
      </tr>`);
      element = response.body;
    }
  }
  request.onerror = function (e) {
    console.error(request.statusText);
  }
  data.body = document.getElementById("ajax_body").value;
  console.log("bodyget")
  data.trans = document.getElementById("ajax_trans").value;
  console.log("bodytrans")
  //console.log(data);
  request.send(JSON.stringify(data));
}