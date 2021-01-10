import 'package:filmov/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../widgets/movie_card.dart';
import '../../util/size_config.dart';
import '../../cubit/trending_cubit/trending_cubit.dart';
import '../details_screen.dart';

class TrendingWidget extends StatefulWidget {
  @override
  _TrendingWidgetState createState() => _TrendingWidgetState();
}

class _TrendingWidgetState extends State<TrendingWidget> {
  @override
  void initState() {
    final discoverCubit = context.bloc<TrendingCubit>();
    discoverCubit.getTrending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: BlocConsumer<TrendingCubit, TrendingState>(
        listener: (context, state) {
          if (state is TrendingLoadingError) {
            // Scaffold.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(state.error),
            //   ),
            // );
            print("hey");
          }
        },
        builder: (context, state) {
          if (state is TrendingLoading) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is TrendingLoaded) {
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
                          "Trending",
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
                        itemBuilder: (context, index) {
                          return MovieCard(
                            movie: state.movies.movies[index],
                            onTap: () {
                              Get.toNamed(DetailsScreen.routeName,
                                  arguments: state.movies.movies[index]);
                            },
                          );
                        }),
                  ),
                ],
              ),
            );
          } else if (state is TrendingLoadingError) {
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
