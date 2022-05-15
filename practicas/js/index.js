function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min) + min); //The maximum is exclusive and the minimum is inclusive
}

const randomID = getRandomInt(1, 60);
const linkToFetch =
  "https://picsum.photos/v2/list?page=" + randomID + "&limit=7";

fetch(linkToFetch)
  .then(function(response) {
    if (!response.ok) {
      throw new Error("HTTP error, status = " + response.status);
    }
    return response.json();
  })
  .then(function(data) {
    console.log(data);
    for (let i = 1; i <= 6; i++) {
      const td = document.getElementById("td" + i);
      id = data[i].id;
      author = data[i].author;
      td.innerHTML +=
        '<img src="https://picsum.photos/id/' +
        id +
        '/200/300"><br><b>Autor: </b>' +
        author;
    }
  })
  .catch(function(error) {
    var p = document.createElement("p");
    p.appendChild(document.createTextNode("Error: " + error.message));
    document.body.insertBefore(p, myList);
  });
