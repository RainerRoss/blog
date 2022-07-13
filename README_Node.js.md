# Work with Node.js on IBM i

## Install Node.js with YUM
```
5250> call qp2term
$ PATH=/QOpenSys/pkgs/bin:$PATH 
export PATH                   
$ yum install nodejs18
```
## Install Node.js with Access Client Solutions
```
5250> call qp2term
$ PATH=/QOpenSys/pkgs/bin:$PATH 
export PATH                   
$ yum install nodejs18
```
## You need
```
- Node.js version 10 or higher - actually Node.js v18 
  Install Node.js with Access Client Solutions Open Source Package Management or with "yum install nodejs18"
- Install Twilio Node.js API: npm install twilio
- The Twilio credentials - accountSid, authToken - from www.twilio.com/console
```
## Check your Node.js version
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
