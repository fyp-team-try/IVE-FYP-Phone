class ApiResponse<T> {
  bool success;
  String? errorMessage;
  T? data;
  int statusCode;
  ApiResponse({
    required this.success,
    this.errorMessage,
    this.data,
    required this.statusCode,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return ApiResponse(
      success: json['success'],
      errorMessage: json['errorMessage'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      statusCode: json['statusCode'],
    );
  }
}
