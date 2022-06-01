import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/note/note_bloc.dart';
import '../models/note.dart';
import '../utils/support_utils.dart';

class BottomModalAddNote extends StatefulWidget {
  final String action;
  final String? note, description;
  final int? indexList;

  const BottomModalAddNote({
    Key? key,
    required this.action,
    this.note,
    this.description,
    this.indexList,
  }) : super(key: key);

  @override
  State<BottomModalAddNote> createState() => _BottomModalAddNoteState();
}

class _BottomModalAddNoteState extends State<BottomModalAddNote> {
  final noteController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    noteController.text = widget.note ?? '';
    descriptionController.text = widget.description ?? '';
    super.initState();
  }

  @override
  void dispose() {
    noteController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state is AddNoteSuccess) {
          SupportUtils.showSnackBarDialog(
              context,
              'Add Note Completed!',
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ));
          Navigator.pop(context);
        } else if (state is EditNoteSuccess) {
          SupportUtils.showSnackBarDialog(
              context,
              'Edit Note Completed!',
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ));
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          child: Container(
            decoration: SupportUtils.backgroundColor(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          widget.action == 'create' ? Icons.add : Icons.edit,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.action == 'create' ? 'Add Note' : 'Edit Note',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        if (widget.action == 'create') {
                          Note note = Note(
                            title: noteController.text,
                            createDate: DateTime.now().toString(),
                            isCompleted: false,
                          );
                          context.read<NoteBloc>().add(AddNote(note: note));
                        } else {
                          Note note = Note(
                            title: noteController.text,
                            createDate: DateTime.now().toString(),
                            isCompleted: false,
                          );
                          context.read<NoteBloc>().add(EditNote(
                              note: note, indexList: widget.indexList));
                        }
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomizeTextField(
                  hintText: 'Note',
                  iconData: Icons.note,
                  controller: noteController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomizeTextField(
                  hintText: 'Description',
                  maxLines: 3,
                  iconData: Icons.description,
                  controller: descriptionController,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
                  if (state is AddNoteLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomizeTextField extends StatelessWidget {
  final String hintText;
  final int? maxLines;
  final IconData iconData;
  final TextEditingController controller;

  const CustomizeTextField(
      {Key? key,
      required this.hintText,
      this.maxLines,
      required this.iconData,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        prefixIcon: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
      maxLines: maxLines ?? 1,
      controller: controller,
    );
  }
}
