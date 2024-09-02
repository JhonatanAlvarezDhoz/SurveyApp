part of 'home_bloc.dart';

final class HomeState extends Equatable {
  const HomeState({
    this.currentPage = 0,
    this.pageController,
  });

  final PageController? pageController;
  final int currentPage;

  HomeState copyWith({
    PageController? pageController,
    int? currentPage,
  }) {
    return HomeState(
      pageController: pageController ?? this.pageController,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [pageController, currentPage];
}
