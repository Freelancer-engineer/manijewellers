import 'package:flutter/material.dart';
import '../services/video_service.dart';

class VideoUploadScreen extends StatefulWidget {
  const VideoUploadScreen({super.key});

  @override
  State<VideoUploadScreen> createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  final TextEditingController _videoUrlController = TextEditingController();

  void _uploadVideo() async {
    final success = await VideoService.uploadVideo(_videoUrlController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? "Video Uploaded" : "Upload Failed")),
    );
    _videoUrlController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("Upload Video",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(controller: _videoUrlController, decoration: const InputDecoration(labelText: "Video URL")),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _uploadVideo, child: const Text("Upload"))
        ],
      ),
    );
  }
}

