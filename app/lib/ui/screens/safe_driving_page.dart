import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:app/theme.dart';

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
    _controller = CameraController(
      fps: 30,
      widget.camera,
      ResolutionPreset.medium,
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

  void _startSending() {
    _timer = Timer.periodic(Duration(milliseconds: 1), (timer) async {
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

  //TODO 여기 내일 수정
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
      body: Column(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          text16w4(
              "please put your phone to spable place and make sure your face is on the camera screen.\n\nif all is ok,you can use your navigation app!\n\nWe’ll call you when you look sleepy.\n\nhave a good drive! ;)"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleSending,
        child: Icon(_isSending ? Icons.stop : Icons.videocam),
      ),
    );
  }
}