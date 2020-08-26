import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:virtoustack_test_app/model/home_data_model.dart';

class HomeScreenWidget extends StatefulWidget {
  final List<SubPath> subPaths;

  HomeScreenWidget(this.subPaths);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenWidget();
  }
}

class _HomeScreenWidget extends State<HomeScreenWidget> {
  final PageController controller = new PageController();
  int mSelectedPosition = 0;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 250,
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: PageView.builder(
              itemCount: widget.subPaths.length,
              itemBuilder: (context, index) {
                SubPath path = widget.subPaths[index];
                return Container(
                  child: Center(
                    //child: (Text('${path.title}'))
                    child: Image.network(
                      path.image,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  ),
                );
              },
              controller: controller,
              physics: BouncingScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  mSelectedPosition = value;
                  changeTitle();
                });
              },
            ),
          ),
          Container(
            color: Colors.black,
            height: 50,
            child: Center(
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.subPaths.length,
                itemBuilder: (context, index) {
                  SubPath path = widget.subPaths[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        mSelectedPosition = index;
                        // controller.jumpToPage(index);
                        controller.animateToPage(index,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOutCubic);
                      });
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Text(
                        '${path.title}   -->',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: index == mSelectedPosition
                                ? Colors.white
                                : Theme.of(context).accentColor),
                      ),
                    ),
                  );
                },
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
              ),
            ),
          ),
        ],
      ),
    );
  }

  changeTitle() {
    itemScrollController.scrollTo(
        index: mSelectedPosition,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOutCubic);
  }
}
