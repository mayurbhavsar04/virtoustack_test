import 'package:flutter/material.dart';
import 'package:virtoustack_test_app/model/home_data_model.dart';
import 'package:virtoustack_test_app/screens/fb_login_screen.dart';
import 'package:virtoustack_test_app/service/home_api_service.dart';
import 'package:virtoustack_test_app/widget/home_screen_list_widget.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  HomeScreen(this.userName);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  List<HomeDataModel> dataList;
  bool isLOading = true;
  SubPath path;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){showCustomAlertDialog(context);});
    HomeDataApiService.getHomeDta().then((homeDataModelList) {
      setState(() {
        dataList = homeDataModelList;
        isLOading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        title: Center(
          child: Text(
            "Dog's Path",
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
      ),
      body: isLOading
          ? Center(
              child: Text("Loading...",
                  style: TextStyle(
                    fontSize: 15.0,
                      color: Theme.of(context).primaryColor)),
            )
          : ListView.builder(
              itemCount: dataList.length - 1,
              itemBuilder: ((BuildContext context, index) {
                HomeDataModel homeData = dataList[index];
                List<SubPath> subPaths = dataList[index].subPaths;
                return Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    )
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  homeData.title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${subPaths.length} Sub Paths',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              color: Colors.black,
                              child: Text(
                                "Open Path",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      HomeScreenWidget(subPaths),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              }),
            ),
    );
  }

  showCustomAlertDialog(BuildContext context){
    showDialog(
        context: context,
        builder: ( context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 155,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Alert",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    Text("Signed in as ${widget.userName}",
                        style: TextStyle(fontSize: 17)),
                    SizedBox(height: 20),
                    Divider( height: 2, color: Colors.black,),
                    SizedBox(height: 20),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Text("Ok",
                            style: TextStyle(fontSize: 20, color: Colors.lightBlueAccent, fontWeight: FontWeight.w600)),)

                  ],
                ),
              ),
            ),
          );
        });
  }
}
