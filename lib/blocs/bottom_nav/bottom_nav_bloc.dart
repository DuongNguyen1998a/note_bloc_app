import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavInitial()) {
    on<BottomNavChanged>(_onBottomNavChanged);
  }

  void _onBottomNavChanged(BottomNavChanged event, Emitter<BottomNavState> emit) {
    final state = this.state;

    if (state is BottomNavInitial) {
      emit(BottomNavInitial(currentIndex: event.currentIndex));
    }

  }
}
