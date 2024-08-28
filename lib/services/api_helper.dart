// part of 'services.dart';

// class ApiHelper {
//   ApiHelper();

//   factory ApiHelper.instance() => _instance ??= ApiHelper();

//   static ApiHelper? _instance;

//   String get url => 'http://127.0.0.1';

//   String get endpointLoggedIn => 'api/v1/auth/user';

//   bool get development => kDebugMode;

//   bool get isOffline => false;

//   bool get requestLogging => true;

//   @protected
//   Future<Map<String, String>> getHeaders({bool ignoreAuthorization = false, bool isMultipartFormData = false}) async => {
//         if (!ignoreAuthorization) 'Authorization': 'Bearer ${await getToken()}',
//         'Content-Type': isMultipartFormData ? 'multipart/form-data' : 'application/json',
//         'Accept': 'application/json',
//       };

//   @protected
//   Future<String?> getToken({bool refreshCurrentUser = false}) async => null;

//   @protected
//   http.StreamedResponse onRequestTimeout() => http.StreamedResponse(
//         Stream.fromIterable(
//           [
//             json.encode({'message': 'Request Timeout'}).codeUnits
//           ],
//         ),
//         408,
//       );

//   Future<dynamic> _request({
//     required String method,
//     required Uri uri,
//     Map<String, dynamic>? body,
//     bool ignoreAuthorization = false,
//     bool decode = true,
//     bool throwNonOkResponseCode = true,
//     Duration? timeout = const Duration(seconds: 30),
//   }) async {
//     if (isOffline) {
//       throw {
//         'data': {'message': 'You are offline',},
//         'status_code': 400,
//       };
//     }

//     http.Request request = http.Request(method, uri);
//     request.headers.addAll(await getHeaders(ignoreAuthorization: ignoreAuthorization));
//     if (requestLogging) debugPrint('(http request) : $method ${request.url} ${request.headers} $body');
//     if (body != null) request.body = json.encode(body);

//     http.StreamedResponse response;
//     if (timeout == null) {
//       response = await request.send();
//     } else {
//       response = await request.send().timeout(timeout, onTimeout: onRequestTimeout);
//     }

//     dynamic responseString = !decode ? await response.stream.toBytes() : await response.stream.bytesToString();
//     if (!(response.statusCode > 199 && response.statusCode < 300) && throwNonOkResponseCode) {
//       if (requestLogging) debugPrint('(http response) : $method ${request.url} ${request.headers} => $responseString');
//       throw {
//         'data': json.decode(responseString),
//         'status_code': response.statusCode,
//       };
//     }

//     if (!decode) {
//       if (requestLogging) debugPrint('(http response) : $method ${request.url} ${request.headers} => $responseString');
//       return responseString;
//     }

//     if (requestLogging) debugPrint('(http response) : $method ${request.url} ${request.headers} => $responseString');
//     return json.decode(responseString);
//   }

//   Future<dynamic> _requestMultipart({
//     required String method,
//     required Uri uri,
//     Map<String, String>? fields,
//     List<http.MultipartFile>? files,
//     Duration? timeout,
//   }) async {
//     var request = http.MultipartRequest(method, uri);
//     request.headers.addAll(await getHeaders(isMultipartFormData: true));
//     if (files != null) request.files.addAll(files);
//     if (fields != null) request.fields.addAll(fields);

//     if (requestLogging) debugPrint('(http request) : ${request.method} ${request.url} ${request.headers} ${request.fields}');

//     http.StreamedResponse response;
//     if (timeout == null) {
//       response = await request.send();
//     } else {
//       response = await request.send().timeout(timeout, onTimeout: onRequestTimeout);
//     }

//     if (!(response.statusCode > 199 && response.statusCode < 300)) {
//       String responseString = await response.stream.bytesToString();
//       if (requestLogging) debugPrint('(http response) : $method ${request.url} ${request.headers} => $responseString');
//       throw {
//         'data': json.decode(responseString),
//         'status_code': response.statusCode,
//       };
//     }

//     String responseString = await response.stream.bytesToString();
//     if (requestLogging) debugPrint('(http response) : $method ${request.url} ${request.headers} => $responseString');
//     return json.decode(responseString);
//   }

//   @protected
//   Future<void> refreshCurrentUser(dynamic response) async {}

//   Future<dynamic> get({required String endpoint, bool throwNonOkResponseCode = true}) => _request(method: 'GET', uri: Uri.parse('$url/$endpoint'), throwNonOkResponseCode: throwNonOkResponseCode);

//   Future<dynamic> post({required String endpoint, Map<String, dynamic>? body, bool ignoreAuthorization = false, bool throwNonOkResponseCode = true}) => _request(method: 'POST', uri: Uri.parse('$url/$endpoint'), body: body, ignoreAuthorization: ignoreAuthorization, throwNonOkResponseCode: throwNonOkResponseCode);

//   Future<dynamic> put({required String endpoint, Map<String, dynamic>? body, bool throwNonOkResponseCode = true}) => _request(method: 'PUT', uri: Uri.parse('$url/$endpoint'), body: body, throwNonOkResponseCode: throwNonOkResponseCode);

//   Future<dynamic> delete({required String endpoint, Map<String, dynamic>? body, bool throwNonOkResponseCode = true}) => _request(method: 'DELETE', uri: Uri.parse('$url/$endpoint'), body: body, throwNonOkResponseCode: throwNonOkResponseCode);

//   Future<dynamic> getFile({required Uri uri, Duration? timeout}) => _request(method: 'GET', uri: uri, decode: false, ignoreAuthorization: true, timeout: timeout);
// }

// mixin AuthSanctumMixin on ApiHelper {
//   final keyToken = 'token';

//   @override
//   Future<String?> _getToken({bool refreshCurrentUser = false}) async {
//     SharedPreferences sharedPref = await SharedPreferences.getInstance();
//     String? token = sharedPref.getString(keyToken);

//     if (refreshCurrentUser && isOffline) {
//       if (token != null) {
//         await this.refreshCurrentUser(null);
//       }
//       return null;
//     }

//     if (token == null) {
//       throw {
//         'data': {
//           'message': 'Unauthenticated.',
//         },
//         'status_code': 401,
//       };
//     }

//     if (refreshCurrentUser) {
//       dynamic resposne = await 
//     }
//   }
// }

// class ApiWidgetHelper extends ApiHelper with AuthSanctumMixin {}

// void mainTest() {}
