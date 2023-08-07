import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();
  final ScrollController chatScrollController = ScrollController();
  final List<Message> messages = [
    Message(text: 'Hello, Bill!', fromWho: FromWho.me),
    Message(text: 'Cae el sábado a mi casa?', fromWho: FromWho.me),
    Message(text: 'Sorry, but I have to go to England that day.', fromWho: FromWho.his, imageUrl: 'https://media.giphy.com/media/CHSHxWaOEmlFwEVRmk/giphy.gif')
  ];

  Future<void> sendMessage(String message) async {
    if(message.isEmpty) return;

    Message newMessage = Message(text: message, fromWho: FromWho.me);
    messages.add(newMessage);

    if(message.endsWith('?')) herReply();
    /// parecido a SetState, se necesita para actualizar el estado
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> herReply() async{
    final herMessage = await getYesNoAnswer.getAnswer();
    messages.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() async{
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent, 
      duration: const Duration(milliseconds: 300), 
      curve: Curves.easeInExpo);
  }
}