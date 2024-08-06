import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'self_check_page.dart';
import 'package:ice_d/theme.dart';

class SafeDrivingPage extends StatefulWidget {
  final CameraDescription camera;

  const SafeDrivingPage({super.key, required this.camera});

  @override
  _SafeDrivingPageState createState() => _SafeDrivingPageState();
}

class _SafeDrivingPageState extends State<SafeDrivingPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isSending = false;
  Timer? _timer;
  late WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();
    _showSelfCheckDialog();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
    _channel = IOWebSocketChannel.connect('ws://3fb9-203-246-85-181.ngrok-free.app/video_feed');
    _controller.setFlashMode(FlashMode.off);
    _channel.stream.listen((message) {
      _handleMessage(message);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _channel.sink.close();
    super.dispose();
  }

  void _showSelfCheckDialog() {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('운전 전 자가진단을 하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SelfCheckPage()),
                  );
                },
                child: Text('예'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('아니요'),
              ),
            ],
          );
        },
      );
    });
  }

  void _startSending() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) async {
      if (_isSending) {
        try {
          final image = await _controller.takePicture();
          await _sendImageToServer(image);
          print('Image captured: ${image.path}');
        } catch (e) {
          print(e);
        }
      }
    });
  }

  Future<void> _sendImageToServer(XFile image) async {
    try {
      final bytes = await File(image.path).readAsBytes();
      _channel.sink.add(bytes);
      print('Image sent to server');
    } catch (e) {
      print('Failed to send image to server: $e');
    }
  }

  void _stopSending() {
    _timer?.cancel();
  }

  void _toggleSending() {
    setState(() {
      _isSending = !_isSending;
      if (_isSending) {
        _startSending();
      } else {
        _stopSending();
      }
    });
  }

  void _handleMessage(message) {
    try {
      final data = jsonDecode(message);
      if (data['drowsiness_detected'] == true) {
        _showDrowsinessAlert();
      }
    } catch (e) {
      print('Failed to parse message: $e');
    }
  }

  void _showDrowsinessAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("졸음 감지"),
          content: Text("잠시 휴식을 취하세요!"),
          actions: [
            TextButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      CameraPreview(_controller),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        width: 150,
                        height: 200,
                        child: Container(
                          color: Colors.black54,
                          child: CameraPreview(_controller),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            TextMedium(size: 16,
                string: "please put your phone to a stable place and make sure your face is on the camera screen.\n\nIf all is okay, you can use your navigation app!\n\nWe’ll call you when you look sleepy.\n\nHave a good drive! ;)"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleSending,
        child: Icon(_isSending ? Icons.stop : Icons.videocam),
      ),
    );
  }
}