import 'package:flutter/material.dart';
import 'rewardCategories.dart';



class RewardPage extends StatefulWidget {
  const RewardPage({Key key, this.callBack}) : super(key: key);

  final Function callBack;

  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage>
  with TickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
  animationController = AnimationController(
  duration: const Duration(milliseconds: 2000), vsync: this);
  super.initState();
  }

  Future<bool> getData() async {
  await Future<dynamic>.delayed(const Duration(milliseconds: 200));
  return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Vos Gains", style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
        ),
        body: new Center(
          child : new Container(
            decoration : BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  0.5,
                  0.5,
                ],
                colors: [
                  Colors.red,
                  Colors.redAccent,
                ],
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            child: getRewardCase(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


@override
  Widget getRewardCase() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                Category.rewardListe.length,
                    (int index) {
                  final int count = Category.rewardListe.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return CategoryView(
                    callback: () {
                      widget.callBack();
                    },
                    category: Category.rewardListe[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.8,
              ),
            );
          }
        },
      ),
    );
  }
}


class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key key,
        this.category,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Category category;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              onTap: () {
                callback();
              },
              child: SizedBox(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                // border: new Border.all(
                                //     color: DesignCourseAppTheme.notWhite),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 16, right: 16),
                                            child: Text(
                                              category.name,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                                letterSpacing: 0.27,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          new Container(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(top: 8, right: 10, left: 10),
                                              child: Container(
                                                child: ClipRRect(
                                                  child: AspectRatio(
                                                      aspectRatio: 1.28,
                                                      child: Image.asset(category.imagePath)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          new Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5,
                                                  left: 16,
                                                  right: 16,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    '${category.reduction} %',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 18,
                                                      letterSpacing: 0.27,
                                                      color: Colors
                                                          .yellow,

                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
