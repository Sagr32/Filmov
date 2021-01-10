import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:filmov/repository/movies_api_provider.dart';
import 'package:filmov/repository/movies_repository.dart';
import 'package:meta/meta.dart';
import '../../models/discover.dart';
part 'discoversoon_state.dart';

class DiscoversoonCubit extends Cubit<DiscoverSoonState> {
  final MovieRepository _movieRepository;
  DiscoversoonCubit(this._movieRepository) : super(DiscoversoonInitial());

  Future discoverMoviesComingSoon() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        emit(DiscoverSoonLoading());
        final movies = await _movieRepository.discoverMoviesComingSoon();
        emit(DiscoverSoonLoaded(movies));
        // isOnline = true;
      } else {
        emit(DiscoverSoonLoadingError("Try again later"));
      }
      // isOnline = false;
    } on NetworkException catch (e) {
      emit(DiscoverSoonLoadingError(e.toString()));
    } on SocketException catch (e) {
      emit(DiscoverSoonLoadingError(e.toString()));
    }
  }
}
