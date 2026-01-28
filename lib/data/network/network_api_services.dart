import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:getx_mvvm/data/app_exceptions.dart';
import 'package:getx_mvvm/data/network/base_api_services.dart';
import 'package:getx_mvvm/res/services/logger_services.dart';
import 'package:http/http.dart' as http;

/// Implementation of BaseApiServices using HTTP package
///
/// Handles all HTTP requests with proper error handling,
/// timeout management, and response parsing.
class NetworkApiServices extends BaseApiServices {
  /// Default timeout duration for requests
  static const Duration _defaultTimeout = Duration(seconds: 30);

  /// Default headers to include in requests
  static const Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<dynamic> getGetApiResponse(String url) async {
    if (kDebugMode) {
      LoggerService.debug('GET Request: $url');
    }

    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: _defaultHeaders)
          .timeout(_defaultTimeout);

      responseJson = _returnResponse(response);
    } on SocketException {
      LoggerService.error('No internet connection');
      throw InternetException('No internet connection');
    } on FormatException {
      LoggerService.error('Invalid response format');
      throw InvalidUrlException('Invalid response format');
    } catch (e) {
      LoggerService.error('Unknown error occurred', e);
      throw FetchDataException('An error occurred: ${e.toString()}');
    }

    if (kDebugMode) {
      LoggerService.debug('GET Response: $responseJson');
    }

    return responseJson;
  }

  @override
  Future<dynamic> getPostApiResponse(dynamic data, String url) async {
    if (kDebugMode) {
      LoggerService.debug('POST Request: $url');
      LoggerService.debug('POST Data: $data');
    }

    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: _defaultHeaders)
          .timeout(_defaultTimeout);

      responseJson = _returnResponse(response);
    } on SocketException {
      LoggerService.error('No internet connection');
      throw InternetException('No internet connection');
    } on FormatException {
      LoggerService.error('Invalid data format');
      throw InvalidUrlException('Invalid data format');
    } catch (e) {
      LoggerService.error('Unknown error occurred', e);
      throw FetchDataException('An error occurred: ${e.toString()}');
    }

    if (kDebugMode) {
      LoggerService.debug('POST Response: $responseJson');
    }

    return responseJson;
  }

  @override
  Future<dynamic> getPutApiResponse(dynamic data, String url) async {
    if (kDebugMode) {
      LoggerService.debug('PUT Request: $url');
      LoggerService.debug('PUT Data: $data');
    }

    dynamic responseJson;
    try {
      final response = await http
          .put(Uri.parse(url), body: jsonEncode(data), headers: _defaultHeaders)
          .timeout(_defaultTimeout);

      responseJson = _returnResponse(response);
    } on SocketException {
      LoggerService.error('No internet connection');
      throw InternetException('No internet connection');
    } on FormatException {
      LoggerService.error('Invalid data format');
      throw InvalidUrlException('Invalid data format');
    } catch (e) {
      LoggerService.error('Unknown error occurred', e);
      throw FetchDataException('An error occurred: ${e.toString()}');
    }

    if (kDebugMode) {
      LoggerService.debug('PUT Response: $responseJson');
    }

    return responseJson;
  }

  @override
  Future<dynamic> getDeleteApiResponse(String url) async {
    if (kDebugMode) {
      LoggerService.debug('DELETE Request: $url');
    }

    dynamic responseJson;
    try {
      final response = await http
          .delete(Uri.parse(url), headers: _defaultHeaders)
          .timeout(_defaultTimeout);

      responseJson = _returnResponse(response);
    } on SocketException {
      LoggerService.error('No internet connection');
      throw InternetException('No internet connection');
    } on FormatException {
      LoggerService.error('Invalid URL format');
      throw InvalidUrlException('Invalid URL format');
    } catch (e) {
      LoggerService.error('Unknown error occurred', e);
      throw FetchDataException('An error occurred: ${e.toString()}');
    }

    if (kDebugMode) {
      LoggerService.debug('DELETE Response: $responseJson');
    }

    return responseJson;
  }

  /// Parses HTTP response and returns appropriate data
  ///
  /// Handles different status codes and throws appropriate exceptions
  /// [response] The HTTP response to parse
  /// Returns parsed response data
  /// Throws [AppException] based on status code
  dynamic _returnResponse(http.Response response) {
    LoggerService.info('Status Code: ${response.statusCode}');

    switch (response.statusCode) {
      case 200:
      case 201:
        try {
          dynamic responseJson = jsonDecode(response.body.toString());
          return responseJson;
        } on FormatException {
          return response.body.toString();
        }
      case 400:
        dynamic responseJson = jsonDecode(response.body.toString());
        throw BadRequestException(responseJson['message'] ?? 'Bad request');
      case 401:
        throw UnauthorizedException('Unauthorized access');
      case 403:
        throw UnauthorizedException('Access forbidden');
      case 404:
        throw NotFoundException('Resource not found');
      case 500:
      case 502:
      case 503:
        throw ServerException('Internal server error');
      default:
        throw FetchDataException(
          'Error occurred while communicating with server: ${response.statusCode}',
        );
    }
  }
}
