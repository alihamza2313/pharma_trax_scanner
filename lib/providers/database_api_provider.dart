

import 'package:flutter/foundation.dart';

class DatabaseApi {
  double version;

  DatabaseApi({
    required this.version,
  });
}

class DatabaseApiProvider with ChangeNotifier {
  final DatabaseApi _databaseApi = 'null' as DatabaseApi;

  DatabaseApi get databaseApi {
    return _databaseApi;
  }

  void setVersion(double value) {
    _databaseApi.version = value;
  }
}
