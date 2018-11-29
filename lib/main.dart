import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  int _previousPage = 0;

  double _previusScrollState = 0.0;

  List<Page> pages;

  PageController _pageController;

  @override
  void initState() {
    _pageController = new PageController(
      initialPage: _currentPage,
      viewportFraction: 1.0,
    );

    pages = <Page>[
      new Page("Page 1"),
      new Page("Page 2"),
      new Page("Page 3"),
      new Page("Page 4"),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: Container(
          child: new PageView(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            children: pages,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

class Page extends StatefulWidget {
  String title;

  Page(this.title);

  @override
  PageState createState() => new PageState();
}

class PageState extends State<Page> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _opacityAnimation;
  Animation<double> _sizeAnimation;

  @override
  void initState() {
    _animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 1));

    _opacityAnimation = _sizeAnimation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(new CurvedAnimation(
      parent: _animationController,
      curve: new Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
    ));

    _sizeAnimation = new Tween(
      begin: 0.5,
      end: 1.0,
    ).animate(new CurvedAnimation(
      parent: _animationController,
      curve: new Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
    ));

    if (_animationController.status == AnimationStatus.dismissed) {
      _animationController.forward();
    }

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      color: Colors.white70,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: (_opacityAnimation.value),
                  child: Container(
                    padding: const EdgeInsets.all(36.0),
                    child: new Text(
                      "${widget.title}",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                Opacity(
                  opacity: (_opacityAnimation.value),
                  child: Container(
                    padding: const EdgeInsets.all(36.0),
                    height: (100.0 * (1 + _sizeAnimation.value)),
                    width: (100.0 * (1 + _sizeAnimation.value)),
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                  width: 100.0,
                ),
                Opacity(
                  opacity: (_opacityAnimation.value),
                  child: Container(
                    padding: const EdgeInsets.all(26.0),
                    child: Center(
                      child: new Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae ligula bibendum augue fringilla faucibus id nec ex. Fusce gravida elementum lacus nec tincidunt. Nam quis lorem cursus, varius dolor at, dapibus mauris. Vestibulum et commodo nulla. Curabitur vulputate varius nibh sit amet suscipit. Maecenas mattis purus sed quam mattis."),
                    ),
                  ),
                ),
              ],
            );
          }),
    ));
  }
}
