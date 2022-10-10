import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zomm_clone/app/data/colors.dart';
import 'package:zomm_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:zomm_clone/app/modules/home/views/Widgets/meeting_option.dart';

import '../../controllers/jitsi_meeting_controller.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  bool isAudioMuted = true;
  bool isVideoMuted = true;
  JitsiMeetingController _jitsiMeetingController =
      Get.find<JitsiMeetingController>();
  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController(
        text: Get.find<AuthController>().getUser!.displayName);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.backgroundColor,
        title: Text(
          'Join a Meeting',
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: CustomColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 60.h,
            child: TextField(
                controller: meetingIdController,
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: CustomColors.secondaryBackgroundColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'Room ID',
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                )),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 60.h,
            child: TextField(
              controller: nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: CustomColors.secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Name',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          InkWell(
            onTap: _joinMeeting,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Join',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.sp),
          MeetingOption(
            text: 'Mute Audio',
            isMute: isAudioMuted,
            onChange: onAudioMuted,
          ),
          MeetingOption(
            text: 'Turn Off My Video',
            isMute: isVideoMuted,
            onChange: onVideoMuted,
          ),
        ],
      ),
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }

  void _joinMeeting() {
    _jitsiMeetingController.creatingMeeting(
        roomName: meetingIdController.text,
        isAudioMuted: true,
        isVideoMuted: true);
  }
}
