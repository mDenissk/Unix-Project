
/* global $ */

function createTable(text)
{
	let t = document.createElement('TABLE');
	t.setAttribute('id','statsTable');
	document.body.appendChild(t);

	let tr, td, cell, idRow;

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
    document.getElementById('forTable').appendChild(t);
}

function createGraph(text)
{
    let canvas = document.getElementById('graphCanvas');
    let line = canvas.getContext('2d');

    let data = text.split('\n');
    data.pop();

    const heightMin = 190, heightMax = 10;
    const widthBegin = 10, widthEnd = 390;

    let a; // just small variable
    let numbers = [];
    let min,max;
    let dX,dY,x,y;
    let str = '';

    //we know that every second line is always "right now" field
    for (let i = 1 ; i < data.length ; i += 4)
    {
        a = data[i].split('|');
        a = a[0].replace(/\,/g,'')
        numbers.push(parseInt(a));
    }
    max = Math.max(...numbers);
    min = Math.min(...numbers);
    document.getElementById('maxValue').innerText = max + ' users online';
    document.getElementById('minValue').innerText = min + ' users online';

    dX = (widthEnd - widthBegin) / (numbers.length-1);
    dY = (heightMin - heightMax) / (max - min);

    //create first coordinates
    x = widthBegin;
    y = heightMin - dY*(numbers[0]-min);

    line.beginPath();
    line.moveTo(x,y);
    for (let i = 1 ; i < numbers.length ; i++)
    {
        x += dX;
        y = heightMin - dY*(numbers[i]-min)
        line.lineTo(x,y);
    }
    line.stroke();

    //we know that every first line is always "right now" field
    document.getElementById('timeValueMin').innerText = data[0].replace('<Hour>','');
    document.getElementById('timeValueMax').innerText = data[data.length-4].replace('<Hour>','');
}

function loadUsersOnline(url) {
    var xhr = new XMLHttpRequest();
    xhr.onload = function () {
        createTable(this.responseText)
    };
    xhr.open('GET', url);
    xhr.send();
}

function loadUsersOnlineBig(url) {
    var xhr = new XMLHttpRequest();
    xhr.onload = function () {
        createGraph(this.responseText)
    };
    xhr.open('GET', url);
    xhr.send();
}
loadUsersOnline('statsFile1.txt');
loadUsersOnlineBig('statsFile2.txt');
