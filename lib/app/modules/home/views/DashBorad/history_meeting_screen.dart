import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:zomm_clone/app/modules/home/controllers/jitsi_meeting_controller.dart';
import 'package:zomm_clone/app/modules/home/views/Models/meeting.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryMeetingScreen extends StatefulWidget {
  const HistoryMeetingScreen({super.key});

  @override
  State<HistoryMeetingScreen> createState() => _HistoryMeetingScreenState();
}

class _HistoryMeetingScreenState extends State<HistoryMeetingScreen> {
  final JitsiMeetingController _jitsiMeetingController =
      Get.find<JitsiMeetingController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return _jitsiMeetingController.getHistoryMeeting?.isEmpty == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _jitsiMeetingController.getHistoryMeeting!.length,
                itemBuilder: (context, index) {
                  HistoryMeeting historyMeeting =
                      _jitsiMeetingController.getHistoryMeeting![index];
                  return ListTile(
                    title: Text(
                      historyMeeting.meetingName,
                      style: TextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      timeago
                          .format(historyMeeting.datePublished.toDate())
                          .toString(),
                    ),
                  );
                },
              );
      },
    );
  }
}
