import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:filmov/repository/movies_api_provider.dart';
import 'package:filmov/repository/movies_repository.dart';
import 'package:meta/meta.dart';
import '../../models/discover.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final MovieRepository _movieRepository;
  SearchCubit(this._movieRepository) : super(SearchInitial());

  Future searchMovie(String query) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        emit(SearchLoading());
        final movies = await _movieRepository.searchMovie(query);
        emit(SearchLoaded(movies));
        // isOnline = true;
      } else {
        emit(SearchLoadingError('Error occured , Please try again later '));
      }
      // isOnline = false;
    } on NetworkException catch (e) {
      emit(SearchLoadingError('Error occured , Please try again later '));
    } on SocketException catch (e) {
      emit(SearchLoadingError('Error occured , Please try again later '));
    }
  }
}
