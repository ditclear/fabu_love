// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:fabu_love/di/module.dart';
import 'package:fabu_love/helper/constants.dart';
import 'package:fabu_love/helper/widget_utils.dart';
import 'package:fabu_love/main.dart';
import 'package:fabu_love/model/app.dart';
import 'package:fabu_love/model/model.dart';
import 'package:fabu_love/model/repo.dart';
import 'package:fabu_love/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:url_launcher/url_launcher.dart';

// This demo displays one Category at a time. The backdrop show a list
// of all of the categories and the selected category is displayed
// (CategoryView) on top of the backdrop.

class CategoryView extends StatelessWidget {
  const CategoryView({Key key, this.category, this.list}) : super(key: key);

  final TeamsListBean category;
  final List<AppListBean> list;

  void _previewApp(AppListBean app) {
    launch(host + app.shortUrl);
  }

  Widget _buildList(BuildContext context) {
    return ListView(
        physics: BouncingScrollPhysics(),
        key: PageStorageKey<TeamsListBean>(category),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        children: list != null
            ? list.map<Widget>((AppListBean app) {
//        return ListTile(leading:SizedBox.fromSize(size:Size(30.0,30.0),child:Image.network("https://fabu.love/"+app.icon)),title: Text(app.appName),);
                return _buildListItem(app);
              }).toList()
            : [
                Center(
                  child: const Text("empty"),
                )
              ]);
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: list.map<Widget>((AppListBean app) {
          return _buildListItem(app);
        }).toList());
  }

  Container _buildListItem(AppListBean app) {
    return Container(
        child: SafeArea(
      top: false,
      bottom: false,
      child: Container(
          padding: const EdgeInsets.fromLTRB(24.0, 8, 24.0, 8),
          width: 264.0,
          child: Card(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 12),
                child: SizedBox.fromSize(
                    size: Size(72.0, 72.0),
                    child: Image.network(host + app.icon)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 12.0),
                child: Text(
                  app.appName,
                  textAlign: TextAlign.start,
                  style: Typography.dense2018.title,
                ),
              ),
              Table(
                columnWidths: const {
                  0: FixedColumnWidth(100.0),
                },
                children: [
                  TableRow(children: [
                    Text(
                      "短链接:",
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      host + app.shortUrl,
                      overflow: TextOverflow.ellipsis,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "PackageName: ",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        height: 2.0,
                      ),
                    ),
                    Text(app.bundleId,
                        style: TextStyle(
                          height: 2.0,
                        )),
                  ]),
                  TableRow(children: [
                    Text("当前版本 :  ",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          height: 2.0,
                        )),
                    Text(
                      app.currentVersion,
                      style: TextStyle(
                        height: 2.0,
                      ),
                    )
                  ]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    tooltip: "编辑",
                    icon: Icon(Icons.edit),
                    onPressed: () => {},
                  ),
                  IconButton(
                    tooltip: "预览",
                    icon: Icon(Icons.near_me),
                    onPressed: () => _previewApp(app),
                  ),
                ],
              )
            ],
          ))),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return _buildList(context);
    } else {
      return _buildGrid(context);
    }
  }
}

// One BackdropPanel is visible at a time. It's stacked on top of the
// the BackdropDemo.
class BackdropPanel extends StatelessWidget {
  const BackdropPanel({
    Key key,
    this.onTap,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.title,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      elevation: 2.0,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragUpdate: onVerticalDragUpdate,
            onVerticalDragEnd: onVerticalDragEnd,
            onTap: onTap,
            child: Container(
              height: 48.0,
              padding: const EdgeInsetsDirectional.only(start: 16.0),
              alignment: AlignmentDirectional.centerStart,
              child: DefaultTextStyle(
                style: theme.textTheme.subhead,
                child: Tooltip(
                  message: 'Tap to dismiss',
                  child: title,
                ),
              ),
            ),
          ),
          const Divider(height: 1.0),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// Cross fades between 'Select a Category' and 'Asset Viewer'.
class BackdropTitle extends AnimatedWidget {
  const BackdropTitle({
    Key key,
    Listenable listenable,
  }) : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: CurvedAnimation(
              parent: ReverseAnimation(animation),
              curve: const Interval(0.5, 1.0),
            ).value,
            child: const Text('切换团队'),
          ),
          Opacity(
            opacity: CurvedAnimation(
              parent: animation,
              curve: const Interval(0.5, 1.0),
            ).value,
            child: const Text('fabu.love'),
          ),
        ],
      ),
    );
  }
}

// This widget is essentially the backdrop itself.
class BackdropDemo extends StatefulWidget {
  const BackdropDemo() : super();

  static const String routeName = '/material/backdrop';

  @override
  _BackdropDemoState createState() {
    final user = spUtil.getString(KEY_USER);
    return _BackdropDemoState(
        model: DataBean.fromJson(jsonDecode(user)), repo: provideAppRepo());
  }
}

class _BackdropDemoState extends State<BackdropDemo>
    with SingleTickerProviderStateMixin {
  final DataBean model;
  final AppRepo repo;

  _BackdropDemoState({@required this.model, this.repo}) : super();

  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  TeamsListBean _category;

  List<AppListBean> _list;

  @override
  void initState() {
    super.initState();
    _category = model.teams[0];

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );

    _loadAppList();
  }

  void _loadAppList() => repo
      .getAppListByTeamId(_category.id)
      .listen((list) => setState(() {
            _list = list;
          }))
      .onError((e) => dispatchFailure(context, e));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeCategory(TeamsListBean category) {
    setState(() {
      _category = category;
      _controller.fling(velocity: 2.0);
    });
    _loadAppList();
  }

  bool get _backdropPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropPanelVisibility() {
    _controller.fling(velocity: _backdropPanelVisible ? -2.0 : 2.0);
  }

  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  // By design: the panel can only be opened with a swipe. To close the panel
  // the user must either tap its heading or the backdrop's menu icon.

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    _controller.value -=
        details.primaryDelta / (_backdropHeight ?? details.primaryDelta);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  // Stacks a BackdropPanel, which displays the selected category, on top
  // of the backdrop. The categories are displayed with ListTiles. Just one
  // can be selected at a time. This is a LayoutWidgetBuild function because
  // we need to know how big the BackdropPanel will be to set up its
  // animation.
  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double panelTitleHeight = 48.0;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;

    final Animation<RelativeRect> panelAnimation = _controller.drive(
      RelativeRectTween(
        begin: RelativeRect.fromLTRB(
          0.0,
          panelTop - MediaQuery.of(context).padding.bottom,
          0.0,
          panelTop - panelSize.height,
        ),
        end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      ),
    );

    final ThemeData theme = Theme.of(context);
    final List<Widget> backdropItems =
        model.teams.map<Widget>((TeamsListBean team) {
      final bool selected = team == _category;
      return Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        color: selected ? Colors.white.withOpacity(0.25) : Colors.transparent,
        child: ListTile(
          title: Text(team.name),
          selected: selected,
          onTap: () {
            _changeCategory(team);
          },
        ),
      );
    }).toList();

    return Container(
      key: _backdropKey,
      color: theme.primaryColor,
      child: Stack(
        children: <Widget>[
          ListTileTheme(
            iconColor: theme.primaryIconTheme.color,
            textColor: theme.primaryTextTheme.title.color.withOpacity(0.6),
            selectedColor: theme.primaryTextTheme.title.color,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: backdropItems,
              ),
            ),
          ),
          PositionedTransition(
            rect: panelAnimation,
            child: BackdropPanel(
              onTap: _toggleBackdropPanelVisibility,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              title: Text(_category.name),
              child: CategoryView(category: _category, list: _list),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: BackdropTitle(
          listenable: _controller.view,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: _toggleBackdropPanelVisibility,
            icon: AnimatedIcon(
              icon: AnimatedIcons.close_menu,
              semanticLabel: 'close',
              progress: _controller.view,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: _buildStack,
      ),
      floatingActionButton: Provide<CountViewModel>(
          builder: (BuildContext context, Widget child, CountViewModel value) =>
              Builder(builder: (BuildContext context) {
                return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                      onPressed: value.increment,
                      tooltip: 'plus',
                      child: Icon(Icons.plus_one),
                    ));
              })),
    );
  }
}
