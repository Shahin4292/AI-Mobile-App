import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

import '../models/chat_message_model.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  TextEditingController chatController = TextEditingController();
  static const apiKey = "AIzaSyD8vdVrEF0XOysW6SNaq1LdnQuypkJPfHY";
  final model = GenerativeModel(model: "Gemini", apiKey: apiKey);
  final List<ModelMessage> prompt = [];

  Future<void> sentMessage() async {
    final message = chatController.text;
    setState(() {
      prompt.add(
        ModelMessage(
          isPrompt: true,
          message: message,
          time: DateTime.now(),
        ),
      );
    });
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      prompt.add(
        ModelMessage(
          isPrompt: false,
          message: response.text ?? "",
          time: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/space_bg.jpg",
                ),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gemini",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.image_search,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: prompt.length,
                    itemBuilder: (context, index) {
                      final chatMessage = prompt[index];
                      return UserPrompt(
                          isLoading: chatMessage.isPrompt,
                          message: chatMessage.message,
                          date:
                              DateFormat("hh: mm: a").format(chatMessage.time));
                    })),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              // height: 120,
              // color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatController,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      sentMessage();
                    },
                    child: CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[900],
                        child: const Center(
                            child: Image(
                          image: AssetImage("assets/icon.png"),
                          height: 35,
                          width: 35,
                          // color: Colors.white,
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container UserPrompt(
      {required final bool isLoading,
      required String message,
      required String date}) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: isLoading ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.circular(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
                fontWeight: isLoading ? FontWeight.bold : FontWeight.normal,
                fontSize: 18,
                color: isLoading ? Colors.white : Colors.black),
          ),
          Text(
            date,
            style: TextStyle(
                // fontWeight: isLoading ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
                color: isLoading ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
