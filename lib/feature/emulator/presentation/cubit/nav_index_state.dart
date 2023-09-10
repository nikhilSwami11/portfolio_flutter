part of 'nav_index_cubit.dart';

class NavIndexState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NavIndexInitial extends NavIndexState {}

class NavIndexCurrent extends NavIndexState {
  final int currentIndex;
  NavIndexCurrent({required this.currentIndex});

  @override
  List<Object?> get props => [currentIndex];
}
