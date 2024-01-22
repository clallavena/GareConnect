import 'enum_values.dart';

class Code {
  CodeType type;
  String value;

  Code({
    required this.type,
    required this.value,
  });

  factory Code.fromJson(Map<String, dynamic> json) => Code(
    type: codeTypeValues.map[json["type"]]!,
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": codeTypeValues.reverse[type],
    "value": value,
  };
}

enum CodeType {
  SECONDARY_ID,
  SOURCE,
  UIC
}

final codeTypeValues = EnumValues({
  "secondary_id": CodeType.SECONDARY_ID,
  "source": CodeType.SOURCE,
  "uic": CodeType.UIC
});
