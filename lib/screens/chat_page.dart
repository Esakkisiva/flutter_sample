import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _currentChatIndex = 0;
  bool _showStickers = false;
  bool _isRecording = false;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<String> stickers = ['😀', '😂', '😍', '🥰', '😊', '😎', '🤔', '😴', '🎉', '❤️'];

  final List<ChatModel> chats = [
    ChatModel(
      name: 'world ',
      lastMessage: 'Hey! How are you doing?',
      time: '2:30 PM',
      avatar: '🌎',
      isOnline: true,
      unreadCount: 3,
      connectionPercentage: 85,
      messages: [
        MessageModel(text: 'Hey! How are you doing?', isMe: false, time: '2:30 PM'),
        MessageModel(text: "I'm good! Thanks for asking", isMe: true, time: '2:32 PM'),
      ],
    ),
    ChatModel(
      name: 'Bob Smith',
      lastMessage: 'See you tomorrow!',
      time: '1:15 PM',
      avatar: '👨‍💼',
      isOnline: false,
      unreadCount: 0,
      connectionPercentage: 92,
      messages: [
        MessageModel(text: 'Meeting at 10 AM?', isMe: true, time: '1:10 PM'),
        MessageModel(text: 'See you tomorrow!', isMe: false, time: '1:15 PM'),
      ],
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage({String? text, String? sticker}) {
    if ((text == null || text.isEmpty) && sticker == null) return;

    setState(() {
      chats[_currentChatIndex].messages.add(MessageModel(
        text: sticker ?? text!,
        isMe: true,
        time: _getCurrentTime(),
        type: sticker != null ? MessageType.sticker : MessageType.text,
        stickerEmoji: sticker,
      ));
      _showStickers = false;
    });
    _messageController.clear();
    _scrollToBottom();
  }

  void _startVoiceRecording() {
    setState(() => _isRecording = true);
    HapticFeedback.mediumImpact();
    Future.delayed(const Duration(seconds: 2), _stopVoiceRecording);
  }

  void _stopVoiceRecording() {
    if (!_isRecording) return;
    setState(() => _isRecording = false);
    _sendMessage(text: 'Voice message');
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Chats', style: TextStyle(color: Colors.purpleAccent)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.purpleAccent),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) => _buildChatTile(chats[index], index),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: _startNewChat,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  Widget _buildChatTile(ChatModel chat, int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getAvatarColor(chat.name),
        child: Text(chat.avatar, style: const TextStyle(fontSize: 24)),
      ),
      title: Text(chat.name, style: const TextStyle(color: Colors.white)),
      subtitle: Text(chat.lastMessage, style: const TextStyle(color: Colors.grey)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(chat.time, style: const TextStyle(color: Colors.purpleAccent)),
          if (chat.unreadCount > 0)
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.purpleAccent,
              child: Text(
                chat.unreadCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
      onTap: () => _openChat(chat, index),
    );
  }

  void _openChat(ChatModel chat, int index) {
    setState(() => _currentChatIndex = index);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.purpleAccent),
              onPressed: () => Navigator.pop(context),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getAvatarColor(chat.name),
                  child: Text(chat.avatar),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chat.name, style: const TextStyle(color: Colors.white)),
                    Text(
                      chat.isOnline ? 'Online' : 'Offline',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.videocam, color: Colors.purpleAccent),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.call, color: Colors.purpleAccent),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: chat.messages.length,
                  itemBuilder: (context, index) => _buildMessageBubble(chat.messages[index]),
                ),
              ),
              if (_showStickers) _buildStickerPanel(),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isMe ? Colors.purpleAccent : Colors.grey[800],
          borderRadius: BorderRadius.circular(16),
        ),
        child: message.type == MessageType.sticker
            ? Text(message.stickerEmoji!, style: const TextStyle(fontSize: 32))
            : Text(message.text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildStickerPanel() {
    return Container(
      height: 200,
      color: Colors.grey[900],
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 1,
        ),
        itemCount: stickers.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => _sendMessage(sticker: stickers[index]),
          child: Container(
            margin: const EdgeInsets.all(4),
            child: Center(
              child: Text(stickers[index], style: const TextStyle(fontSize: 32)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[900],
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _showStickers ? Icons.keyboard : Icons.emoji_emotions,
              color: Colors.purpleAccent,
            ),
            onPressed: () => setState(() => _showStickers = !_showStickers),
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[800],
              ),
              onSubmitted: (text) => _sendMessage(text: text),
            ),
          ),
          GestureDetector(
            onLongPressStart: (_) => _startVoiceRecording(),
            onLongPressEnd: (_) => _stopVoiceRecording(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isRecording ? Colors.red : Colors.purpleAccent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isRecording ? Icons.stop : Icons.mic,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startNewChat() {
    // Implement your new chat creation logic
  }

  Color _getAvatarColor(String name) {
    final colors = [
      Colors.red[400]!,
      Colors.blue[400]!,
      Colors.green[400]!,
      Colors.orange[400]!,
      Colors.purple[400]!,
    ];
    return colors[name.hashCode % colors.length];
  }
}

class ChatModel {
  final String name;
  final String lastMessage;
  final String time;
  final String avatar;
  final bool isOnline;
  final int unreadCount;
  final int connectionPercentage;
  final List<MessageModel> messages;

  ChatModel({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatar,
    required this.isOnline,
    required this.unreadCount,
    required this.connectionPercentage,
    required this.messages,
  });
}

class MessageModel {
  final String text;
  final bool isMe;
  final String time;
  final MessageType type;
  final String? stickerEmoji;

  MessageModel({
    required this.text,
    required this.isMe,
    required this.time,
    this.type = MessageType.text,
    this.stickerEmoji,
  });
}

enum MessageType { text, voice, sticker, image }