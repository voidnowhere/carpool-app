import 'package:carpool/models/message.dart';
import 'package:carpool/services/message_service.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final int tripId;
  const MessageScreen({super.key, required this.tripId});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Message> _messages = [];
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getMessages();
  }

  void _getMessages() {
    MessageService.getAll(widget.tripId).then((value) {
      setState(() {
        _messages = value;
      });
    });
  }

  void _sendMessage() {
    final content = _messageController.text;
    if (content.isNotEmpty) {
      MessageService.store(widget.tripId, content).then((value) {
        setState(() {
          _messageController.clear();
        });
        _getMessages();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: Text(_messages[index].userName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_messages[index].content),
                      Text(_messages[index].dateTimeFormated),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
