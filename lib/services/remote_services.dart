//class to fetch data from the internet

import 'package:httptut/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Welcome>?> getPost() async {
    var client = http.Client();
    var uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      // return Welcome.fromJson(json);
      return welcomeFromJson(json);
    } else {}
    return null;
  }
}
