import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_bloc_app/widgets/bottom_modal_add_note.dart';

import '../blocs/bottom_nav/bottom_nav_bloc.dart';
import '../blocs/note/note_bloc.dart';
import '../utils/support_utils.dart';

class CustomizeBottomNavbar extends StatelessWidget {
  final int currentIndex;

  const CustomizeBottomNavbar({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _onTap(int val) async {
      context.read<BottomNavBloc>().add(BottomNavChanged(currentIndex: val));

      int previousIndex = currentIndex;

      if (val == 1) {
        SupportUtils.showModalBottomSheetDialog(
            context,
            const BottomModalAddNote(
              action: 'create',
            ));

        context
            .read<BottomNavBloc>()
            .add(BottomNavChanged(currentIndex: previousIndex));
      } else {
        if (val != currentIndex) {
          if (val == 0) {
            Navigator.pushNamed(context, '/note');
            context.read<NoteBloc>().add(const FetchNotes());
          } else if (val == 2) {
            Navigator.pushNamed(context, '/user');
          }
        }
      }
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(25),
      ),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: _onTap,
        items: List.generate(
          3,
          (index) => bottomNavItem(
            data: index == 0
                ? const Icon(
                    Icons.home,
                    size: 30,
                  )
                : index == 1
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 30,
                      ),
          ),
        ),
      ),
    );
  }
}

BottomNavigationBarItem bottomNavItem({required Widget data}) {
  return BottomNavigationBarItem(label: '', icon: data);
}
