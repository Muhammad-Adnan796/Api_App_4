import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiDataCalling extends StatefulWidget {
  const ApiDataCalling({Key? key}) : super(key: key);

  @override
  State<ApiDataCalling> createState() => _ApiDataCallingState();
}

class _ApiDataCallingState extends State<ApiDataCalling> {
  var data;

  Future<void> getData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 30,
        shadowColor: Colors.purple,
        centerTitle: true,
        title: Text(
          "Api App 4",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
             ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading"));
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            ReUsableData(
                              title: "Name",
                              value: data[index]["name"].toString(),
                            ),
                            ReUsableData(
                              title: "User name",
                              value: data[index]["username"].toString(),
                            ),
                            ReUsableData(
                              title: "Email",
                              value: data[index]["email"].toString(),
                            ),
                            ReUsableData(
                              title: "Address",
                              value:
                                  "${data[index]["address"]["street"].toString()}",
                            ),
                            ReUsableData(
                              title: "Geo",
                              value:
                              data[index]["address"]["geo"]["lat"].toString(),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReUsableData extends StatelessWidget {
  ReUsableData({required this.title, required this.value});

  String title;
  String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              Text(
                value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              )
            ],
          ),
        )
      ],
    );
  }
}
