import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_io_chat/models/message.dart';
import 'package:rxdart/rxdart.dart';

import 'file:///E:/projects/flutter/Flutter-Socket-IO-Chat-master/lib/socket_io_manager.dart';

import '../../base_bloc..dart';

class ChatBloc implements BaseBloc {
  final _messagesController = ReplaySubject<Message>();

  void addMessage(Message message) => _messagesController.add(message);

  Stream<Message> get $messages => _messagesController.stream;

  List<Message> get messages => _messagesController.values.reversed.toList();

  final _typingController = BehaviorSubject<bool>();

  void typingChanged(bool typing) => _typingController.add(typing);

  Stream<bool> get typing => _typingController.stream;

  ScrollController scrollController;
  String senderName = '';
  SocketIoManager _socketIoManager;

  bool isTyping = false;
  String userNameTyping;

  void onTyping() {
    _socketIoManager.sendMessage(
        'typing', json.encode({'senderName': senderName}));
  }

  void onStopTyping() {
    _socketIoManager.sendMessage(
        'stop_typing', json.encode({'senderName': senderName}));
  }

  void sendMessage(String messageContent) {
    _socketIoManager.sendMessage(
      'send_message',
      Message(
        senderName,
        messageContent,
        DateTime.now(),
      ).toJson(),
    );
    scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 200),
      curve: Curves.bounceInOut,
    );
    addMessage(Message(senderName, messageContent, DateTime.now()));
  }

  void setSenderName(String name) {
    senderName = name;
  }

  @override
  void dispose() async {
    await _messagesController?.drain();
    await _messagesController?.close();
    scrollController.dispose();
    _socketIoManager.disconnect();
  }

  ChatBloc() {
    scrollController = ScrollController();

    _socketIoManager =
        SocketIoManager(serverUrl: 'https://chat-app-abdo.herokuapp.com/')
          ..init()
          ..subscribe('receive_message', (Map<String, dynamic> data) {
            addMessage(Message.fromJson(data));

            scrollController.animateTo(
              0.0,
              duration: Duration(milliseconds: 200),
              curve: Curves.bounceInOut,
            );
          })
          ..subscribe('typing', (Map<String, dynamic> data) {
            userNameTyping = data['senderName'];
            typingChanged(true);
          })
          ..subscribe('stop_typing', (Map<String, dynamic> data) {
            typingChanged(false);
          })
          ..connect();
  }
}
