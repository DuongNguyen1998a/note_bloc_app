import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/note.dart';

part 'note_event.dart';

part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial()) {
    on<FetchNotes>(_onFetchNotes);
    on<SearchNote>(_onSearchNote);
    on<FetchNotesByStatus>(_onFetchNotesByStatus);
    on<AddNote>(_onAddNote);
    on<EditNote>(_onEditNote);
  }

  Future<void> _onFetchNotes(FetchNotes event, Emitter<NoteState> emit) async {
    //debugPrint('Call _onFetchNotes');

    emit(NoteLoading());

    await Future.delayed(const Duration(seconds: 5));

    final notes = Note.fetchNotes();

    emit(NoteLoadedSuccess(notes: notes, searchNotes: notes));
  }

  void _onSearchNote(SearchNote event, Emitter<NoteState> emit) {
    final state = this.state;

    if (state is NoteLoadedSuccess) {
      final notes = state.notes;
      if (event.keySearch == '') {
        emit(NoteLoadedSuccess(notes: notes, searchNotes: notes));
        //debugPrint('Notes: ${state.notes.length}, SearchNotes: ${state.searchNotes.length}, Keyword: ${event.keySearch}');
      } else {
        //debugPrint('Notes: ${state.notes.length}, SearchNotes: ${state.searchNotes.length}, Keyword: ${event.keySearch}');
        List<Note> search = state.notes
            .where((element) => element.title
                .toLowerCase()
                .contains(event.keySearch.toLowerCase()))
            .toList();

        emit(NoteLoadedSuccess(notes: notes, searchNotes: search));
        //debugPrint('Notes: ${state.notes.length}, SearchNotes: ${state.searchNotes.length}, Keyword: ${event.keySearch}');
      }
    }
  }

  void _onFetchNotesByStatus(
      FetchNotesByStatus event, Emitter<NoteState> emit) {
    final state = this.state;

    if (state is NoteLoadedSuccess) {
      final notes = state.notes;
      if (event.value == 0) {
        // show all
        emit(NoteLoadedSuccess(
            notes: notes, searchNotes: notes, value: event.value));
      } else if (event.value == 1) {
        // completed
        List<Note> completedNotes =
            state.notes.where((element) => element.isCompleted).toList();

        emit(NoteLoadedSuccess(
            notes: state.notes,
            searchNotes: completedNotes,
            value: event.value));
      } else {
        // not completed
        List<Note> uncompletedNotes =
            state.notes.where((element) => !element.isCompleted).toList();

        emit(NoteLoadedSuccess(
            notes: state.notes,
            searchNotes: uncompletedNotes,
            value: event.value));
      }

      //debugPrint('Current value: ${state.value}');
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    final state = this.state;

    if (state is NoteLoadedSuccess) {
      emit(AddNoteLoading());

      await Future.delayed(const Duration(seconds: 2));

      List<Note> notes = Note.fetchNotes();
      notes.add(event.note);

      emit(AddNoteSuccess());

      emit(NoteLoadedSuccess(notes: notes, searchNotes: notes, value: state.value));

    }
  }

  Future<void> _onEditNote(EditNote event, Emitter<NoteState> emit) async {
    final state = this.state;

    if (state is NoteLoadedSuccess) {
      emit(AddNoteLoading());

      await Future.delayed(const Duration(seconds: 2));

      List<Note> notes = Note.fetchNotes();
      notes[event.indexList!] = event.note;

      emit(EditNoteSuccess());

      emit(NoteLoadedSuccess(notes: notes, searchNotes: notes, value: state.value));

    }
  }
}
