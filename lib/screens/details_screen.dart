import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmov/models/genre.dart';
import 'package:filmov/models/movie.dart';
import 'package:filmov/screens/home_screen.dart';
import 'package:filmov/screens/second_details.dart';
import 'package:filmov/util/constants.dart';
import 'package:filmov/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../util/size_config.dart';
import '../util/theme.dart' as Style;
import '../cubit/similar_movies/similarmovies_cubit.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = "/details-screen";

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Movie movie = Get.arguments;
  @override
  void initState() {
    final similarMovies = context.bloc<SimilarMoviesCubit>();
    similarMovies.getSimilarMovies(movie.genreIds[0]);
    super.initState();
  }

  Future<bool> _onWillPop() async {
    Get.offAllNamed(HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 55,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: SizeConfig.blockSizeVertical * 35,
                        child: CachedNetworkImage(
                          imageUrl: kImagePath + Get.arguments.posterPath,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                // colorFilter: ColorFilter.mode(
                                //     Colors.red, BlendMode.colorBurn),
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            width: SizeConfig.blockSizeHorizontal * 100,
                            color: Color(0xFF764bc4),
                            child: Image.asset("assets/images/logo.png"),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          //  left: 124,
                          left: SizeConfig.blockSizeHorizontal * 50,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              Get.arguments.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: movie.genreIds.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  print(movie.genreIds.length);
                                  final List<String> geners = [];

                                  for (int i = 0;
                                      i < movie.genreIds.length;
                                      i++) {
                                    geners.add((Genre.getGenre(
                                        movie.genreIds[i].toString())));
                                  }
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(
                                        5,
                                      ),
                                    ),
                                    child: Center(child: Text(geners[index])),
                                  );
                                },
                              ),
                            ),

                            // Row(
                            //   children: [

                            //     Container(
                            //       padding: EdgeInsets.all(4),
                            //       decoration: BoxDecoration(
                            //         border: Border.all(),
                            //         borderRadius: BorderRadius.circular(
                            //           5,
                            //         ),
                            //       ),
                            //       child: Text("Drama"),
                            //     ),
                            //     SizedBox(
                            //       width: 5,
                            //     ),
                            //     Container(
                            //       padding: EdgeInsets.all(4),
                            //       decoration: BoxDecoration(
                            //         border: Border.all(),
                            //         borderRadius: BorderRadius.circular(
                            //           5,
                            //         ),
                            //       ),
                            //       child: Text("Action"),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Language : ${Get.arguments.originalLanguage}",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: SizeConfig.blockSizeVertical * 25,
                    left: SizeConfig.blockSizeHorizontal * 5,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/w500/${Get.arguments.backdropPath}",
                      imageBuilder: (context, imageProvider) => ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                          image: imageProvider,
                          // height: SizeConfig.blockSizeVertical * 25,
                          // width: SizeConfig.blockSizeHorizontal * 35,
                          height: SizeConfig.blockSizeVertical * 30,
                          width: SizeConfig.blockSizeVertical * 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        // height: SizeConfig.blockSizeVertical * 25,
                        // width: SizeConfig.blockSizeHorizontal * 35,
                        height: 200,
                        width: 150,
                        color: Color(0xFF764bc4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: SizeConfig.blockSizeVertical * 25,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        // height: SizeConfig.blockSizeVertical * 25,
                        // width: SizeConfig.blockSizeHorizontal * 35,
                        height: 200,
                        width: 150,
                        child: Column(
                          children: [
                            Icon(Icons.error),
                            Text(
                              error.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: SizeConfig.blockSizeHorizontal * 5,
                    top: SizeConfig.blockSizeVertical * 30,
                    child: FloatingActionButton(
                      elevation: 0,
                      mini: false,
                      onPressed: () {},
                      backgroundColor: Style.secondColor,
                      child: Text(
                        Get.arguments.voteAverage.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Overview",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                Get.arguments.overview,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Similar Movies",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BlocBuilder<SimilarMoviesCubit, SimilarMoviesState>(
              builder: (context, state) {
                if (state is SimilarMoviesLoading) {
                  return Container(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is SimilarMoviesLoaded) {
                  return Container(
                    height: SizeConfig.blockSizeVertical * 35,
                    child: ListView.builder(
                      itemCount: state.movies.movies.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return MovieCard(
                          movie: state.movies.movies[i],
                          onTap: () {
                            Get.offNamed(SecondDetails.routeName,
                                arguments: state.movies.movies[i]);
                            print("tapeed");
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
