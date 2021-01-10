import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:filmov/repository/movies_api_provider.dart';
import 'package:filmov/repository/movies_repository.dart';
import 'package:meta/meta.dart';
import '../../models/discover.dart';
part 'discoverpopularity_state.dart';

class DiscoverPopularityCubit extends Cubit<DiscoverPopularityState> {
    final MovieRepository _movieRepository;

  DiscoverPopularityCubit(this._movieRepository) : super(DiscoverPopularityInitial());




    Future discoverMoviesByPopularity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        emit(DiscoverByPopularityLoading());
        final movies = await _movieRepository.discoverMoviesByPopularity();
        emit(DiscoverByPopularityLoaded(movies));
        // isOnline = true;
      } else {
        emit(DiscoverByPopularityLoadingError("Try again later"));
      }
      // isOnline = false;
    } on SocketException catch (e) {
      emit(DiscoverByPopularityLoadingError(e.toString()));
    } on NetworkException catch (e) {
      emit(DiscoverByPopularityLoadingError(e.toString()));
    }
  }
}
