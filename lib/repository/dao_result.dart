import 'dart:async';

class DataResult<T> {
  T data;
  bool result;
  Future next;

  DataResult(this.data, this.result, {this.next});

  factory DataResult.failure() => DataResult<T>(null, false);

  factory DataResult.success(T data) => DataResult<T>(data, true);
}
