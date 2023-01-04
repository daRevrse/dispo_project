import 'dart:io';
import 'package:dispo/views/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  final File video = File('assets/logo.mp4');


  @override
  void initState() {
    super.initState();

      _controller = VideoPlayerController.asset('assets/logo.mp4')
        ..initialize().then((_) {
          setState((){});
        })
        ..setVolume(0.0);

      _playVideo();


  }

  void _playVideo() async {
    _controller.play();

    await Future.delayed(const Duration(seconds: 5));

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainPage()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _controller.value.isInitialized
          ? Container(
            child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(
              _controller,
            ),
        ),
          )
        : Container(),
      ),
    );
  }
}
