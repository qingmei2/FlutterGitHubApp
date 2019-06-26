import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/constants/assets.dart';
import 'package:flutter_rhine/common/constants/colors.dart';
import 'package:flutter_rhine/common/model/repo.dart';

class MainRepoPagedItem extends StatelessWidget {
  final Repo repo;

  final MainRepoActionObserver observer;

  MainRepoPagedItem({Key key, @required this.repo, this.observer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _itemTopLayout(),
            _itemRepoName(),
            _itemRepoDesc(),
            _itemRepoOthers(),
            Container(
              margin: EdgeInsets.only(top: 12.0),
              child: Divider(
                height: 1.0,
                color: colorDivider,
              ),
            )
          ],
        ),
      ),
      onTap: () {
        observer(MainRepoAction(repo.url));
      },
    );
  }

  Widget _itemTopLayout() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // 头像
        Container(
          child: ClipOval(
            child: Image(
              width: 16.0,
              height: 16.0,
              image: NetworkImage(repo.owner.avatarUrl),
            ),
          ),
        ),
        // 仓库名
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 8.0),
            child: Text(
              repo.owner.login,
              maxLines: 1,
              style: TextStyle(fontSize: 12.0, color: colorPrimaryText),
            ),
          ),
        ),
        // 编程语言颜色
        ClipOval(
          child: Container(
            width: 7.0,
            height: 7.0,
            color: fetchLanguageColor(repo.language),
          ),
        ),
        // 编程语言
        Container(
          margin: EdgeInsets.only(left: 4.0),
          child: Text(
            repo.language ?? '',
            style: TextStyle(color: colorSecondaryTextGray, fontSize: 12.0),
          ),
        ),
      ],
    );
  }

  Widget _itemRepoName() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 6.0),
      child: Text(
        repo.name,
        maxLines: 1,
        style: TextStyle(
          color: colorPrimaryText,
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget _itemRepoDesc() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 6.0),
      child: Text(
        repo.description ?? '(No description, website, or topics provided.)',
        maxLines: 2,
        style: TextStyle(
          color: colorSecondaryTextGray,
          fontSize: 12.0,
        ),
      ),
    );
  }

  Widget _itemRepoOthers() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // star
          Image(
            image: AssetImage(reposStar),
            width: 13.0,
            height: 13.0,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 2.0, top: 2.0),
            child: Text(
              repo.stargazersCount.toString(),
              style: TextStyle(
                fontSize: 12.0,
                color: colorSecondaryTextGray,
              ),
            ),
          ),
          // fork
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10.0),
            padding: EdgeInsets.only(top: 2.0),
            child: Image(
              image: AssetImage(reposFork),
              width: 13.0,
              height: 15.0,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 2.0),
            child: Text(
              repo.forksCount.toString(),
              style: TextStyle(
                fontSize: 12.0,
                color: colorSecondaryTextGray,
              ),
            ),
          ),
          // issue
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 2.0, left: 10.0),
            child: Image(
              image: AssetImage(reposIssue),
              width: 13.0,
              height: 13.0,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 2.0, top: 2.0),
            child: Text(
              repo.openIssuesCount.toString(),
              style: TextStyle(
                fontSize: 12.0,
                color: colorSecondaryTextGray,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color fetchLanguageColor(final String language) {
    if (language == null) return Colors.transparent;
    Color color;
    switch (language) {
      case 'Kotlin':
        color = Color(0xFFF18E33);
        break;
      case 'Java':
        color = Color(0xFFB07219);
        break;
      case 'JavaScript':
        color = Color(0xFFF1E05A);
        break;
      case 'Python':
        color = Color(0xFF3572A5);
        break;
      case 'HTML':
        color = Color(0xFFE34C26);
        break;
      case 'CSS':
        color = Color(0xFF563D7C);
        break;
      case 'C++':
        color = Color(0xFFF34B7D);
        break;
      case 'C':
        color = Color(0xFF555555);
        break;
      case 'ruby':
        color = Color(0xFF701516);
        break;
      case 'Dart':
        color = Color(0xFF4FB1AA);
        break;
      default:
        color = Color(0xFF455a64);
    }

    return color;
  }
}

class MainRepoAction {
  final String repoUrl;

  MainRepoAction(this.repoUrl);
}

typedef MainRepoActionObserver(MainRepoAction nextAction);
