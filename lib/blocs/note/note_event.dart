part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
}

class FetchNotes extends NoteEvent {
  final List<Note> notes;
  final List<Note> searchNotes;

  const FetchNotes({this.notes = const [], this.searchNotes = const []});

  @override
  List<Object?> get props => [notes, searchNotes];
}

class SearchNote extends NoteEvent {
  final List<Note> notes;
  final String keySearch;

  const SearchNote({this.notes = const [], this.keySearch = ''});

  @override
  List<Object?> get props => [notes, keySearch];
}

class FetchNotesByStatus extends NoteEvent {
  final List<Note> notes;
  final int value;

  const FetchNotesByStatus({this.notes = const [], this.value = 0});

  @override
  List<Object?> get props => [notes, value];
}

class AddNote extends NoteEvent {
  final Note note;

  const AddNote(
      {this.note = const Note(title: '', createDate: '', isCompleted: false)});

  @override
  List<Object?> get props => [note];
}

class EditNote extends NoteEvent {
  final Note note;
  final int? indexList;

  const EditNote(
      {this.note = const Note(title: '', createDate: '', isCompleted: false), this.indexList});

  @override
  List<Object?> get props => [note, indexList!];
}
