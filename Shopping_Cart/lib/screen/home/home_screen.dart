import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/constants.dart';
import '../../models/fruits.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int presentationState = 0;
  List Datafruits = [];
  List<ModelFruits> modelfruits = [];
  List<ModelFruits> modelfruitsduplicate = [];
  String? productcategory;

  TextEditingController SearchController = new TextEditingController();
  bool SEARCH_CLOSE_VISIBLE = false;


  Savefruitsdata(Data) {
    try {
      print('try executed');
      Datafruits = Data;
      print('try catch executed');
    } on Exception catch (e) {
      print(e);
    }
  }

  getfreshfruits() async {
    modelfruits = [];
    setState(() {
      presentationState = 1;
    });
    Map<String, dynamic> Payload = new Map<String, dynamic>();

    var output = await rootBundle.loadString('json/product.json');
    if (output != null) {
      var jsonString = output;
      var outputResponse = json.decode(jsonString);
      await Savefruitsdata(outputResponse);
      buildfruitsCollection();
    } else {
      print("Server Error");
      return modelfruits;
    }
  }

  buildfruitsCollection() {
    modelfruits = Datafruits.map((dynamic model) {
      return ModelFruits.fromJson(model);
    }).toList();

    print("model Success");
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Json"),
      content: Text("${Datafruits.toString()}"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getfreshfruits();
    super.initState();
  }

  @override
  void dispose() {}

  Searchitem(){

    modelfruitsduplicate = Datafruits.map((dynamic model) {
      return ModelFruits.fromJson(model);
    }).toList();


    if (SearchController.text.trim() == "") {
      setState(() {
        modelfruits = modelfruitsduplicate;
      });
    }
    else {
      (modelfruitsduplicate).forEach((eachItem) {
        if (eachItem.p_name.toUpperCase().contains(SearchController.text.trim().toUpperCase()) ||
            eachItem.p_availability.toString().toUpperCase().contains(SearchController.text.trim().toUpperCase()) ||
            eachItem.p_description.toUpperCase().contains(SearchController.text.trim().toUpperCase()) ||
            eachItem.p_cost.toString().toUpperCase().contains(SearchController.text.trim().toUpperCase()) ||
            eachItem.p_id.toString().toUpperCase().contains(SearchController.text.trim().toUpperCase()) ||
            eachItem.p_details.toUpperCase().contains(SearchController.text.trim().toUpperCase())) {
          if (mounted) {
            setState(() {
              modelfruits.add(eachItem);
            });
          }
        }
      });

      if (mounted) {
        setState(() {
          SEARCH_CLOSE_VISIBLE = (SearchController.text.trim() != '') ? true : false;
        });
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(left: appPadding / 2),
          child: Icon(
            Icons.short_text_rounded,
            color: black,
            size: 30,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: appPadding),
            child: Icon(
              Icons.logout,
              color: black,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white60,
            child: Column(
              children: [
                Container(
                  decoration: SEARCHBAR_BACKGROUND1(),
                  child: Column(
                    children: [
                      Container(
                          height: 60,
                          decoration: SEARCHBAR_BACKGROUND2(),
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            padding: EdgeInsets.only(left: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * .85,
                                  height: 40,
                                  padding: EdgeInsets.all(0.0),
                                  decoration: SEARCHBAR_BACKGROUND3(),
                                  child: Stack(alignment: const Alignment(1.0, 1.0), children: <Widget>[
                                    new TextField(
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      decoration: SearchUI(),
                                      onChanged: (text) {
                                        if (mounted) {
                                          setState(() {
                                            if (SearchController.text.trim().length > 0) {
                                              SEARCH_CLOSE_VISIBLE = true;
                                              Searchitem();
                                            } else {
                                              SEARCH_CLOSE_VISIBLE = false;
                                              Searchitem();
                                            }
                                          });
                                        }
                                      },
                                      controller: SearchController,
                                    ),
                                    SEARCH_CLOSE_VISIBLE
                                        ? new IconButton(
                                        icon: new Icon(
                                          Icons.clear,
                                          color: APPBAR_BACKGROUND,
                                        ),
                                        onPressed: () {
                                          if (mounted) {
                                            setState(() {
                                              SearchController.clear();
                                              Searchitem();
                                              SEARCH_CLOSE_VISIBLE = false;
                                            });
                                          }
                                        })
                                        : new Container(
                                      height: 0.0,
                                    )
                                  ]),
                                ),


                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(appPadding),
            child: Text(
              'Daily Fresh',
              style: TextStyle(
                  fontSize: 24, letterSpacing: 1, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: size.height * 0.59,
            //color:Colors.red,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: modelfruits.length, //dailyFreshList.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: appPadding,
                        right: appPadding / 2,
                        bottom: appPadding,
                      ),
                      child: Container(
                        width: size.width * 0.90,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.2),
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(appPadding / 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                height: size.height * 0.23,
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  modelfruits[index].p_imageurl,
                                ),
                              ),
                              Text(
                                modelfruits[index].p_name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  FlatButton(
                                    color: Colors.white60,
                                    child: Text('-'),
                                    onPressed: () {
                                      setState(() {
                                        if(modelfruits[index].p_quantity > 1){
                                          modelfruits[index].p_quantity--;
                                        }
                                      });
                                    },
                                  ),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kDefaultPaddin / 2),
                                    child: Text(
                                      // if our item is less  then 10 then  it shows 01 02 like that
                                      modelfruits[index]
                                          .p_quantity
                                          .toString(),

                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  FlatButton(
                                    color: Colors.white60,
                                    child: Text('+'),
                                    onPressed: () {
                                      setState(() {
                                        if(modelfruits[index].p_availability !=0){
                                          modelfruits[index].p_quantity++;
                                        }
                                      });
                                    },
                                  ),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Container(
                                    child: Text(
                                      modelfruits[index].p_details,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      modelfruits[index].p_category,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),


                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                modelfruits[index].p_description,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${"\u20B9"} ${modelfruits[index].p_cost.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          //FreshFruits(),
        ],
      ),
      bottomNavigationBar: Container(
        child: TextButton(
          onPressed: () async {
            await showAlertDialog(context);
          },
          child: Text('Save'),
        ),
      ),
    );
  }
}
