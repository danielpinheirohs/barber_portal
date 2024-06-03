import 'package:logger/logger.dart';

class LoggerUtils {
  static internalError(dynamic e) {
    Logger().e('Houve um erro interno: $e');
  }
}
