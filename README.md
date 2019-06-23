# FlutterGitHubApp

使用`Flutter`开发的`Github`客户端，适用于`Android`和`iOS`平台.

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


