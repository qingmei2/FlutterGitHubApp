import 'package:flutter_rhine/common/common.dart';

class UserRepoRepository {
  UserRepoRepository._();

  static const String SORT_UPDATED = 'updated';
  static const String SORT_CREATED = 'created';
  static const String SORT_LETTER = 'full_name';

  /// 拉取用户Repo分页数据
  /// [username]  用户名
  /// [sort]      排序方式，当该参数发生了改变，clear列表并刷新ui
  /// [pageIndex] 分页索引
  static Future<DataResult<List<Repo>>> fetchRepos({
    final String username,
    final String sort = SORT_UPDATED,
    final int pageIndex,
  }) async {
    DataResult res = await serviceManager.netFetch(
        Api.userRepos(username) +
            Api.getPageParams('?', pageIndex) +
            '&sort=$sort',
        null,
        null,
        null);

    DataResult<List<Repo>> resultData;
    if (res != null && res.result) {
      final List<Repo> repos = getRepoList(res.data);

      if (repos.length > 0) {
        resultData = DataResult.success(repos);
      } else {
        resultData = DataResult.failure(Errors.emptyListException());
      }

      if (Config.DEBUG) {
        print("resultData events result " + resultData.result.toString());
        print(resultData.data);
        print(res.data.toString());
      }
    } else {
      resultData = DataResult.failure(Errors.networkException());
    }

    return resultData;
  }
}
