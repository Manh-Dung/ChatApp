import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;
import 'package:vinhcine/generated/l10n.dart';
import 'package:vinhcine/repositories/movie_repository.dart';
import 'package:vinhcine/ui/components/loading_footer_widget.dart';
import 'package:vinhcine/ui/pages/home/tabs/movie_tab/movie_tab_cubit.dart';
import 'package:vinhcine/ui/rows/movie_widget.dart';
import 'package:vinhcine/ui/widgets/app_bar_widget.dart';
import 'package:vinhcine/ui/widgets/customized_scaffold_widget.dart';
import 'package:vinhcine/ui/widgets/error_list_widget.dart';
import 'package:vinhcine/ui/widgets/loading_list_widget.dart';

import '../../../../../configs/app_colors.dart';
import '../../../../../models/entities/movie.dart';
import '../../../../../router/routers.dart';

class MovieTabPage extends StatelessWidget {
  refresh.RefreshController _refreshController = refresh.RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final repository = RepositoryProvider.of<MovieRepository>(context);
        MovieTabCubit cubit = MovieTabCubit(repository: repository);
        return cubit..fetchMovieList(isReloaded: true);
      },
      child: CustomizedScaffold(
        appBar: AppBarWidget(title: S.of(context).movies),
        body: _buildBodyWidget(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: AppColors.primary,
          onPressed: () {
            context.read<MovieTabCubit>().addNewMovie();
          },
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocConsumer<MovieTabCubit, MovieTabState>(
      listenWhen: (prev, current) {
        return current is FetchingDataSuccessfully ||
            current is DidAnythingFail;
      },
      listener: (context, state) {
        _refreshController.loadComplete();
      },
      buildWhen: (prev, current) {
        return current is FetchingDataSuccessfully ||
            current is WaitingForFetchingData;
      },
      builder: (context, state) {
        if (state is WaitingForFetchingData) {
          return _buildLoadingList();
        } else if (state is DidAnythingFail) {
          return _buildFailureList(context);
        } else if (state is FetchingDataSuccessfully) {
          return RefreshIndicator(
            onRefresh: () =>
                context.read<MovieTabCubit>().fetchMovieList(isReloaded: true),
            child: refresh.SmartRefresher(
              controller: _refreshController,
              onLoading: () => context.read<MovieTabCubit>().fetchMovieList(),
              enablePullUp: state.canLoadMore && state.currentPage <= 3,
              enablePullDown: false,
              footer: CustomFooterWidget(horizontal: 20, vertical: 16),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: 1.0,
                    color: AppColors.lightGray,
                  ),
                ),
                itemBuilder: (context, int index) {
                  final item = state.movies?[index];
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          title: Text(S.of(context).message),
                          content: Text(S.of(context).do_you_want_to_delete),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: Text(
                                S.of(context).cancel,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              onPressed: () async {
                                bool deleteSuccess = context
                                    .read<MovieTabCubit>()
                                    .deleteMovie(item?.id ?? -1);
                                if (deleteSuccess) {
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(S.of(context).delete),
                            )
                          ],
                        ),
                      );
                    },
                    child: MovieWidget(
                      movie: item,
                      onPressed: () {
                        _goToMovieDetail(context, item);
                      },
                    ),
                  );
                },
                padding: EdgeInsets.zero,
                itemCount: state.movies?.length ?? 0,
              ),
            ),
          );
        } else
          return Container();
      },
    );
  }

  Widget _buildLoadingList() {
    return LoadingListWidget();
  }

  Widget _buildFailureList(BuildContext context) {
    return ErrorListWidget(
      onRefresh: () =>
          context.read<MovieTabCubit>().fetchMovieList(isReloaded: true),
    );
  }

  void _goToMovieDetail(BuildContext context, Movie? movie) {
    Navigator.pushNamed(context, Routers.movieDetail, arguments: {
      "movie": movie,
    });
  }
}
