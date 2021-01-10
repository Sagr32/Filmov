import '../cubit/movie_cubit/movie_cubit.dart';
import 'package:filmov/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleMovie extends StatefulWidget {
  static const String routeName = "single-movie";

  @override
  _SingleMovieState createState() => _SingleMovieState();
}

class _SingleMovieState extends State<SingleMovie> {
  Widget _buildCard(Movie movie) {
    return Center();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocConsumer<MovieCubit, MovieState>(
          listener: (context, state) {
            if (state is MovieLoadingError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is MovieInitial) {
              return Center(
                child: RaisedButton(
                  onPressed: () {
                    final movieCubit = context.bloc<MovieCubit>();
                    movieCubit.getMovie(1622);
                  },
                  child: Text("click"),
                ),
              );
            } else if (state is MovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieLoaded) {
              return Center(child: Text(state.movie.title));
            }
          },
        ),
      ),
    );
  }
}
