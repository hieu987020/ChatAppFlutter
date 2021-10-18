import 'package:chat_app/Methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreeen extends StatefulWidget {
  @override
  _HomeScreeenState createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();

  void onSearch() async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });

    await _fireStore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout), onPressed: () => logOut(context)),
        ],
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(height: size.height / 20),
                Container(
                  height: size.height / 14,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height / 14,
                    width: size.width / 1.2,
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: size.height / 20),
                ElevatedButton(
                  onPressed: onSearch,
                  child: Text("Search"),
                ),
                SizedBox(height: size.height / 30),
                userMap != null
                    ? ListTile(
                        onTap: () {},
                        leading: Icon(Icons.account_box, color: Colors.black),
                        title: Text(
                          userMap?['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(userMap?['email']),
                        trailing: Icon(Icons.chat, color: Colors.black),
                      )
                    : Container(),
              ],
            ),
    );
  }
}
