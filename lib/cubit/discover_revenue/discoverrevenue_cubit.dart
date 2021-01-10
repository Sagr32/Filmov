import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:filmov/cubit/discover_vote/discovervote_cubit.dart';
import 'package:filmov/repository/movies_api_provider.dart';
import 'package:filmov/repository/movies_repository.dart';
import 'package:meta/meta.dart';
import '../../models/discover.dart';
part 'discoverrevenue_state.dart';

class DiscoverRevenueCubit extends Cubit<DiscoverRevenueState> {
  final MovieRepository _movieRepository;

  DiscoverRevenueCubit(this._movieRepository) : super(DiscoverrevenueInitial());

  Future discoverMoviesByRevenue() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        emit(DiscoverByRevenueLoading());
        final movies = await _movieRepository.discoverMoviesByVoteAvg();
        emit(DiscoverByRevenueLoaded(movies));
        // isOnline = true;
      } else {
        emit(DiscoverByRevenueLoadingError("Try again later"));
      }
      // isOnline = false;
    } on NetworkException catch (e) {
      emit(DiscoverByRevenueLoadingError(e.toString()));
    } on SocketException catch (e) {
      emit(DiscoverByRevenueLoadingError(e.toString()));
    }
  }
}
