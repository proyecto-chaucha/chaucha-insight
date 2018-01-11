#Chaucha Insight

Install script for litecore-node + insight modified for CHA

##Instructions:

```
git clone https://github.com/devminercl/chaucha-insight.git
cd chaucha-insight
```
* Edit chaucha.conf to match your desired parameters (e.g. rpcpassword)
* Install [nvm](https://github.com/creationix/nvm)
```
nvm install v4
```
* Optional: If you don't want to use the supplied chauchad, you need to patch and compile the official chauchad
* Clone the official chaucha repository
* Patch with the supplied chaucheracore.patch file with -p1 argument (patch -p1 > chauchacore.patch)
* Compile and replace the chauchad binary (refer to the official chaucha documentation)
* Edit the deploy.sh script
* Run deploy.sh
```
sh deploy.sh
```
* Go into your node directory
* Start with the chaucha node with insight with:
```
node_modules/litecore-node/bin/litecore-node start
```
* Use whatever tool you use to start/stop/restart your node applications.
