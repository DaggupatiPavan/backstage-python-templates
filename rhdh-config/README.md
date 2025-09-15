for kubernetes setup follow below steps
```
cd ~/rhdh/packages/backend
yarn add @backstage/plugin-kubernetes-backend
yarn add @backstage/plugin-kubernetes
yarn install
```
then 
go in to src folder open index.ts file
```
nano ~/rhdh/packages/backend/src/index.ts

backend.add(import('@backstage/plugin-kubernetes-backend'));
# add above line in index.ts file 
```
After that run proxy in kubernetes server for that run below cmd
```
kubectl proxy --port=8001
```
