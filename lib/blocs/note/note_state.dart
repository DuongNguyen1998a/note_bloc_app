part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();
}

class NoteInitial extends NoteState {
  @override
  List<Object> get props => [];
}

class NoteLoading extends NoteState {
  @override
  List<Object> get props => [];
}

class NoteLoadedSuccess extends NoteState {
  final List<Note> notes;
  final List<Note> searchNotes;
  final int value;

  const NoteLoadedSuccess({this.notes = const [], this.searchNotes = const [], this.value = 0});

  @override
  List<Object> get props => [notes, searchNotes, value];
}

class NoteLoadedError extends NoteState {
  @override
  List<Object> get props => [];
}

class AddNoteLoading extends NoteState {
  @override
  List<Object> get props => [];
}

class AddNoteSuccess extends NoteState {
  @override
  List<Object> get props => [];
}

class EditNoteSuccess extends NoteState {
  @override
  List<Object> get props => [];
}



