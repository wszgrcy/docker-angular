# 这是什么
- 编译angular 的docker环境
- 不是`ng build`那个编译
- https://github.com/angular/angular 此项目的编译

# 有什么用
- 不用在linux中配置各种环境编译,直接window上看代码,docker编译
# 注意事项
- 源码需要从docker中git(从win上提前获得的源码是crlf的,没法编译.......当然你要在linux中跳过此条)
- 默认会安装1.17的yarn,但是项目package支持1.16的,需要手动调高版本
- 如果你没爬山梯,请在yarn之前把相关seleuim的包和命令干掉
- 如果你没爬山梯,请在build脚本执行之前做好失败的准备
- 构建成功后再次构建需要删除缓存,否则还是会请求到之前的(这个目录我估计每个人的不同.可以输出package-builder.sh中的bin目录查看)
> rm -rf /root/.cache/bazel/_bazel_root/4caa791091d21d23e63637080226f370/execroot/angular/bazel-out/k8-fastbuild/bin/packages/
# 摸索
- 将普通项目的angular部分包替换为打包好的
```json
{
  "name": "demo-ng821",
  "version": "0.0.0",
  "scripts": {
    "ng": "ng",
    "start": "ng serve",
    "build": "ng build",
    "test": "ng test",
    "lint": "ng lint",
    "e2e": "ng e2e"
  },
  "private": true,
  "dependencies": {
    "@angular/animations": "../../git/angular/dist/packages-dist/animations",
    "@angular/common": "../../git/angular/dist/packages-dist/common",
    "@angular/compiler": "../../git/angular/dist/packages-dist/compiler",
    "@angular/core": "../../git/angular/dist/packages-dist/core",
    "@angular/forms": "../../git/angular/dist/packages-dist/forms",
    "@angular/platform-browser": "../../git/angular/dist/packages-dist/platform-browser",
    "@angular/platform-browser-dynamic": "../../git/angular/dist/packages-dist/platform-browser-dynamic",
    "@angular/router": "../../git/angular/dist/packages-dist/router",
    "rxjs": "~6.4.0",
    "tslib": "^1.10.0",
    "zone.js": "~0.9.1"
  },
  "devDependencies": {
    "@angular-devkit/build-angular": "~0.802.1",
    "@angular/cli": "~8.2.1",
    "@angular/compiler-cli": "../../git/angular/dist/packages-dist/compiler-cli",
    "@angular/language-service": "../../git/angular/dist/packages-dist/language-service",
    "@types/node": "~8.9.4",
    "@types/jasmine": "~3.3.8",
    "@types/jasminewd2": "~2.0.3",
    "codelyzer": "^5.0.0",
    "jasmine-core": "~3.4.0",
    "jasmine-spec-reporter": "~4.2.1",
    "karma": "~4.1.0",
    "karma-chrome-launcher": "~2.2.0",
    "karma-coverage-istanbul-reporter": "~2.0.1",
    "karma-jasmine": "~2.0.1",
    "karma-jasmine-html-reporter": "^1.4.0",
    "protractor": "~5.4.0",
    "ts-node": "~7.0.0",
    "tslint": "~5.15.0",
    "typescript": "~3.5.3"
  }
}

```

- 第一次构建出来,包名中有`.with-local-changes`结果npm i 报错,所以把一个文件修改了
```js
//tools\bazel_stamp_vars.js
//原来这里有个附加个后缀的,去掉了
const BUILD_SCM_VERSION = BUILD_SCM_VERSION_RAW.replace(/-([0-9]+)-g/, '+$1.sha-');
console.log(`BUILD_SCM_VERSION ${BUILD_SCM_VERSION}`);
```
- 目前`ng serve还是报错`
# 使用
- 安装docker
- 根据dockerfile build
- 将源码目录挂载在/data上
- 进入容器后
> cd /data (如果没源码需要先克隆源码)  
> yarn   
> cd /scripts   
> ./build-packages-dist.sh  
# 缺点
- 编译出来我不知道怎么用.........
> 最后一次状态:构建成功-> ng new 一个项目-> 把package.json中的包替换为编译好的路径->npm i->ng serve报错

```
[error] Error: Cannot find module '@angular/compiler-cli/src/ngtsc/file_system'
    at Function.Module._resolveFilename (internal/modules/cjs/loader.js:580:15)
    at Function.Module._load (internal/modules/cjs/loader.js:506:25)
    at Module.require (internal/modules/cjs/loader.js:636:17)
    at require (internal/modules/cjs/helpers.js:20:18)
    at E:\Code\angular\git\angular\dist\packages-dist\compiler-cli\index.js:20:25
    at E:\Code\angular\git\angular\dist\packages-dist\compiler-cli\index.js:3:17
    at Object.<anonymous> (E:\Code\angular\git\angular\dist\packages-dist\compiler-cli\index.js:9:3)
    at Module._compile (internal/modules/cjs/loader.js:688:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:699:10)
    at Module.load (internal/modules/cjs/loader.js:598:32)
    at tryModuleLoad (internal/modules/cjs/loader.js:537:12)
    at Function.Module._load (internal/modules/cjs/loader.js:529:3)
    at Module.require (internal/modules/cjs/loader.js:636:17)
    at require (internal/modules/cjs/helpers.js:20:18)
    at Object.<anonymous> (E:\Code\angular\testclass\demo-ng821\node_modules\@ngtools\webpack\src\angular_compiler_plugin.js:12:24)
    at Module._compile (internal/modules/cjs/loader.js:688:30)
```