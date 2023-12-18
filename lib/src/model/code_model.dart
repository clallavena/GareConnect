class Code {
  String type;
  String value;

  Code({
    required this.type,
    required this.value,
  });

  factory Code.fromJson(Map<String, dynamic> json) => Code(
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
  };
}