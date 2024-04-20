// import 'package:dio/dio.dart';
//
// import 'failure.dart';
//
// class HttpErrorUtil {
//   // general methods:-----------------------------------------------------------
//   static String handleError(dynamic error) {
//     String errorDescription = "";
//     if (error is DioException) {
//       if (error.response != null && error.response?.data != null) {
//         try {
//           // var errorRs = ErrorGeneral.fromJson(error.response?.data as Map) ;
//           var errorRs = error.response?.data['message'];
//
//           if (error.response?.statusCode != null) {
//             var apiErrors = error.response?.data['errors'];
//             if (apiErrors != null) {
//               apiErrors.forEach((key, value) {
//                 errorDescription += '$key: $value\n';
//               });
//             }
//           }
//
//           return errorDescription.isNotEmpty ? errorDescription : errorRs ?? '';
//         } catch (e) {}
//       }
//       switch (error.type) {
//         case DioExceptionType.cancel:
//           errorDescription = 'Kết nối bị huỷ';
//           break;
//         case DioExceptionType.connectionTimeout:
//           errorDescription = 'Thời gian kết nối hết hạn';
//           break;
//         case DioExceptionType.unknown:
//           errorDescription = 'Lỗi không xác định';
//           break;
//         case DioExceptionType.receiveTimeout:
//           errorDescription = 'Thời gian nhận hết hạn';
//           break;
//         case DioExceptionType.badResponse:
//           errorDescription = 'Lỗi kết quả trả về';
//           break;
//         case DioExceptionType.sendTimeout:
//           errorDescription = 'Thời gian yêu cầu hết hạn';
//           break;
//         case DioExceptionType.badCertificate:
//           errorDescription = 'Lỗi kết quả trả về';
//           break;
//         case DioExceptionType.connectionError:
//           errorDescription = 'Lỗi kết quả trả về';
//           break;
//       }
//     } else if (error is NetworkException) {
//       errorDescription = 'Lỗi kết nối';
//     } else {
//       errorDescription = 'Lỗi không xác định';
//     }
//     return errorDescription;
//   }
// }
