import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../register/register_bloc.dart';
import '../register/register_screen.dart';
import '../../../data/repository/repository.dart';
import '../main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppRepository _repository = AppRepository();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      if (_repository.currentUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BlocProvider<RegisterBloc>(
              create: (context) => RegisterBloc(_repository),
              child: const RegisterScreen(),
            ),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe9e9e9),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Stack(
              children: [
                Image.asset('assets/images/img_splash1.png'),
                Padding(
                  padding: const EdgeInsets.only(top: 100, left: 50, right: 50),
                  child: Image.asset('assets/images/img_splash.png'),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 375,
            width: double.infinity,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/img_sp.jpg',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  bottom: 30,
                  left: 150,
                  right: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider<RegisterBloc>(
                            create: (context) => RegisterBloc(_repository),
                            child: const RegisterScreen(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF26B6C),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Get Started ',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
