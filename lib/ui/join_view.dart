import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat/chat.dart';

class JoinScreen extends StatelessWidget {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      "What's your nickname?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: _textEditingController,
                      decoration: InputDecoration(labelText: 'nickname'),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Container(
                      height: 45,
                      child: Material(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          highlightColor: null,
                          splashColor: null,
                          onTap: () {
                            if (_textEditingController.text.isEmpty) return;

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) =>
                                    ChatScreen(_textEditingController.text),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'JOIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
