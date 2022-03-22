class ModelFruits{
   String p_name = "";
   int p_id = 0;
   int p_cost = 0;
   int p_availability = 0;
   String p_details = "";
   String p_category = "";
   int p_quantity = 0;
   String p_imageurl = "";
   String p_description = "";

   ModelFruits();

   factory ModelFruits.fromJson(Map<String, dynamic> json){
     ModelFruits fruits= new ModelFruits();
     fruits.p_name = json['p_name']??"";
     fruits.p_id = json['p_id']??0;
     fruits.p_cost = json['p_cost']??0;
     fruits.p_availability = json['p_availability']??0;
     fruits.p_details = json['p_details']??"";
     fruits.p_category = json['p_category']??"";
     fruits.p_quantity = json['p_quantity']??0;
     fruits.p_imageurl = json['p_imageurl']??0;
     fruits.p_description = json['p_description']??0;

      return fruits;
   }



}