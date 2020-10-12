import 'package:flutter/material.dart';
import 'package:flutter_socket_io_chat/models/message.dart';
import 'package:flutter_socket_io_chat/ui/widgets/messages_form.dart';
import 'package:flutter_socket_io_chat/ui/widgets/messages_item.dart';

import '../../service_locator.dart';
import 'chat_bloc.dart';

class ChatScreen extends StatelessWidget {
  final String senderName;

  const ChatScreen(this.senderName);

  @override
  Widget build(BuildContext context) {
    sL<ChatBloc>().setSenderName(senderName);
    return Scaffold(
      appBar: AppBar(
        title: Text(senderName),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: StreamBuilder<Message>(
                stream: sL<ChatBloc>().$messages,
                builder: (context, snapshot) {
                  return ListView.builder(
                    reverse: true,
                    controller: sL<ChatBloc>().scrollController,
                    itemCount: sL<ChatBloc>().messages.length,
                    itemBuilder: (ctx, index) => MessagesItem(
                      sL<ChatBloc>().messages[index],
                      sL<ChatBloc>().messages[index].isUserMessage(senderName),
                    ),
                  );
                }),
          ),
          StreamBuilder<bool>(
              stream: sL<ChatBloc>().typing,
              initialData: false,
              builder: (context, snapshot) {
                bool _isTyping = false;
                if (snapshot.hasData && snapshot.data) {
                  _isTyping = true;
                }
                return Visibility(
                  visible: _isTyping,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${sL<ChatBloc>().userNameTyping} is typing',
                          style: Theme.of(context).textTheme.title.copyWith(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                        ),
                        Text('Typing...')
                      ],
                    ),
                  ),
                );
              }),
          MessageForm(
            onSendMessage: sL<ChatBloc>().sendMessage,
            onTyping: sL<ChatBloc>().onTyping,
            onStopTyping: sL<ChatBloc>().onStopTyping,
          ),
        ],
      ),
    );
  }
}
