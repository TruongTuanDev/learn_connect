enum CallStatus {
  receivedCall("Cuộc gọi đến", "received_call"),
  missedCall("Cuộc gọi nhỡ", "missed_call"),
  called("Đã gọi", "called");

  final String description;
  final String apiValue;

  const CallStatus(this.description, this.apiValue);

  // Chuyển từ chuỗi API sang enum
  static CallStatus fromString(String value) {
    return CallStatus.values.firstWhere(
          (e) => e.apiValue == value,
      orElse: () => throw ArgumentError("Invalid CallStats value: $value"),
    );
  }

  // Chuyển enum thành chuỗi JSON
  String toJson() => apiValue;
}
