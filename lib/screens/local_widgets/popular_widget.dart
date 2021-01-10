import 'package:filmov/cubit/discover_popularity/discoverpopularity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../widgets/movie_card.dart';
import '../../cubit/movie_cubit/movie_cubit.dart';
import '../../util/size_config.dart';
import '../details_screen.dart';

class PopularWidget extends StatefulWidget {
  @override
  _PopularWidgetState createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {
  @override
  void initState() {
    final discoverCubit = context.bloc<DiscoverPopularityCubit>();
    discoverCubit.discoverMoviesByPopularity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: BlocConsumer<DiscoverPopularityCubit, DiscoverPopularityState>(
        listener: (context, state) {
          if (state is DiscoverByPopularityLoadingError) {
            // Scaffold.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(state.error),
            //   ),
            // );
            print("hey");
          }
        },
        builder: (context, state) {
          if (state is DiscoverByPopularityLoading) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is DiscoverByPopularityLoaded) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.movies.movies.length,
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => MovieCard(
                        movie: state.movies.movies[index],
                        onTap: () {
                          Get.toNamed(DetailsScreen.routeName,
                              arguments: state.movies.movies[index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DiscoverByPopularityLoading) {
            return Center(child: Text("Error"));
          } else {
            return Container();
          }
          // return Container();
        },
      ),
    );
  }
}
