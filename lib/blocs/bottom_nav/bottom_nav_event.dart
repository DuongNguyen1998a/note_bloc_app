part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();
}

class BottomNavChanged extends BottomNavEvent {
  final int currentIndex;

  const BottomNavChanged({this.currentIndex = 0});

  @override
  List<Object?> get props => [currentIndex];

}
