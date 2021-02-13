import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_ui_designs/app_theme.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex});

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList> drawerList;

  @override
  void initState() {
    setDrawableListArray();
    super.initState();
  }

  void setDrawableListArray() {
    drawerList = [
      DrawerList(
          index: DrawerIndex.HOME, labelName: 'Home', icon: Icon(Icons.home)),
      DrawerList(
          index: DrawerIndex.Help,
          labelName: 'Help',
          isAssetsImage: true,
          imageName: 'assets/images/supportIcon.png'),
      DrawerList(
          index: DrawerIndex.Invite,
          labelName: 'Invite Friend',
          icon: Icon(Icons.group)),
      DrawerList(
          index: DrawerIndex.Share,
          labelName: 'Rate the app',
          icon: Icon(Icons.share)),
      DrawerList(
          index: DrawerIndex.About,
          labelName: 'About us',
          icon: Icon(Icons.info)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(
                            1.0 - (widget.iconAnimationController.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppTheme.grey,
                                      offset: const Offset(2.0, 4.0),
                                      blurRadius: 8),
                                ]),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              child: Image.asset(
                                'assets/images/myPhoto.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      'Chima Nwakigwe',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: AppTheme.grey),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Divider(
            height: 4,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0.0),
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index) {
                return inkWell(drawerList[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget inkWell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {},
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  Container(
                    height: 46.0,
                    width: 6.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            listData.imageName,
                            color: widget.screenIndex == listData.index
                                ? Colors.teal[900]
                                : AppTheme.nearlyBlack,
                          ),
                        )
                      : Icon(
                          listData.icon.icon,
                          color: widget.screenIndex == listData.index
                              ? Colors.teal[900]
                              : AppTheme.nearlyBlack,
                        ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: widget.screenIndex == listData.index
                            ? Colors.teal[900]
                            : AppTheme.nearlyBlack),
                  )
                ],
              ),
            ),
            widget.screenIndex == listData.index ? AnimatedBuilder(
              animation: widget.iconAnimationController,
              builder: (BuildContext context, Widget child){
                return Transform(
                  transform: Matrix4.translationValues((MediaQuery.of(context).size.width * 0.75 - 64)
                  * (1.0 - widget.iconAnimationController.value - 1.0), 0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75 - 64,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(28),
                          bottomLeft:Radius.circular(0),
                          bottomRight: Radius.circular(28),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ) : SizedBox()
          ],
        ),
      ),
    );
  }
}

enum DrawerIndex {
  HOME,
  FeedBack,
  Help,
  Share,
  About,
  Invite,
  Testing,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}
