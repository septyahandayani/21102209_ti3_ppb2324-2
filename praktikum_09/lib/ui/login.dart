import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:praktikum_09/bloc/login/login_cubit.dart';
import 'package:praktikum_09/ui/home_screen.dart';
import 'package:praktikum_09/ui/phone_auth_screen.dart';

import '../utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailEdc = TextEditingController();
  final passEdc = TextEditingController();
  bool passInvisible = false;

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
        return userCredential;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ACCOUNT',
          message: 'Google account not selected',
        );
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      // Handle the error
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Failed to sign in with Google'),
            backgroundColor: Colors.red,
          ),
        );
      return Future.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('Loading..')));
          }
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.msg),
                  backgroundColor: Colors.red,
                ),
              );
          }
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.msg),
                  backgroundColor: Colors.green,
                ),
              );
            Navigator.pushNamedAndRemoveUntil(
              context,
              rHome,
              (route) => false,
            );
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
          child: ListView(
            children: [
              Text(
                "Login",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3D4DE0)),
              ),
              SizedBox(height: 15),
              Text(
                "Silahkan masukan e-mail dan password anda",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 25),
              Text(
                "e-mail",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(controller: emailEdc),
              SizedBox(height: 10),
              Text(
                "password",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: passEdc,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      passInvisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passInvisible = !passInvisible;
                      });
                    },
                  ),
                ),
                obscureText: !passInvisible,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().login(
                        email: emailEdc.text,
                        password: passEdc.text,
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff3D4DE0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                    },
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4cwiag4IElDtmOpvTtg-XuoxAOTgRIjHlVleCyDQwcw&s'),
                    ),
                  ),
                  SizedBox(width: 30.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhoneAuthScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjbDvA8jADXR_bqbVzmRaNiv6X-3z5D7V-BA&usqp=CAU'),
                    ),
                  )
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun ?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      "Daftar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff3D4DE0),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
