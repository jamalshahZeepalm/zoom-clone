import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zomm_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:zomm_clone/app/modules/home/views/Models/meeting.dart';

class JitsiMeetingController extends GetxController {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  final Rx<List<HistoryMeeting>?> _historyMeeting =
      Rx<List<HistoryMeeting>?>(null);
  List<HistoryMeeting>? get getHistoryMeeting => _historyMeeting.value;

  Stream<List<HistoryMeeting>?> userHistoryMeeting() {
    return _firebaseFirestore
        .collection('Users')
        .doc(Get.find<AuthController>().getUser!.uid)
        .collection('Meeting')
        .snapshots()
        .map((event) {
      List<HistoryMeeting> allHistoryMeeting = [];
      for (var e in event.docs) {
        allHistoryMeeting.add(HistoryMeeting.fromMap(e.data()));
      }
      return allHistoryMeeting;
    });
  }

  @override
  void onInit() {
    _historyMeeting.bindStream(userHistoryMeeting());
    super.onInit();
  }

  creatingMeeting(
      {required String roomName,
      required bool isAudioMuted,
      required bool isVideoMuted,
      String userName = ''}) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;
      String? name;
      if (userName.isEmpty) {
        name = Get.find<AuthController>().getUser!.displayName;
      } else {
        name = userName;
      }
      var options = JitsiMeetingOptions(
        room: roomName,
      )
        ..userDisplayName = name
        ..userEmail = Get.find<AuthController>().getUser!.email
        ..userAvatarURL =
            Get.find<AuthController>().getUser!.photoURL // or .png
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;
      await AddHistoryOfMeeting(meetingName: roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  AddHistoryOfMeeting({required String meetingName}) async {
    try {
      await _firebaseFirestore
          .collection('Users')
          .doc(Get.find<AuthController>().getUser!.uid)
          .collection('Meeting')
          .add({
        'meetingName': meetingName,
        'datePublished': DateTime.now(),
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
