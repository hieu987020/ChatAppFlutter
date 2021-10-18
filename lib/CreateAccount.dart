import 'package:chat_app/Methods.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
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
                      "Create account to continue!",
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
                    child: field(size, "Name", Icons.account_box, _name),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "Email", Icons.lock, _email),
                    ),
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "Password", Icons.lock, _password),
                  ),
                  SizedBox(height: size.height / 50),
                  customeButton(size),
                  SizedBox(height: size.height / 50),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
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
        if (_name.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          createAccount(_name.text, _email.text, _password.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
            } else {}
          });
        } else {
          print("Please enter field");
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
          "Create Account",
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
