import 'dart:convert';
import 'package:innohive/tools%20and%20templates/Preferences.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:innohive/tools%20and%20templates/theme.dart';
import '../tools and templates/Drawer/commons/collapsing_navigation_drawer_widget.dart';
import '../tools and templates/glass _morphism_tile.dart';
import 'package:http/http.dart' as http;

class Projects extends StatefulWidget {
  const Projects({super.key});
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {

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
    // TODO: implement initState
    super.initState();
  }

  late List<Map<String,dynamic>> initial = [{
    "studcode":"",
    "title":"Default",
    "abstract":"",
    "description":"",
    "gitlink":""
  }];

  void _showProjectPopup(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return const ProjectEntry();
    }
    );
  }

  Future<List<Map<String,dynamic>>> get_details() async {
    var studcode = await Myprefs.getPref("studcode");
    String studcodeString = studcode.toString();
    final response = await http.post(
        Uri.parse("https://fastapi03-success-gowtham2004.vercel.app/project"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "studcode": studcodeString
        })
    );
    try{
      var a = jsonDecode(response.body);
      var b = List<Map<String, dynamic>>.from(a.map((item) => item as Map<String, dynamic>));
      print(b);
      return b;
    }
    catch(e){
      return initial;
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width.toInt();
    var height = media.height.toInt();

    void showProjectDetailsPopup(BuildContext context,String title,abstract,description,gitlink){
      showDialog(context: context, builder: (BuildContext context){
        return ProjectDetails(title: title, abstract: abstract, description: description, gitlink: gitlink);
      }
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mytheme,
      home: Sizer(
        builder: (context, orientation, deviceType) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: isDarkMode ? AppGradients.secondaryGradient : AppGradients.primaryGradient, // Use the global gradient
                  ),
                ),
                Center(
                  child:
                  SizedBox(
                      height: height.toDouble() - 20,
                      width: width.toDouble() - 75,
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text("PROJECTS DONE",textAlign: TextAlign.center,style: TextStyle(color: isDarkMode ? Colors.white : Colors.black,fontSize: width < 419 ? 4.w : 2.w - 10)),
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
                                    final recprojects = snapshot.data as List<Map<String,dynamic>>;
                                    return Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: GlassTile(
                                          height: height > 480 ? 53.h : 83.h,
                                          width: width < 913 ? 80.w : 40.w,
                                          radius: 16,
                                          content:
                                          ListView.builder(
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
                                                    (index+1).toString(),
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
                                                      recprojects[index]["title"],
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
                                                        "+""150",
                                                        style: TextStyle(
                                                          color: isDarkMode ? Colors.white : Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: width < 419 ? 3.w : 1.w,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                        FloatingActionButton(
                                                          backgroundColor: Colors.transparent,
                                                          hoverColor: Colors.black12,
                                                          hoverElevation: 0,
                                                          elevation: 0,
                                                          onPressed: (){
                                                            showProjectDetailsPopup(context,recprojects[index]["title"] ,recprojects[index]["abstract"],recprojects[index]["description"],recprojects[index]["gitlink"]);
                                                          },
                                                          child: Icon(Icons.open_in_new_outlined,color: isDarkMode ? Colors.white : Colors.black),
                                                        )
                                              ]
                                                  )
                                              )
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
                        ),
                      )
                  ),
          
                ),
                CollapsingNavigationDrawer(currentSelectedIndex: 5),
              ],
            ),
            floatingActionButton: SizedBox(
              width: 150,
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  _showProjectPopup(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("upload",style: TextStyle(fontSize: 20,color: Colors.white)),
                    Icon(Icons.upload,color: Colors.green,)
                  ]
          
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class ProjectEntry extends StatelessWidget {
  const ProjectEntry({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width.toInt();

    TextEditingController title = TextEditingController();
    TextEditingController abstract = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController gitlink = TextEditingController();


    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
        ),
        title: const Text('Add Projects'),
        content: SingleChildScrollView(
            child: ListBody(
                  children: <Widget>[
                    // Container(
                    //   height: 100,
                    //   width: 100,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     image: DecorationImage(
                    //       fit: BoxFit.contain,
                    //       image: AssetImage("assets/icon.png",),
                    //     ),
                    //   ),
                    // ),
                    Text("Title:",style: TextStyle(fontSize: width > 480 ? 1.5.w : 3.5.w)),
                    TextField(
                      controller: title,
                      decoration: const InputDecoration(
                        hintText: "Enter your Project title here"
                      ),
                    ),
                    const Divider(color: Colors.transparent),
                    Text("Abstract:",style: TextStyle(fontSize: width > 480 ? 1.5.w : 3.5.w)),
                    TextField(
                      controller: abstract,
                      keyboardType: TextInputType.multiline,
                      maxLength: 500,
                      minLines: 1,//Normal textInputField will be displayed
                      maxLines: 5,
                      decoration: const InputDecoration(
                          hintText: "Enter your Project Abstract here"
                      ),
                    ),
                    Text("Detailed Description:",style: TextStyle(fontSize: width > 480 ? 1.5.w : 3.5.w)),
                    TextField(
                      controller: description,
                      keyboardType: TextInputType.multiline,
                      maxLength: 50000,
                      minLines: 1,//Normal textInputField will be displayed
                      maxLines: 5,
                      decoration: const InputDecoration(
                          hintText: "Enter Detailed view about project"
                      ),// when user presses enter it will adapt to it
                    ),
                    Text("GitHub repository link:",style: TextStyle(fontSize: width > 480 ? 1.5.w : 3.5.w)),
                    TextField(
                      controller: gitlink,
                      decoration: const InputDecoration(
                          hintText: "Enter GitHub repository link"
                      ),// when user presses enter it will adapt to it
                    ),
                    const Divider(color: Colors.transparent),
                    FloatingActionButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          onPressed: () async{
                            if (title.text.isNotEmpty && abstract.text.isNotEmpty && description.text.isNotEmpty && gitlink.text.isNotEmpty) {
                              var studcode = await Myprefs.getPref("studcode");
                              String studcodeString = studcode.toString();
                              print("get value:{$studcodeString}");
                              postProject(title.text, abstract.text, description.text, gitlink.text, studcodeString, context);
                            }
                            else {
                              QuickAlert.show(context: context, type: QuickAlertType.warning, text: "Hey fill all the fields");
                            }
                          },
                            child:const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("UPLOAD"),
                                Icon(Icons.upload)
                              ],
                            )
                    ),
                  ]
              ),
          ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
    );
  }
}

Future<void> postProject(String title,String abstract,String description,String gitlink,String studcode,BuildContext context) async {
  try{
    final response = await http.post(
      Uri.parse("https://fastapi03-success-gowtham2004.vercel.app/postProject"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "studcode": studcode,
        "title": title,
        "abstract": abstract,
        "description": description,
        "gitlink" : gitlink,
      }),
    );
    if(response.statusCode == 200){
      var data = response.body;
      Map<String, dynamic> project = json.decode(data);
      print(project["message"]);
      if(project["status"] == "success"){
        Navigator.of(context).pop();
        QuickAlert.show(context: context, type: QuickAlertType.success,
        title: project["message"],text: "Refresh Page");
      }
      else {
        Navigator.of(context).pop();
        QuickAlert.show(context: context, type: QuickAlertType.warning, title: project["message"],text: "Try Again");
      }
    }
  }
  catch(e) {
    print(e);
  }
}

class ProjectDetails extends StatefulWidget {
  final title;
  final abstract;
  final description;
  final gitlink;

  const ProjectDetails({super.key,required this.title,required this.abstract,required this.description,required this.gitlink});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
      ),
      title: const Text('ProjectDetails'),
      content: SingleChildScrollView(
        child: ListBody(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.support),
              ),
              Text(widget.title),
              Text(widget.abstract),
              Text(widget.description),
              Text(widget.gitlink),
              const Divider(),

            ]
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}