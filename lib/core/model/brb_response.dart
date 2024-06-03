enum StatusCode { success, fail, error }

class BRBResponse<T> {
  final StatusCode statusCode;
  final T? data;
  final String message;

  BRBResponse({required this.statusCode, this.data, this.message = 'Não informado...'});

  BRBResponse.success({this.data, this.message = 'Não informado...'}) : statusCode = StatusCode.success;
  BRBResponse.error({this.data, required this.message}) : statusCode = StatusCode.error;
  BRBResponse.fail({this.data, required this.message}) : statusCode = StatusCode.fail;

  bool get isSuccess => statusCode == StatusCode.success;

  bool get isError => statusCode == StatusCode.error;

  bool get isFail => statusCode == StatusCode.fail;
}
