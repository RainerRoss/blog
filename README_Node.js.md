# Work with Node.js on IBM i

## Install Node.js with YUM
```
5250> call qp2term
$ PATH=/QOpenSys/pkgs/bin:$PATH 
export PATH                   
$ yum install nodejs18
```

## Install Node.js with Access Client Solutions
* Select Open Source Package Management
* Connect with SSH
* Available Packages
* Select Nodejsxx and click install

## Check your Node.js version
```
5250> qsh 
$ node -v
v18.0.0   
```
## Install Node.js packages with npm (Node Package Manager) - you find all the packages [here](https://www.npmjs.com/)
```
5250> qsh 
$ node -v
v18.0.0   
```

## Manual Install
```
5250> qsh
$ mkdir -p /home/node  (for the sendSMS.js)
```
## Start the Node.js program on your IBM i
```
5250> qsh
$ node /home/node/sendSMS.js
