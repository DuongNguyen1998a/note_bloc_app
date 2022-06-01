import 'package:flutter/material.dart';
import 'package:note_bloc_app/screen/base_screen.dart';

import '../utils/support_utils.dart';
import '../widgets/bottom_modal_setting.dart';
import '../widgets/customize_app_bar.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      isShowBottomNav: true,
      body: Column(
        children: [
          CustomizeAppBar(
            title: 'User information',
            child: IconButton(
              onPressed: () {
                SupportUtils.showModalBottomSheetDialog(
                    context, const BottomModalSetting());
              },
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
