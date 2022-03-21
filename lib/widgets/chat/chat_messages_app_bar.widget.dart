import 'package:fake_chat/theme/app.theme.dart';
import 'package:fake_chat/widgets/common/custom_avatar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const double SIZE = 130;

class ChatMessagesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;

  ChatMessagesAppBar({@required this.name});

  @override
  Size get preferredSize => const Size(double.infinity, SIZE);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          color: Theme.of(context).primaryColor,
          height: SIZE,
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/LeftArrow.png',
                      height: 15,
                    ),
                    onPressed: Get.back,
                  ),
                ),
                // CustomAvatar(
                //   image: image,
                // ),
                Container(
                  height: 45,
                  child: CustomAvatar(),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    name,
                    style: AppTheme.chatDetailsAppBarTitleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
