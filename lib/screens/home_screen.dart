import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmov/cubit/discover_popularity/discoverpopularity_cubit.dart';
import 'package:filmov/cubit/discover_soon/discoversoon_cubit.dart';
import 'package:filmov/cubit/discover_vote/discovervote_cubit.dart';
import 'package:filmov/cubit/trending_cubit/trending_cubit.dart';
import 'package:filmov/models/discover.dart';
import 'package:filmov/models/movie.dart';
import 'package:filmov/screens/local_widgets/soon_widget.dart';
import 'package:filmov/screens/search_screen.dart';
import 'package:filmov/widgets/my_drawer.dart';
import 'package:get/get.dart';
import '../cubit/movie_cubit/movie_cubit.dart';
import 'package:filmov/repository/movies_api_provider.dart';
import 'package:filmov/screens/local_widgets/popular_widget.dart';
import 'package:filmov/util/constants.dart';
import 'package:filmov/util/my_connectivity.dart';
import 'package:filmov/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:share/share.dart';
import '../util/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
import './local_widgets/trending_widget.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  MyConnectivity _connectivity = MyConnectivity.instance;

  final controller = PageController();
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _connectivity.initialise();

    _controller = TabController(length: 7, vsync: this);
    final QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      if (shortcutType == 'share') {
        Share.share(
            "you can download my app from here \n https://play.google.com/store/apps/details?id=com.sagrkai.filmov");

        //main();
      } else {
        print('The user tapped on the "increment" action.');
      }
    });

    quickActions.setShortcutItems(
      <ShortcutItem>[
        const ShortcutItem(
            type: 'share', localizedTitle: 'Share App', icon: 'share'),
      ],
    );
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  Future<String> _loadMorePosts() async {
    final discoverVoteCubit = context.bloc<DiscoverVoteCubit>();
    final discoverPopCubit = context.bloc<DiscoverPopularityCubit>();
    final discoverSoonCubit = context.bloc<DiscoversoonCubit>();
    final trendingCubit = context.bloc<TrendingCubit>();
    trendingCubit.getTrending();
    discoverPopCubit.discoverMoviesByPopularity();
    discoverVoteCubit.discoverMoviesByVoteAvg();
    discoverSoonCubit.discoverMoviesComingSoon();
    return 'success';
  }

  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: MovieSearch(),
      query: "",
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          "FILMOV",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "OdudoMono",
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
            ),
            onPressed: () {
              _showSearch();
            },
          ),
        ],
      ),
      body:
          // NestedScrollView(
          //   headerSliverBuilder: (context, innerBoxScrolled) => [
          //     CustomSliverAppBar(
          //       height: MediaQuery.of(context).size.width * 0.6,
          //     ),
          //   ],
          //   body: RefreshIndicator(
          //     onRefresh: _loadMorePosts,
          //     child: ListView(
          //       children: [
          //         PopularWidget(),
          //       ],
          //     ),
          //   ),
          // ),
          RefreshIndicator(
        onRefresh: _loadMorePosts,
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              height: MediaQuery.of(context).size.width * 0.6,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: 10,
                  ),
                  TrendingWidget(),
                  PopularWidget(),
                  SoonWidget(),
                  // PopularWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSliverAppBar extends StatefulWidget {
  const CustomSliverAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;

  @override
  _CustomSliverAppBarState createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  PageController appBarPageController =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    final discoverCubit = context.bloc<DiscoverVoteCubit>();
    discoverCubit.discoverMoviesByVoteAvg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: new Container(),
      backgroundColor: Color(0xff26262d),
      expandedHeight: widget.height,
      flexibleSpace: FlexibleSpaceBar(
        background: BlocConsumer<DiscoverVoteCubit, DiscoverVoteState>(
            listener: (context, state) {
          if (state is DiscoverByVoteLoadingError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
            // cubit: DiscoverCubit(MoviesApiProvider()),
            builder: (context, state) {
          if (state is DiscoverVoteInitial) {
            return Container(
              height: MediaQuery.of(context).size.width * 0.6,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is DiscoverByVoteLoading) {
            return Container(
              height: MediaQuery.of(context).size.width * 0.6,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is DiscoverByVoteLoaded &&
              state.movies.movies[0].posterPath != null) {
            print(state.movies.movies[0].posterPath);
            return Container(
              height: MediaQuery.of(context).size.width * 0.6,
              child: PageIndicatorContainer(
                align: IndicatorAlign.bottom,
                length: 5,
                indicatorSpace: 8.0,
                padding: const EdgeInsets.all(5.0),
                indicatorColor: Style.titleColor,
                indicatorSelectorColor: Style.secondColor,
                shape: IndicatorShape.circle(size: 5.0),
                child: PageView.builder(
                  controller: appBarPageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      // onTap: () {
                      //   Get.toNamed(DetailsScreen.routeName,
                      //       arguments: state.movies.movies[index]);
                      // },
                      child: AppBarCard(
                        movie: state.movies.movies[index],
                        imagePoster: state.movies.movies[index].backdropPath,
                        title: state.movies.movies[index].title != null
                            ? state.movies.movies[index].title
                            : "",
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is DiscoverByVoteLoadingError) {
            return Center(child: Text("Check your internet"));
          } else {
            print(state);
            return Container(
              child: Text("hey"),
            );
          }
        }),
      ),
    );
  }
}

class AppBarCard extends StatelessWidget {
  final String imagePoster;
  final String title;
  final Movie movie;
  AppBarCard({
    @required this.imagePoster,
    @required this.movie,
    @required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.toNamed(DetailsScreen.routeName, arguments: movie);
      },
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: imagePoster != null
                ? kImagePath + imagePoster
                : "https://bit.ly/34gLECx",
            imageBuilder: (context, imageProvider) => imagePoster != null
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://bit.ly/34gLECx"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            placeholder: (context, url) => Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              color: Color(0xFF764bc4),
              child: Image.asset("assets/images/logo.png"),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 0.9],
                colors: [
                  Style.mainColor.withOpacity(1.0),
                  Style.mainColor.withOpacity(0.0)
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30.0,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              width: 250.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title != null ? title : "",
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
