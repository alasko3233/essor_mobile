import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

final dio = Dio();
void confdio() {
  // Set default configs
  dio.options.baseUrl = 'https://lessor.ml/api';

  // Or create `Dio` with a `BaseOptions` instance.
}
