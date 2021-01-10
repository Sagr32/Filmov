import 'package:filmov/cubit/discover_soon/discoversoon_cubit.dart';
import 'package:filmov/cubit/search_cubit/search_cubit.dart';
import 'package:filmov/repository/movies_api_provider.dart';
import 'package:filmov/repository/movies_repository.dart';
import 'package:filmov/screens/details_screen.dart';
import 'package:filmov/screens/home_screen.dart';
import 'package:filmov/screens/search_screen.dart';
import 'package:filmov/screens/second_details.dart';
import 'package:filmov/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'cubit/discover_revenue/discoverrevenue_cubit.dart';
import 'cubit/discover_vote/discovervote_cubit.dart';
import 'cubit/movie_cubit/movie_cubit.dart';
import 'cubit/discover_popularity/discoverpopularity_cubit.dart';
import 'cubit/trending_cubit/trending_cubit.dart';
import './cubit/similar_movies/similarmovies_cubit.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieCubit(MoviesApiProvider()),
        ),
        BlocProvider(
          create: (context) => DiscoverPopularityCubit(MoviesApiProvider()),
        ),
        BlocProvider(
          create: (context) => DiscoverVoteCubit(MoviesApiProvider()),
        ),
        BlocProvider(
          create: (context) => DiscoverRevenueCubit(MoviesApiProvider()),
        ),
        BlocProvider(
          create: (context) => DiscoversoonCubit(MoviesApiProvider()),
        ),
        BlocProvider(
          create: (context) => TrendingCubit(MoviesApiProvider()),
        ),
        BlocProvider(
          create: (context) => SimilarMoviesCubit(MoviesApiProvider()),
        ),
        BlocProvider(
          create: (context) => SearchCubit(MoviesApiProvider()),
        ),
      ],
      child: GetMaterialApp(
        title: "Filmov",
        debugShowCheckedModeBanner: false,
        // home: HomeScreen(),
        theme: ThemeData(
            //    fontFamily: "OdudoMono",
            ),
        getPages: [
          GetPage(
            name: "/",
            page: () => SplashScreen(),
          ),
          GetPage(
            name: HomeScreen.routeName,
            page: () => HomeScreen(),
          ),
          GetPage(
            name: DetailsScreen.routeName,
            page: () => DetailsScreen(),
          ),
             GetPage(
            name: SecondDetails.routeName,
            page: () => SecondDetails(),
          ),
        ],
      ),
    );
  }
}
