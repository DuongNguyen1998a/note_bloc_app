import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bottom_nav/bottom_nav_bloc.dart';
import '../utils/support_utils.dart';
import '../widgets/customize_bottom_navbar.dart';

class BaseScreen extends StatelessWidget {
  final bool isShowBottomNav;
  final Widget body;

  const BaseScreen({
    Key? key,
    required this.body,
    required this.isShowBottomNav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: SupportUtils.backgroundColor(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: isShowBottomNav
            ? BlocBuilder<BottomNavBloc, BottomNavState>(
                builder: (context, state) {
                if (state is BottomNavInitial) {
                  return CustomizeBottomNavbar(
                    currentIndex: state.currentIndex,
                  );
                } else {
                  return const CustomizeBottomNavbar(
                    currentIndex: 0,
                  );
                }
              })
            : null,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: body,
          ),
        ),
      ),
    );
  }
}
