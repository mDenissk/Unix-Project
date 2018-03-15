
/* global $ */

function createTable(text)
{
	let t = document.createElement('TABLE');
	t.setAttribute('id','statsTable');
	t.setAttribute('style','width:33%');
	document.body.appendChild(t);

	let tr;
	let td;
	let cell;
	let idRow;

    let element;
    text = text.split('\n');
    text.pop(); // remove empty ellement
    for (let i = 0 ; i < text.length ; i++)
    {
        element = text[i].split('|')
        idRow = 'lineTR' + i;

		tr = document.createElement('TR'); // create row
		tr.setAttribute('id', idRow);
    	document.getElementById('statsTable').appendChild(tr);

		td = document.createElement('TD'); // create column
    	cell = document.createTextNode(element[1].charAt(0).toUpperCase() 
                   					 + element[1].slice(1));
		td.appendChild(cell);
		document.getElementById(idRow).appendChild(td);

		td = document.createElement('TD'); // create column
		cell = document.createTextNode(element[0]);
		td.appendChild(cell);
		document.getElementById(idRow).appendChild(td);
    }
}

function populatePre(url) {
    var xhr = new XMLHttpRequest();
    xhr.onload = function () {
        createTable(this.responseText)
    };
    xhr.open('GET', url);
    xhr.send();
}
populatePre('statsFile1.txt');
