import 'package:flutter/material.dart';
import 'package:flutter_sign_in_async_feature/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String message = '';
  bool isError = false;

  Future<void> handleSignIn() async{
    setState(() {
      isLoading = true;
      message = '';
      isError = false;
    });
    try{
      await AuthService().signIn(passwordController.text);
      setState(() {
        message = 'Sign in successful';
        isError = false;
      });
    } catch(error){
      setState(() {
        message = 'Error: $error';
        isError = true;
      });
    } finally{
      setState(() {
        isLoading = false;
        passwordController.clear();
      });
    }
  }

  @override void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Sign In', style: TextStyle(color: Colors.white,
            fontSize: 25, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            isLoading? CircularProgressIndicator()
                : ElevatedButton(
                onPressed: handleSignIn,
                child: Text('Sign In', style: TextStyle(fontSize: 20),)
            ),
          SizedBox(height: 20),
          Text(
            message, style: TextStyle(fontSize: 20,
            color: isError ? Colors.red : Colors.green,),
          )
          ],
        ),
      ),
    );
  }
}
