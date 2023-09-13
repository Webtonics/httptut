import 'package:flutter/material.dart';
import 'package:httptut/models/post.dart';
import 'package:httptut/services/remote_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Welcome>? welcome;

  //check if loading
  var isLoading = false;
  var onBigScreen = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    welcome = await RemoteService().getPost();
    if (welcome != null) {
      setState(() {
        isLoading = true;
      });
    }
  }

  checkScreenSize() {
    if (MediaQuery.of(context).size.width >= 400) {
      return 5;
    } else {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Home",
        ),
      ),
      body: Center(
        child: Visibility(
          visible: isLoading,
          replacement: const CircularProgressIndicator(
            color: Colors.red,
          ),
          child: ListView.builder(
            itemCount: welcome?.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(24)),
                  child: ListTile(
                    leading: Chip(label: Text("${welcome![index].userId}")),
                    title: Text(
                      welcome![index].title,
                      maxLines: checkScreenSize(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      welcome![index].body,
                      maxLines: checkScreenSize(),
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
