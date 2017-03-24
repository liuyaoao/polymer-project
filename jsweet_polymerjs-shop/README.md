# jsweet+Polymerjs simple shop app

## Pre-requisits

* Ensure java version is 8 using `java -version`
* Ensure maven command line (mvn) is in PATH by typing `mvn -version`, if command not found, download apache maven 3.3.x and include its bin folder in PATH, then try again
* Ensure node packet manager (npm) is in PATH by typing `npm -v`, if command not found, download and install NodeJS, then try again
* Install Cordova >= 5.3 if not done yet: `npm install cordova@5.3.3 -g`, -g switch means install globally

## Compiling

Compile JSweet using
```
mvn clean generate-sources
mvn generate-sources
```

JavaScript files are generated in `www/js/app/`, check that they are up to date

## Running
```
运行这个示例的简单的方式是把www文件夹整个copy放在tomcat的安装目录的webapps目录下，最好把www文件夹名改一下。
然后重启tomcat,直接就可以通过localhost:8080/xxxx访问了。
```
```
还有种方式就是直接给当前的www夹新建一个虚拟主机，在tomcat里新增一个host和配置好host文件里的ip和域名(polymershop.com)。
浏览器里输入：polymershop.com:8080直接可以访问。

```
Run using cordova, for instance:
```
cordova platform add browser
mvn run browser
```
OR
```
cordova platform add android
mvn run android
```
# 相关的学习参考网站
## jsweet 的官网：http://www.jsweet.org/

##polymerjs框架的官网： http://polymer-zh.cn/

## 查找一些前端相关js库和框架的jsweet-candies版本的地址：http://www.jsweet.org/candies-snapshots/

##本项目使用到polymerjs的jsweet-candies的maven依赖包的地址：http://public.jsweet.org/apidocs/snapshots/org/jsweet/candies/polymer/

##也有基于polymer的typeScript版本的polymer-ts依赖包地址：http://public.jsweet.org/apidocs/snapshots/org/jsweet/candies/polymer-ts/ 。
