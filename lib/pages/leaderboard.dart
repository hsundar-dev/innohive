import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:innohive/tools%20and%20templates/theme.dart';
import 'package:sizer/sizer.dart';
import '../tools and templates/Drawer/commons/collapsing_navigation_drawer_widget.dart';
import '../tools and templates/glass _morphism_tile.dart';


class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {

  bool isDarkMode = false;
  void _loadDarkModeState() async {
    bool darkModeEnabled = await DarkModePreferences.isDarkModeEnabled();
    setState(() {
      isDarkMode = darkModeEnabled;
    });
  }

  @override
  void initState() {
    _loadDarkModeState();
    super.initState();
  }

  late List<Map<String,dynamic>> initial = [{
    "index":"",
    "uname":"",
    "points":""
  }];

  // ignore: non_constant_identifier_names
  Future<List<Map<String,dynamic>>> get_details() async {
    // Make the HTTP request.
      final response = await http.get(
          Uri.parse("https://fastapi03-success-gowtham2004.vercel.app/leaderboard"),
          headers: {
            'Content-Type': 'application/json',
          }
      );

        var a = jsonDecode(response.body);
        var b = List<Map<String, dynamic>>.from(a.map((item) => item as Map<String, dynamic>));
        return b;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width.toInt();
    var height = media.height.toInt();




    // List<Map<String,dynamic>> studlb = [
    //   {"name":"Lion","points":"113441"},
    //   {"name":"Hermy","points":"327946"},
    //   {"name":"Dix","points":"280143"},
    //   {"name":"Inger","points":"25277"},
    //   {"name":"Tobit","points":"9850"},
    //   {"name":"Cristina","points":"119259"},
    //   {"name":"Berkly","points":"208571"},
    //   {"name":"Griselda","points":"108104"},
    //   {"name":"Feliks","points":"289561"},
    //   {"name":"Nye","points":"255922"}
    // ];

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
                            height: height.toDouble() - 20,
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
                                          child: Text("LEADERBOARD",
                                              style: TextStyle(
                                                  color: isDarkMode ? Colors.white : Colors.black,
                                                  fontSize: width < 419 ? 4.w : 2.w,
                                                  fontWeight: FontWeight.bold)),
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
                                            child: Text("LEAGUE",textAlign: TextAlign.center,style: TextStyle(color: isDarkMode ? Colors.white : Colors.black,fontSize: width < 419 ? 4.w : 2.w - 10)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: GlassTile(
                                                height:width < 419 ? 10.h : 20.h,
                                                width: width < 913 ? 80.w : 40.w,
                                                radius: 16,
                                                content:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset("assets/bronze.png",height: height > 480 ? 30.h : 40.h,width: width < 913 ? 20.w : 10.w),
                                                    //Icon(Icons.arrow_upward_rounded,color: Colors.green),
                                                    Image.asset("assets/silver.png",height: height > 480 ? 26.5.h : 37.h,width: width < 913 ? 16.5.w : 7.w),
                                                    Image.asset("assets/gold.png",height: height > 480 ? 26.5.h : 37.h,width: width < 913 ? 16.5.w : 7.w),
                                                    Image.asset("assets/emerald.png",height: height > 480 ? 26.5.h : 37.h,width: width < 913 ? 16.5.w : 7.w),
                                                  ],
                                                )
                                            ),
                                          ),
                              // Padding(
                              //   padding: EdgeInsets.all(8),
                              //   child: Text("WEEKLY STREAK",textAlign: TextAlign.center,style: TextStyle(fontSize: width < 419 ? 4.w : 2.w - 10)),
                              // ),
                              // Padding(
                              //   padding: EdgeInsets.all(8),
                              //   child: GlassTile(
                              //       height: width < 419 ? 10.h : 20.h,
                              //       width: width < 913 ? 80.w : 40.w,
                              //       radius: 16,
                              //       content:
                              //       Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //         crossAxisAlignment: CrossAxisAlignment.stretch,
                              //         children: [
                              //           Column(
                              //             children: [
                              //               Image.asset("assets/streak.png",height: height > 480 ? 30.h : 50.h,
                              //                 width: width < 414 ? 9.w : 5.w),
                              //               Padding(
                              //                 padding: const EdgeInsets.all(8.0),
                              //                 child: GlassTile(
                              //                     height: height > 480 ? 5.h : 5.h,
                              //                     width: width < 913 ? 10.w : 5.w,
                              //                     radius: 16,
                              //                     content: Center(child: Text("sun"))
                              //                 ),
                              //               ),
                              //             ],
                              //           )
                              //         ],
                              //       )
                              //   ),
                              // ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text("",textAlign: TextAlign.center,style: TextStyle(fontSize: width < 419 ? 4.w : 2.w - 10)),
                                          ),
                                          FutureBuilder(
                                            future: get_details(),
                                            initialData: initial,
                                            builder: (BuildContext context,AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return const Center(
                                                  child: CircularProgressIndicator(
                                                    color: Colors.deepPurpleAccent,
                                                  ),
                                                );
                                              }
                                              if (snapshot.connectionState == ConnectionState.done) {
                                                if (snapshot.hasError) {
                                                  return Center(
                                                    child: Text(
                                                      'An ${snapshot.error} occurred',
                                                      style: const TextStyle(fontSize: 18, color: Colors.red),
                                                    ),
                                                  );
                                                } else if (snapshot.hasData) {
                                                  final studlb = snapshot.data as List<Map<String,dynamic>>;
                                                  return Padding(
                                                    padding: const EdgeInsets.all(8),
                                                    child: GlassTile(
                                                        height: height > 480 ? 53.h : 83.h,
                                                        width: width < 913 ? 80.w : 40.w,
                                                        radius: 16,
                                                        content:
                                                        ListView.builder(
                                                          itemCount: studlb.length,
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
                                                                        studlb[index]["index"],
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
                                                                          studlb[index]["uname"],
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
                                                                            studlb[index]["points"],
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
                                                  );
                                                }
                                              }
                
                                              return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            },
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            )),
                      ),
                      CollapsingNavigationDrawer(currentSelectedIndex: 1),
                    ],
                  )),
            );
          }
        ));
  }
}
