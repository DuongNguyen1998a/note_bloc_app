import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/note/note_bloc.dart';
import '../utils/support_utils.dart';

class BottomModalSetting extends StatelessWidget {
  const BottomModalSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getTextCheckBox(int index) {
      if (index == 0) {
        return 'Show All';
      } else if (index == 1) {
        return 'Completed';
      } else {
        return 'Not Completed';
      }
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(25),
      ),
      child: Container(
        decoration: SupportUtils.backgroundColor(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 360,
        child: BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
          if (state is NoteLoadedSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    3,
                    (index) => CheckboxListTile(
                      title: CheckBoxText(
                        text: getTextCheckBox(index),
                      ),
                      value: state.value == index ? true : false,
                      onChanged: (val) {
                        context
                            .read<NoteBloc>()
                            .add(FetchNotesByStatus(value: index));
                      },
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  },
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Sign out',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}

class CheckBoxText extends StatelessWidget {
  final String text;

  const CheckBoxText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
