# 这是什么
- 编译angular 的docker环境
- 不是`ng build`那个编译
- https://github.com/angular/angular 此项目的编译

# 有什么用
- 不用在linux中配置各种环境编译,直接window上看代码,docker编译

# 使用
- 安装docker
- 根据dockerfile build
- 将源码挂载在/data上
- 进入容器后
> cd /data
> yarn
> cd /scripts
>  ./build-packages-dist.sh(可能拼错了.....)
# 缺点
- 默认会安装1.17的yarn,但是项目package支持1.16的,需要手动调高版本
- 如果你没爬山梯,请在yarn之前把相关seleuim的包和命令干掉
- 如果你没爬山梯,请在build脚本执行之前做好失败的准备
- 编译出来我不知道怎么用.........