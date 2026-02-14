import 'package:flutter/material.dart';
import 'package:innohive/tools%20and%20templates/theme.dart';
import 'package:innohive/tools%20and%20templates/Drawer/commons/collapsing_navigation_drawer_widget.dart';
import 'package:innohive/tools%20and%20templates/glass%20_morphism_tile.dart';
import 'package:sizer/sizer.dart';
import '../tools and templates/Preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String LoginUser = "";
  final ScrollController _scrollController = ScrollController();

  bool isDarkMode = false;
  void _loadDarkModeState() async {
    bool darkModeEnabled = await DarkModePreferences.isDarkModeEnabled();
    setState(() {
      isDarkMode = darkModeEnabled;
    });
  }

  @override
  void initState() {
    super.initState();
    Myprefs.init();
    _loadDarkModeState();
    Myprefs.getPref("LoginUser").then((value) {
      setState(() {
        LoginUser = value;
      });
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width.toInt();
    var height = media.height.toInt();

    List<Map<String,dynamic>> leaderboard = [
      {
        "pos":"352",
        "profil_image":"",
        "name":"dev vicky",
        "points":"32014"
      },
      {
        "pos":"353",
        "profil_image":"",
        "name":"hello",
        "points":"31925"
      },
      {
        "pos":"354",
        "profil_image":"",
        "name":"coder gokul",
        "points":"31901"
      }
    ];

    List<Map<String,dynamic>> recprojects = [
      {
        "id":"74",
        "proimage":"",
        "proname":"stud_dev",
        "points":"150"
      },
      {
        "id":"73",
        "proimage":"",
        "proname":"eco sense",
        "points":"150"
      },
      {
        "id":"72",
        "proimage":"",
        "proname":"inno hive",
        "points":"150"
      }
    ];

    List<Map<String,dynamic>> recmsgs = [
      {
        "profile":"",
        "name":"dev vicky",
        "message":"hai bro are you free",
        "timestamp":"12:14 am"
      },
      {
        "profile":"",
        "name":"chandan",
        "message":"hey what about ou...",
        "timestamp":"11:36 am"
      },
      {
        "profile":"",
        "name":"nirav",
        "message":"bro you're rocking",
        "timestamp":"11:12 am"
      },
      {
        "profile":"",
        "name":"gopi",
        "message":"bro we need to dis...",
        "timestamp":"7:18 am"
      }
    ];

    return MaterialApp(
        theme: mytheme,
        debugShowCheckedModeBanner: false,
        home: Sizer(
          builder: (context, orientation, deviceType) {
            return SafeArea(
            child: Scaffold(
                body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: isDarkMode ? AppGradients.secondaryGradient : AppGradients.primaryGradient, // Use the global gradient
                  ),
                ),
                Center(
                  child: SizedBox(
                      height: height.toDouble() - 55,
                      width: width.toDouble() - 75,
                      child: Center(
                        child: ListView(
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text("Dashboard",
                                        style: TextStyle(
                                            color: isDarkMode ? Colors.white : Colors.black,
                                            fontSize: width < 419 ? 4.w : 2.w,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Welcome Board! ",style: TextStyle(color: isDarkMode ? Colors.white : Colors.black,fontSize: width < 419 ? 4.w : 2.w),),
                                        Text(LoginUser,
                                            style: TextStyle(
                                                color: isDarkMode ? Colors.white : Colors.black,
                                                fontSize: width < 419 ? 4.w : 2.w,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ]
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8),
          
                                child:  Column (
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
          
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: GlassTile(
                                        height: height > 480 ? 30.h : 50.h,
                                        width: width < 913 ? 80.w : 40.w,
                                        radius: 16,
                                        content:
                                        ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: leaderboard.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(9),
                                              child: GlassTile(
                                                height: height > 480 ? 7.5.h : 7.5.h,
                                                width: width < 913 ? 70.w : 30.w,
                                                radius: 16,
                                                content: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width < 414 ? 10 : 20),
                                                      child: Text(
                                                        leaderboard[index]["pos"],
                                                        style: TextStyle(
                                                          color: isDarkMode ? Colors.white : Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: width < 419 ? 3.w : 1.w,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width < 414 ? 10 : 5.w),
                                                      child: const CircleAvatar(),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: width < 414 ? 10 : 5.w),
                                                        child: Text(
                                                          leaderboard[index]["name"],
                                                          style: TextStyle(
                                                            color: isDarkMode ? Colors.white : Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: width < 419 ? 3.w : 1.w,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width < 414 ? 10 : 5.w,right: 15),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Image.asset(
                                                            "assets/points.png",
                                                            height: height > 480 ? 30.h : 50.h,
                                                            width: width < 414 ? 9.w : 5.w,
                                                          ),
                                                          Text(
                                                            leaderboard[index]["points"],
                                                            style: TextStyle(
                                                              color: isDarkMode ? Colors.white : Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: width < 419 ? 3.w : 1.w,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text("RECENT PROJECTS",textAlign: TextAlign.center,style: TextStyle(color: isDarkMode ? Colors.white : Colors.black,fontSize: width < 419 ? 4.w : 2.w - 10)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                    child: GlassTile(
                                        height: height > 480 ? 30.h : 50.h,
                                        width: width < 913 ? 80.w : 40.w,
                                        radius: 16,
                                        content:
                                        ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: recprojects.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(9),
                                              child: GlassTile(
                                                height: height > 480 ? 7.5.h : 7.5.h,
                                                width: width < 913 ? 70.w : 30.w,
                                                radius: 16,
                                                content: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width < 414 ? 10 : 20),
                                                      child: Text(
                                                        recprojects[index]["id"],
                                                        style: TextStyle(
                                                          color: isDarkMode ? Colors.white : Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: width < 419 ? 3.w : 1.w,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width < 414 ? 10 : 5.w),
                                                      child: const CircleAvatar(),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: width < 414 ? 10 : 5.w),
                                                        child: Text(
                                                          recprojects[index]["proname"],
                                                          style: TextStyle(
                                                            color: isDarkMode ? Colors.white : Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: width < 419 ? 3.w : 1.w,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width < 414 ? 10 : 5.w,right: 15),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Image.asset(
                                                            "assets/points.png",
                                                            height: height > 480 ? 30.h : 50.h,
                                                            width: width < 414 ? 9.w : 5.w,
                                                          ),
                                                          // ignore: prefer_interpolation_to_compose_strings
                                                          Text("+"+recprojects[index]["points"],
                                                            style: TextStyle(
                                                              color: isDarkMode ? Colors.white : Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: width < 419 ? 3.w : 1.w,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
          
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                    )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text("RECENT MESSAGES",textAlign: TextAlign.center,style: TextStyle(color: isDarkMode ? Colors.white : Colors.black,fontSize: width < 419 ? 4.w : 2.w - 10)),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: GlassTile(
                                            height: height > 480 ? 40.h : 60.h,
                                            width: width < 913 ? 80.w : 40.w,
                                            radius: 16,
                                            content:
                                            ListView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: recmsgs.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(9),
                                                  child: GlassTile(
                                                    height: height > 480 ? 7.5.h : 7.5.h,
                                                    width: width < 913 ? 70.w : 30.w,
                                                    radius: 16,
                                                    content: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: width < 414 ? 10 : 5.w),
                                                          child: const CircleAvatar(),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Padding(padding: EdgeInsets.only(left: width < 414 ? 10 : 5.w),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                recmsgs[index]["name"],
                                                                style: TextStyle(
                                                                  color: isDarkMode ? Colors.white : Colors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: width < 419 ? 3.w : 1.w,
                                                                ),
                                                              ),
                                                              Text(recmsgs[index]["message"],style: TextStyle(
                                                                color: isDarkMode ? Colors.white : Colors.black,
                                                                //fontWeight: FontWeight.bold,
                                                                fontSize: width < 419 ? 3.w : 1.w,
                                                              ),)
                                                            ],
                                                          )
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: width < 414 ? 10 : 5.w,right: 15,bottom: 20),
                                                          child: Text(
                                                                recmsgs[index]["timestamp"],
                                                            style: TextStyle(
                                                              color: isDarkMode ? Colors.white : Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: width < 419 ? 3.w - 2 : 1.w - 2,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                        )
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      )),
                ),
                CollapsingNavigationDrawer(currentSelectedIndex: 0),
              ]
            )
            )
            );
          },
        ));
  }
}
