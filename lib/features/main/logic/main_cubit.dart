import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/main/logic/main_state.dart';
import 'package:pickit/core/helpers/notifications_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  UniqueKey indexedStackKey = UniqueKey();
  String? currentChatUserId;
  MainCubit() : super(MainState(selectedIndex: 1, category: "All"));

  void rebuildIndexedStack() {
    indexedStackKey = UniqueKey();
  }

  void moveToBrowse(String? category) {
    emit(MainState(selectedIndex: 1, category: category));
  }

  void addNotificationListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = message.notification?.android;
      if (notification != null &&
          android != null &&
          message.data["senderId"] != currentChatUserId) {
        NotificationsManager.flutterLocalNotificationsPlugin.show(
           message.data["senderId"].hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              NotificationsManager.channel.id,
              NotificationsManager.channel.name,
              channelDescription: NotificationsManager.channel.description,
              icon: '@drawable/notify_icon',
            ),
          ),
        );
      }
    });
  }
}
