import 'package:flutter/material.dart';
import 'package:my_ui_designs/app_theme.dart';
import 'package:my_ui_designs/custom_drawer/home_drawer.dart';

class DrawerUserController extends StatefulWidget {
  DrawerUserController(
      {
      this.drawerWidth = 250,
      this.onDrawerCall,
      this.screenView,
      this.animatedIconData = AnimatedIcons.arrow_menu,
      this.menuView,
      this.drawerIsOpen,
      this.screenIndex});

  final double drawerWidth;
  final Function(DrawerIndex) onDrawerCall;
  final Function(bool) drawerIsOpen;
  final AnimatedIconData animatedIconData;
  final Widget menuView;
  final Widget screenView;
  final DrawerIndex screenIndex;

  @override
  _DrawerUserControllerState createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController>
    with TickerProviderStateMixin {

  ScrollController scrollController;
  AnimationController iconAnimatedController;
  AnimationController animationController;
  double scrolloffset = 0.0;

  @override
  void initState() {
    animationController = AnimationController(duration:  Duration(microseconds: 2000), vsync: this);
    iconAnimatedController = AnimationController(vsync: this, duration:  Duration(microseconds: 0));
    iconAnimatedController..animateTo(1.0, duration: const Duration(microseconds: 0), curve: Curves.fastOutSlowIn);
    scrollController = ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController
      ..addListener(() {
        if (scrollController.offset <= 0) {
          if (scrolloffset != 1.0) {
            setState(() {
              scrolloffset = 1.0;
              try {
                widget.drawerIsOpen(true);
              } catch (_) {}
            });
          }
          iconAnimatedController.animateTo(0.0, duration: Duration(microseconds: 0), curve: Curves.fastOutSlowIn);
        } else if (scrollController.offset > 0 && scrollController.offset < widget.drawerWidth.floor()) {
          iconAnimatedController.animateTo(
              (scrollController.offset * 100 / (widget.drawerWidth)) / 100,
              duration: const Duration(microseconds: 0),
              curve: Curves.fastOutSlowIn);
        } else {
          if (scrolloffset != 0.0) {
            setState(() {
              scrolloffset = 0.0;
              try {
                widget.drawerIsOpen(false);
              } catch (_) {}
            });
          }
          iconAnimatedController.animateTo(1.0,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        }
      });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getInitState());
    super.initState();
  }

  Future<bool> getInitState() async {
    scrollController.jumpTo(widget.drawerWidth);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          child: Row(
            children: [
              SizedBox(
                width: widget.drawerWidth,
                height: MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: iconAnimatedController,
                  builder: (BuildContext context, Widget child) {
                    return Transform(transform: Matrix4.translationValues(scrollController.offset, 0.0, 0.0),
                      child: HomeDrawer(
                          screenIndex: widget.screenIndex == null ? DrawerIndex.HOME : widget.screenIndex,
                          iconAnimationController: iconAnimatedController,
                          callBackIndex: (DrawerIndex indexType){
                            onDrawerClick();
                            try{
                              widget.onDrawerCall(indexType);
                            }catch(e){}
                          },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: AppTheme.notWhite.withOpacity(0.9),
                            blurRadius: 24),
                      ]),
                  child: Stack(
                    children: [
                      IgnorePointer(
                        ignoring: scrolloffset == 1 || false,
                        child: widget.screenView,
                      ),
                      if (scrolloffset == 1.0)
                        InkWell(
                          onTap: () {
                            onDrawerClick();
                          },
                        ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 8,
                            left: 8),
                        child: SizedBox(
                          width: AppBar().preferredSize.height - 8,
                          height: AppBar().preferredSize.height - 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                  AppBar().preferredSize.height),
                              child: Center(
                                child: widget.menuView != null
                                    ? widget.menuView
                                    : AnimatedIcon(
                                        icon: widget.animatedIconData != null
                                            ? widget.animatedIconData
                                            : AnimatedIcons.arrow_menu,
                                        progress: iconAnimatedController,
                                      ),
                              ),
                              onTap: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                onDrawerClick();
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
  void onDrawerClick(){
    if(scrollController.offset != 0.0){
      scrollController.animateTo(0.0, duration: const Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
    }else{
      scrollController.animateTo(widget.drawerWidth, duration: const Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
    }
  }
}
