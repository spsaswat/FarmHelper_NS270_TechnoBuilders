import 'information.dart';
class InformationBrain{
  int _totalinfo = 2;
  int _currentinfo = 0;
  List<Information>_infoBank = [
    Information('Wheat', 'Ammonium Nitrate', 'Seed Sowing', 'summer',true, true, true,25),
    Information('Wheat2', 'Ammonium Nitrate', 'Seed Sowing','summer', true, true, true,25),
//    Information('Wheat3', 'Ammonium Nitrate', 'Seed Sowing','summer', true, true, true,25),
//    Information('Wheat4', 'Ammonium Nitrate', 'Seed Sowing','summer', true, true, true,25),
  ];
  String getCrop()
  {
    return _infoBank[_currentinfo].cropName;
  }
  String getfertilizer()
  {
    return _infoBank[_currentinfo].fertilizer;
  }
  String getSeason()
  {
    return _infoBank[_currentinfo].season;
  }
  bool getPest()
  {
    return _infoBank[_currentinfo].pesticide;
  }
  bool getManure()
  {
    return _infoBank[_currentinfo].manure;
  }
  bool getQuality()
  {
    return _infoBank[_currentinfo].quality;
  }
  double getArea()
  {
    return _infoBank[_currentinfo].area;
  }
  String getstatus()
  {

    String k =  _infoBank[_currentinfo++].status;
    if(_currentinfo == _totalinfo)
      _currentinfo = 0;
    return k;
  }
  int totaldet()
  {
    return _totalinfo;
  }
}