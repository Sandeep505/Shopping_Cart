import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


//colors used in this app

const Color white = Colors.white;
const Color black = Colors.black;
const Color green = Color.fromRGBO(22, 179, 13, 1);

//default app padding

const double appPadding = 20.0;
const kDefaultPaddin = 20.0;
Color WHITE = Colors.white;
const double COMMON_BORDER_RADIUS = 30;
Color SEARCH_GRAY_BACKGROUND = Color.fromRGBO(239, 239, 244, 1);
Color APPBAR_BACKGROUND = Color.fromRGBO(0, 120, 215, 1);


Decoration SEARCHBAR_BACKGROUND1() {
  return BoxDecoration(
    borderRadius: new BorderRadius.only(
        topLeft: Radius.circular(28.0),
        topRight: Radius.circular(28.0)),
    color: WHITE,

  );
}
Decoration SEARCHBAR_BACKGROUND2() {
  return BoxDecoration(
    borderRadius: new BorderRadius.all(Radius.circular(COMMON_BORDER_RADIUS)),
    color: WHITE,

  );
}
Decoration SEARCHBAR_BACKGROUND3() {
  return BoxDecoration(
      borderRadius: new BorderRadius.all(Radius.circular(COMMON_BORDER_RADIUS)),
      color: SEARCH_GRAY_BACKGROUND);

}

InputDecoration SearchUI(){
  return InputDecoration(
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      focusColor: APPBAR_BACKGROUND,
      hintText:  "Search Text",
      contentPadding: EdgeInsets.only(top: 7, bottom: 7),
      disabledBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal),
      prefixIcon: Icon(Icons.search),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(COMMON_BORDER_RADIUS))));
}

InputDecoration commonDropDownDecoration({contentPadding}) {
  return InputDecoration(
      contentPadding: contentPadding??EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)

      ),
      enabledBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(221, 221, 221, 1)),)
  );

}



