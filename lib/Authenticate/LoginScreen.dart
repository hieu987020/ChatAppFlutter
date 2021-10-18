import 'package:chat_app/Authenticate/CreateAccount.dart';
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:chat_app/Methods.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height / 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width / 1.2,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
                  ),
                  SizedBox(height: size.height / 50),
                  Container(
                    width: size.width / 1.3,
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 1.3,
                    child: Text(
                      "Sign in to continue!",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 10),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "Email", Icons.account_box, _email),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "Password", Icons.lock, _password),
                    ),
                  ),
                  SizedBox(height: size.height / 10),
                  customeButton(size),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => CreateAccount())),
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget field(Size size, String hintText, IconData icon,
      TextEditingController _controller) {
    return Container(
      height: size.height / 15,
      width: size.width / 1.1,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintStyle: TextStyle(color: Colors.grey),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget customeButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          logIn(_email.text, _password.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreeen()));
            } else {
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please fill form correctly");
        }
      },
      child: Container(
        height: size.height / 14,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
