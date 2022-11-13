import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:lottieanimationlogin/Widgets/my_text_field.dart';
import '../Models/bunny.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  late MyBunny myBunny;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    animationController.stop();
    myBunny = MyBunny(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = MediaQuery.of(context).size.width - 32;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: const Color(0xff7BCBEE),
        elevation: 0,
        title: const Text(
          'Lottie Animation',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.black45,
              shape: BoxShape.circle,
            ),
            child: Lottie.asset(
              'assets/lottie/bunny.json',
              controller: animationController,
              width: 270,
              height: 270,
              onLoaded: (_) {
                setState(() {
                  animationController.duration = _.duration;
                });
              },
            ),
          ),
          const SizedBox(height: 30),
          MyTextField(
            hintText: 'Email Address',
            keyboardType: TextInputType.emailAddress,
            onHasFocus: (_) {
              myBunny.setTrackingState();
            },
            onChanged: (_) {
              myBunny.setEyesPosition(_getTextSize(_) / textFieldWidth);
            },
          ),
          const SizedBox(height: 20),
          MyTextField(
            hintText: 'Password',
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            onHasFocus: (_) {
              if (_) {
                myBunny.setShyState();
              } else {
                myBunny.setPeekState();
              }
            },
            onObscureText: (_) {
              if (_) {
                myBunny.setShyState();
              } else {
                myBunny.setPeekState();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        child: ElevatedButton(
          onPressed: () {
            myBunny.setTrackingState();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(
                color: Colors.black45,
                width: 1.3,
              ),
            ),
            minimumSize: const Size(double.infinity, 45),
          ),
          child: const Text(
            'Login',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  double _getTextSize(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(fontSize: 16.0)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }
}
