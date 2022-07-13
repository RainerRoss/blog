# Work with Node.js on IBM i

## Install Node.js with Access Client Solutions
* Select Open Source Package Management
* Connect with SSH
* Available Packages
* Select Nodejsxx and click install

## Install Node.js with YUM
```
5250> call qp2term
$ PATH=/QOpenSys/pkgs/bin:$PATH 
export PATH                   
$ yum install nodejs18
```

## Check your Node.js version
```
5250> qsh 
$ node -v
v18.0.0   
```

## Install Node.js packages with npm (Node Package Manager)

* Search your package here [NPM](https://www.npmjs.com/)
* Install your package e.g. [idb-connector](https://www.npmjs.com/package/idb-connector)
```
5250> qsh 
$ npm i idb-connector
```

## List the Node.js packages with npm (Node Package Manager)
```
5250> qsh 
$ npm ls
home@ /home                     
+-- axios@0.27.2                
+-- idb-connector@1.2.16        
+-- itoolkit@1.0.0              
+-- twilio@3.78.0               
`-- xml2js@0.4.23               

```

## Create a folder for the Node.js programs
```
5250> qsh
$ mkdir -p /home/nodejs
```

## Create a new file HelloWorld.js' in this folder and put this statement in the file
```
console.log('Hello World');
```

## Run the HelloWorld.js program
```
5250> qsh
$ node /home/nodejs/helloworld.js

