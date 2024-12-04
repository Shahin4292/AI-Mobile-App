import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/gemini_controller.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final controller = Get.put(GeminiController());

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
          child: Obx(
            () => Column(
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
                        itemCount: controller.prompt.length,
                        itemBuilder: (context, index) {
                          final chatMessage = controller.prompt[index];
                          return UserPrompt(
                              isLoading: chatMessage.isPrompt,
                              message: chatMessage.message,
                              date: DateFormat("hh: mm: a")
                                  .format(chatMessage.time));
                        })),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  // height: 120,
                  // color: Colors.blue,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.chatController,
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
                            controller.sentMessage();
                        },
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 24,
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
          )),
    );
  }

  Container UserPrompt(
      {required final bool isLoading,
      required String message,
      required String date}) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15)
          .copyWith(left: isLoading ? 80 : 15, right: isLoading ? 15 : 80),
      decoration: BoxDecoration(
          color: isLoading ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isLoading ? const Radius.circular(20) : Radius.zero,
            bottomRight: isLoading ? Radius.zero : const Radius.circular(20),
          )),
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
