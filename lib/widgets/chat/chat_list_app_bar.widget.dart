import 'package:fake_chat/controllers/chat.controller.dart';
import 'package:fake_chat/widgets/common/app_bar_search.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const double SIZE = 130;

class ChatListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final controller = Get.put(ChatController());

  @override
  Size get preferredSize => const Size(double.infinity, SIZE);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: GestureDetector(
        child: Material(
          elevation: 2,
          child: Obx(
            () => AnnotatedRegion<SystemUiOverlayStyle>(
              value: controller.isSearching.value ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    height: SIZE - (controller.isSearching.value ? 30 : 0),
                    child: SafeArea(
                      bottom: false,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: controller.isSearching.value
                            ? AppBarSearchWidget(
                                controller: controller.searchFieldController,
                                search: controller.search,
                                clear: controller.clear,
                                onSearch: () {
                                  controller.isSearching.value = false;
                                  controller.clear();
                                },
                              )
                            : Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/images/Logo.png',
                                      height: 25,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.search_rounded,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        controller.isSearching.value = true;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    color: controller.isSearching.value ? Colors.white : Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
