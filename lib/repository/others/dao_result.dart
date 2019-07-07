class DataResult<T> {
  T data;
  bool result;
  Exception exception;

  DataResult(
    this.data,
    this.result, {
    this.exception,
  });

  factory DataResult.failure(Exception exception) =>
      DataResult<T>(null, false, exception: exception);

  factory DataResult.success(T data) =>
      DataResult<T>(data, true, exception: null);

  @override
  String toString() {
    return 'DataResult{data: $data, result: $result, exception: $exception}';
  }
}
