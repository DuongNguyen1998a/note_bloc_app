import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_bloc_app/widgets/customize_circle_progress_bar.dart';

import '../blocs/note/note_bloc.dart';
import '../models/note.dart';
import '../utils/support_utils.dart';
import '../widgets/bottom_modal_add_note.dart';
import '../widgets/bottom_modal_setting.dart';
import '../widgets/customize_app_bar.dart';
import 'base_screen.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Note screen build');
    return BaseScreen(
      isShowBottomNav: true,
      body: Column(
        children: [
          CustomizeAppBar(
            title: 'My notes',
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
          const NoteSearchBar(),
          BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
            if (state is NoteLoading) {
              return const NoteTotal(total: 0);
            } else if (state is NoteLoadedSuccess) {
              return NoteTotal(total: state.searchNotes.length);
            } else {
              return const NoteTotal(total: 0);
            }
          }),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
            if (state is NoteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
                // CustomizeCircleProgressBar(
                //   isDone: state.toString() != 'NoteLoading' ? false : true
                // ),
              );
            } else if (state is NoteLoadedSuccess) {
              if (state.searchNotes.isEmpty) {
                return const Center(
                    child: Text(
                  'No available notes.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 18,
                  ),
                ));
              } else {
                return NoteList(
                  length: state.searchNotes.length,
                  notes: state.searchNotes,
                );
              }
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }
}

class NoteSearchBar extends StatelessWidget {
  const NoteSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Search ...',
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (val) {
          if (val.isEmpty) {
            context.read<NoteBloc>().add(const SearchNote(keySearch: ''));
          } else {
            context.read<NoteBloc>().add(SearchNote(keySearch: val));
          }
        },
      ),
    );
  }
}

class NoteTotal extends StatelessWidget {
  final int total;

  const NoteTotal({Key? key, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Divider(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          'A total of $total',
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        const SizedBox(
          width: 20,
        ),
        const Expanded(
          child: Divider(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class NoteList extends StatelessWidget {
  final int length;
  final List<Note> notes;

  const NoteList({Key? key, required this.length, required this.notes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<NoteBloc>().add(const FetchNotes());
        },
        child: ListView.builder(
          itemCount: length,
          itemBuilder: (context, index) => NoteItem(
            note: notes[index],
            index: index,
          ),
        ),
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final Note note;
  final int index;

  const NoteItem({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SupportUtils.showModalBottomSheetDialog(
          context,
          BottomModalAddNote(
            action: 'edit',
            note: note.title,
            description: note.title,
            indexList: index,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        height: 160,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  note.getMonthAndYear(),
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  note.getDay(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ListTileTheme(
                        contentPadding: const EdgeInsets.all(0),
                        dense: true,
                        horizontalTitleGap: 0.0,
                        minLeadingWidth: 0,
                        child: ExpansionTile(
                            title: Text(
                              note.title,
                              style: TextStyle(
                                  fontSize: 20,
                                  decoration: note.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null),
                              maxLines: 1,
                            ),
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  3,
                                  (index) => Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(Icons.person),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      note.getTime(),
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
