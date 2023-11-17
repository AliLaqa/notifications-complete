import 'dart:convert';
import 'package:http/http.dart';


///TODO: Here we are making API to send to Firebase.
class SendNotificationApi {
  Future<void> sendMessage(String token, String bodey,String title, String type) async {
    print("Sending notification..............");

    final uri = Uri.parse('https://fcm.googleapis.com/fcm/send');

    ///TODO: we need to set Header as below and paste Authorization key from Firebase.
    ///Change to new key before applying to different FireBase
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAAmWSPeyc:APA91bGVVtv0jW67rWUl-UIRoaIPPQggwvDJBvNGzVVacooQrB3Q1APpGSlwNeTAS8Yux7IGFLjWePpmrJDRvWHWUP0u5xkeVlyMNW3rZWYp1DxwbtxL2c8xSaBHR7okbptKddR1rxmA',
    };

    ///TODO: This is the body data which will be converted to JSON and then stored in a variable and assigned to below response.

    Map<String, dynamic> body = {
      "to": token.toString(),
      "data": {
        "type": type,
        "message": "This is a test message in payload",
      },
      "notification": {
        "body": bodey.toString(),
        "title": title.toString(),
        "android_channel_id": "pushnotificationapp3",
        "sound": true,
        "content_available":true,
        "mutable_content":true,
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
      },
    };

    ///TODO: Printing all information which is in body.
    print("Printing all notification sending information which is in body => \n $body");

    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    ///Post API
    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      print("Notification sent successfully.----------------------------------->");
    } else {
      print("Failed to send notification. Status code: ${response.statusCode}");
    }
  }
}