
const http = require('http');
const port = 8080;


let response = {
	success: true,
	error:	 ''
}		

function myFunction(data) {		// Put your code in this function
	console.log('Data: ' + JSON.stringify(data));
}


http.createServer(function(req, res) {
	console.log('URL: '				+ req.url);
	console.log('Method: '			+ req.method);
	console.log('Content-Type: '	+ req.headers['content-type']);
	console.log('Content-Length: '	+ req.headers['content-length']);
	
	if (req.method === 'POST') {
		let body = new Array();
		req.on('data', function(data) {
			body.push(data);
		})
		req.on('end', function() {
			let data = JSON.parse(Buffer.concat(body).toString());
			myFunction(data);
			res.writeHead(200, {'Content-Type': 'application/json'});
			res.end(JSON.stringify(response));
		})
	}
}).listen(port);

console.log('Server running at Port: ' + port);
