# FlutterGitHubApp

使用`Flutter`开发的`Github`客户端，适用于`Android`和`iOS`平台，页面功能简单，易于上手学习`Flutter`。

项目提供了多种 **状态管理** 组件对应的实现方式，开发者只需切换对应的 **分支**，便可以根据自己感兴趣的模式进行学习开发：

* [basic_provider   ](https://github.com/qingmei2/FlutterGitHubApp/tree/basic_provider): `Google`官方推荐的 [provider](https://github.com/rrousselGit/provider) 库；
* [basic_bloc_rxdart](https://github.com/qingmei2/FlutterGitHubApp/tree/basic_bloc_rxdart): 经典的 [bloc](https://github.com/felangel/bloc) 模式的实现案例，适用于复杂的业务场景开发；
* [basic_fish_redux ](https://github.com/qingmei2/FlutterGitHubApp/tree/basic_fish_redux) (开发中...): 阿里巴巴前端团队推出的状态管理解决方案[fish-redux](https://github.com/alibaba/fish-redux);

* master(当前项目的默认分支)： 该分支始终展示的是最新稳定版本的状态管理实践，目前展示的是 **bloc_rxdart** 模式的开发示例。

## 通知

* 下载后，编译遇到错误？

> 如果遇到 `Error: Error when reading 'lib/common/constants/ignore.dart': No such file or directory` 的错误，请参考下方【开始使用】，对项目进行配置。


## 屏幕截图

<div align:left;display:inline;>
<img width="203" height="438" src="https://github.com/qingmei2/FlutterGitHubApp/blob/master/art/login.png"/>
<img width="203" height="438" src="https://github.com/qingmei2/FlutterGitHubApp/blob/master/art/home.png"/>
<img width="203" height="438" src="https://github.com/qingmei2/FlutterGitHubApp/blob/master/art/repos.png"/>
<img width="203" height="438" src="https://github.com/qingmei2/FlutterGitHubApp/blob/master/art/profile.png"/>
</div>

## 开始使用

* 1.直接通过git命令行进行clone:

```shell
$ git clone https://github.com/qingmei2/FlutterGitHubApp.git
```

* 2.注册你的GithubApp

首先打开[这个链接](https://github.com/settings/applications/new),注册属于你的`OAuth Application`：

<div align:left;display:inline;>
<img width="480" height="480" src="https://github.com/qingmei2/MVI-Rhine/blob/master/screenshots/regist_step1.png"/>
</div>

注册完成后，记住下面的`Client ID`和`Client Secret`,新建并配置到你的项目根目录的`lib\common\constants\ignore.dart`文件中：

<div align:left;display:inline;>
<img width="550" height="384" src="https://github.com/qingmei2/MVI-Rhine/blob/master/screenshots/regist_step2.png"/>
</div>

```dart
class Ignore {
  static const String clientId = 'xxxxxx';
  static const String clientSecret ='xxxxxxx';
}
```

大功告成，接下来点击编译并运行即可。:tada: :tada: :tada:


## 感谢

:art: 项目中的UI设计部分参考了 [gitme](https://github.com/flutterchina/gitme).

:star: 项目参考了 [GSYGithubAppFlutter](https://github.com/CarGuo/GSYGithubAppFlutter) 并对其部分代码进行了引用.

## 其他开源项目

> [MVVM-Rhine: MVVM + Jetpack 架构组件的Github客户端。](https://github.com/qingmei2/MVVM-Rhine)

> [MVI-Rhine: 基于Jetpack + MVVM, 更加响应式&函数式的编程实践](https://github.com/qingmei2/MVI-Rhine)

> [RxImagePicker: 灵活的Android图片选择器，提供了知乎和微信主题的支持](https://github.com/qingmei2/RxImagePicker)

## License

    The FlutterGitHubApp: Apache License

    Copyright (c) 2019 qingmei2

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
