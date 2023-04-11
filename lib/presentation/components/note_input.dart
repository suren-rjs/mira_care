// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({super.key});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _textEditingController = TextEditingController();
  final double _height = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.grey[200],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    maxLines: 3,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Type a message...',
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _textEditingController.text.trim().isEmpty
                      ? null
                      : () {
                          // Handle send message
                          _textEditingController.clear();
                          setState(() {});
                        },
                ),
              ],
            ),
          ),
          SizedBox(
            height: _height,
          ),
        ],
      ),
    );
  }
}
