import 'package:flutter_socket_io_chat/ui/chat/chat_bloc.dart';
import 'package:get_it/get_it.dart';

import 'base_bloc..dart';

final GetIt sL = GetIt.I;
final Set<BaseBloc> usedBlocs = {};

Future<void> setupLocators() async {
  final chatBloc = ChatBloc();
  usedBlocs.add(chatBloc);
  sL.registerSingleton<ChatBloc>(chatBloc);
}

void disposeBlocs() {
  for (var bloc in usedBlocs) bloc.dispose();
}
