class Information{
  String cropName,fertilizer,status,season;
  double area;
  bool pesticide,manure,quality;

  Information(String s1,String s2,String s3,String s4,bool b1,bool b2,bool b3,double ar){
    cropName = s1;
    fertilizer = s2;
    status = s3;
    season = s4;
    pesticide = b1;
    manure = b2;
    quality = b3;
    area = ar;
  }


}