part of 'bottom_nav_bloc.dart';

abstract class BottomNavState extends Equatable {
  const BottomNavState();
}

class BottomNavInitial extends BottomNavState {
  final int currentIndex;

  const BottomNavInitial({this.currentIndex = 0});

  @override
  List<Object> get props => [currentIndex];
}
