import 'package:firebase/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  //create instance of Firebase messaging

  final firebaseMessaging = FirebaseMessaging.instance;
  //Function to initialize notification
  Future<void> initNotifications() async {
    //request permission from user
    NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true, //shoe on the device
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true, //first time off the noti,then we on in settings
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user granted provisional");
    } else {
      print('user denied');
    }
    //fetch the fcm token for this device
    //token- id for each device
    final fcmToken = await firebaseMessaging.getToken();
    //print the token
    print('Token:$fcmToken');
    initPushNotification();
  }

  // function to handle received Messages
  void handleMessage(RemoteMessage? message) {
    //if the message is null, do nothing
    if (message == null) return;

    //navigate to a specific page when user clicks the notification
    navigatorKey.currentState?.pushNamed('notification', arguments: message);
  }
  //function to initialize foreground and background settings

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions();
    //handle notification if the app was terminated and now open
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    //attatch event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
