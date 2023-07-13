import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_mobdev/data/data_state.dart';
import 'package:suitmedia_mobdev/data/model/user_model.dart';
import 'package:suitmedia_mobdev/data/repository/user_repository.dart';

class ListUserCubit extends Cubit<DataState> {
  final UserRepository repository = UserRepository();

  ListUserCubit() : super(InitialState());

  int currentPage = 1;
  final int _perPage = 10;

  void getAllUser(bool isRefresh, int id, String email, String firstName, String lastName, String avatar) {
    try {
      if (isRefresh) currentPage = 1;
      if (state is LoadingPaginationState) return;

      final currentState = state;

      List<UserModel> oldData = [];
      if (currentState is SuccessState && !isRefresh) {
        oldData = currentState.data;
      }

      emit(LoadingPaginationState(oldData, isFirstFetch: currentPage == 1));

      repository
          .getAllPengajuan(currentPage.toString(), _perPage.toString(), id, email,
          firstName, lastName, avatar)
          .then((value) {
        currentPage++;

        final List<UserModel> data = (state as LoadingPaginationState).oldData;
        data.addAll(value);

        emit(SuccessState<List<UserModel>>(data));
      });
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void resetState() {
    emit(InitialState());
  }
}