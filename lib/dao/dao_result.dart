import 'dart:async';

class DataResult {
  var data;
  bool result;
  Future next;

  DataResult(this.data, this.result, {this.next});

  factory DataResult.failure() => DataResult(null, false);

  factory DataResult.success(dynamic data) => DataResult(data, true);
}
