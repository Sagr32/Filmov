import 'package:filmov/cubit/discover_soon/discoversoon_cubit.dart';
import 'package:filmov/screens/details_screen.dart';
import 'package:filmov/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../widgets/movie_card.dart';
import '../../util/size_config.dart';

class SoonWidget extends StatefulWidget {
  @override
  _SoonWidgetState createState() => _SoonWidgetState();
}

class _SoonWidgetState extends State<SoonWidget> {
  @override
  void initState() {
    final discoverCubit = context.bloc<DiscoversoonCubit>();
    discoverCubit.discoverMoviesComingSoon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: BlocConsumer<DiscoversoonCubit, DiscoverSoonState>(
        listener: (context, state) {
          if (state is DiscoverSoonLoadingError) {
            // Scaffold.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(state.error),
            //   ),
            // );
            print("hey");
          }
        },
        builder: (context, state) {
          if (state is DiscoverSoonLoading) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is DiscoverSoonLoaded) {
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
                          "Soon",
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
                          if (state.movies.movies[index].posterPath != null) {
                            return MovieCard(
                              movie: state.movies.movies[index],
                              onTap: () {
                                Get.toNamed(DetailsScreen.routeName,
                                    arguments: state.movies.movies[index]);
                              },
                            );
                          } else {
                            return Container();
                          }
                        }),
                  ),
                ],
              ),
            );
          } else if (state is DiscoverSoonLoading) {
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
