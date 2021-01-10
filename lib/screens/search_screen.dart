import 'package:filmov/cubit/search_cubit/search_cubit.dart';
import 'package:filmov/models/movie.dart';
import 'package:filmov/screens/details_screen.dart';
import 'package:filmov/util/size_config.dart';
import 'package:filmov/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MovieSearch extends SearchDelegate<Movie> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: BackButtonIcon(),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    SizeConfig().init(context);
    final searchCubit = context.bloc<SearchCubit>();
    searchCubit.searchMovie(query);
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    } else {
      return BlocConsumer<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return Container(
              height: SizeConfig.blockSizeVertical * 80,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SearchLoaded) {
            if (state.movies.movies.length != 0) {
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing: 5.0,
                  // mainAxisSpacing: 5.0,
                  childAspectRatio: 25 / 35,
                ),
                itemCount: state.movies.movies.length,
                itemBuilder: (context, index) {
                  print(query);
                  var result = state.movies.movies[index];
                  return MovieCard(
                    movie: result,
                    onTap: () {
                      Get.toNamed(DetailsScreen.routeName, arguments: result);
                    },
                  );
                },
              );
            } else {
              return Container(
                height: SizeConfig.blockSizeVertical * 80,
                child: Text(
                  "No Results Found.",
                ),
              );
            }
          } else {
            return Container();
          }
        },
        listener: (context, state) {
          if (state is SearchLoadingError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}

class MovieSearchEvent {
  final String query;

  const MovieSearchEvent(this.query);

  @override
  String toString() => 'CitySearchEvent { query: $query }';
}
