import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../Repo/user_services.dart';
import '../../../../common/text_fields.dart';
import '../../IntiatorScreen/intiator_screen.dart';
import '../SignUpScreen/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool showPass = true;
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading =false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 120,
                ),
                // CircleAvatar(
                //   radius: 50,
                //   backgroundColor: Colors.cyanAccent,
                // ),
                CommonTextFieldWithTitle(
                    'User Name', 'Enter User Name',   _emailController, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                  return null;
                }),

                // CustomTextField(
                //   prefixIcon: Icon(Icons.email),
                //   controller: _emailController,
                //   labelText: 'Email',
                // ),

                const SizedBox(height: 16.0),
                CommonTextFieldWithTitle('Password', 'Enter Password', _passwordController,
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        child: const Icon(Icons.remove_red_eye)),
                    obscure: showPass,
                        (val) {
                      if (val!.isEmpty) {
                        return 'This is required field';
                      }
                      return null;
                    }),
                // CustomTextField(
                //   controller: _passwordController,
                //   prefixIcon: Icon(Icons.lock),
                //   labelText: 'Password',
                //   obscureText: true,
                // ),
                const SizedBox(height: 20.0),
                isLoading?const Center(child: CircularProgressIndicator()):
                SizedBox(
                  height: 45,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue),
                    onPressed: () async{
                      // Perform sign-up logic here
                      if (_formkey.currentState!.validate()) {
                        bool loggedIn=await UserServices().userLogin(_emailController.text,_passwordController.text);
                        if(loggedIn==true){
                          Fluttertoast.showToast(msg: 'Successfully logged in');
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context)=>
                                  const IntiatorScreen()), (route) => false);
                        }else{
                          Fluttertoast.showToast(msg: 'Incorrect email or password');
                        }
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 1.0),
                    TextButton(
                      onPressed: () {
                        // Perform login navigation here
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return SignUpScreen();
                        }));
                      },
                      child: const Text(
                        'Sign up here',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
