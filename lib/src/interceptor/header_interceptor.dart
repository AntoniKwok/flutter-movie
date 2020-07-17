import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter_app_intro/src/util/config.dart';

class HeaderInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    Request newRequest = request.copyWith(
        headers: {Config.AUTH_HEADER: Config.BEARER + Config.ACCESS_TOKEN});
    return newRequest;
  }
}
