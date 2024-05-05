import 'package:cardnews/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin { // Change to TickerProviderStateMixin

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/Animation - 1714900960007.json',height: 300,width: 300,repeat: true,reverse: true ),
          const SizedBox(height: 30,),
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-0.2, 0.0), // Start from left
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOut,
                )),
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(_controller),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'News',
                        style: GoogleFonts.aladin(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'App',
                        style: GoogleFonts.aladin(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: AppColors.purple // Changed to Colors.purple
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

