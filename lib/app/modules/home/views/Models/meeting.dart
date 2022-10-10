import 'dart:convert';

class HistoryMeeting {
  String meetingName;
  final datePublished;
  HistoryMeeting({required this.meetingName, required this.datePublished});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'meetingName': meetingName});
    result.addAll({'datePublished': datePublished});

    return result;
  }

  factory HistoryMeeting.fromMap(Map<String, dynamic> map) {
    return HistoryMeeting(
      meetingName: map['meetingName'] ?? '',
      datePublished: map['datePublished'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryMeeting.fromJson(String source) =>
      HistoryMeeting.fromMap(json.decode(source));
}
