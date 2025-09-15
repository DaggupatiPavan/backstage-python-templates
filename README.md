Setup dynamic plugin in redhat locally
### ~/rhdh/dynamic-plugins/wrappers/backstage-community-plugin-*/
```
cd ~/rhdh/dynamic-plugins/wrappers/
yarn build
cd ~/rhdh/dynamic-plugins/wrappers/backstage-community-plugin-*/ 
yarn
yarn export-dynamic
```
```
pkg=./
archive=$(npm pack --silent $pkg )
tar -xzf "$archive" && rm "$archive"
finalName=$(echo $archive | sed -e 's:\.tgz$::')
rm -fr "$finalName"
mv package "$finalName"
mv "$finalName" ~/rhdh/dynamic-plugins-root/

or else 
clone the repo, and cp script.sh to the path ~/rhdh/dynamic-plugins/wrappers/ and  run it
```
run above script in <here we need to run the script>

it generate a folder called backstage-community-plugin-rbac-1.42.0 <something like this>

#mv backstage-community-plugin-rbac-1.42.0 ~/rhdh/dynamic-plugins-root/

then go into the below path change the disablity to false for the particular plugin
```
cd ~/rhdh/
nano dynamic-plugins.default.yaml
```
search the plugin make to false
restart the server once again

===========================================
env values load 
```
pavan@PavanKumar:~/rhdh$ cat packages/backend/src/index.ts  | head -2
require('dotenv').config();
```
add at 1st line to accept env values
```
pavan@PavanKumar:~/rhdh/packages/backend$ cat .env
AUTH_GITHUB_CLIENT_ID=Or3123456789
GITHUB_TOKEN=github_patLt1234567890
AUTH_GITHUB_CLIENT_SECRET=ca1234567890
pavan@PavanKumar:~/rhdh/packages/backend$
```
