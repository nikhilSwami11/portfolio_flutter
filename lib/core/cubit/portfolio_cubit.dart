import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portfolio/core/models/portfolio_model.dart';
import 'package:portfolio/core/repository/portfolio_repository.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioRepository repository;

  PortfolioCubit({required this.repository}) : super(PortfolioInitial());

  Future<void> loadPortfolioData() async {
    try {
      emit(PortfolioLoading());
      final data = await repository.getPortfolioData();
      emit(PortfolioLoaded(data));
    } catch (e) {
      emit(PortfolioError(e.toString()));
    }
  }
}
