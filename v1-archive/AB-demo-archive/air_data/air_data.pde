/*
////////////////////////////////////////////////////////////////////////////////////////////////////////
 PULLING POLLUTION DATA VIA API
 from http://api.airvisual.com (free-- needs registered key)
 
 Returns the Air Quality Index (AQI) for NYC in real-time 
 
 What is AQI? doc: http://support.airvisual.com/knowledgebase/articles/1185775-what-is-aqi 
 API doc: https://api-docs.airvisual.com/#intro 
 
 ////////////////////////////////////////////////////////////////////////////////////////////////////////
 */



int aqi = 0; //tracks air quality index
String aqi_desc = "";


void setup() {
  size(100, 100);

  String key= "KwYLLNsmAx4de4gaS";  //AB's key
  // URL for pulling data 
  String url = "http://api.airvisual.com/v2/city?city=New%20York&state=New%20York&country=USA&key=" + key;


  // Load the JSON data
  JSONObject nyc_air = loadJSONObject(url); //load the entire Object
  JSONObject pollution = nyc_air.getJSONObject("data").getJSONObject("current").getJSONObject("pollution"); //get object within objects
  aqi = pollution.getInt("aqius"); //here's the aqi!


  //println (nyc_air);
  //println (pollution);
  //println (aqi);
  aqi_report();
  println ("The current Air Quality Index for New York City is " + aqi + " . . . " + "This means that the air quality is . . ." + aqi_desc);
}


void draw() {
}



void aqi_report() {
  if (aqi >= 0 && aqi <= 50) {
    aqi_desc= "good. . . Air quality is satisfactory and poses little or no health risk. . . Ventilating your home is recommended. . . Recommendations. . . Enjoy your usual outdoor activities. We recommend opening your windows and ventilating your home to bring in fresh, oxygen-rich air.";
  } else if (aqi >= 51 && aqi <= 100) {
    aqi_desc= "moderate. . . Air quality is acceptable and poses little health risk. . . Sensitive groups may experience mild adverse effects and should limit prolonged outdoor exposure. . . Recommendations Enjoy your usual outdoor activities. . . We recommend opening your windows and ventilating your home to bring in fresh, oxygen-rich air.";
  } else if (aqi >= 101 && aqi <= 150) {
    aqi_desc= "Unhealthy for Sensitive Groups. . . Air quality poses increased likelihood of respiratory symptoms in sensitive individuals while the general public might only feel slight irritation. . . Both groups should reduce their outdoor activity. . . Recommendations The general public should greatly reduce outdoor exertion. . . Sensitive groups should avoid all outdoor activity. . . Everyone should take care to wear a pollution mask.. . Ventilation is discouraged. . . Air purifiers should be turned on.";
  } else if (aqi >= 151 && aqi <= 200) {
    aqi_desc= "Unhealthy. . . Air quality is deemed unhealthy and may cause increased aggravation of the heart and lungs. . . Sensitive groups are at high risk to experience adverse health effects of air pollution. . . Recommendations . . . Outdoor exertion, particularly for sensitive groups, should be limited. . . Everyone should take care to wear a pollution mask. . . Ventilation is not recommended. . .  Air purifiers should be turned on if indoor air quality is unhealthy.";
  } else if (aqi >= 201 && aqi <= 300) {
    aqi_desc= "Very Unhealthy. . . Air quality is deemed unhealthy and may cause increased aggravation of the heart and lungs. . . Sensitive groups are at high risk to experience adverse health effects of air pollution. . .  Recommendations The general public should greatly reduce outdoor exertion. . . Sensitive groups should avoid all outdoor activity. . . Everyone should take care to wear a pollution mask. . . Ventilation is discouraged. . . Air purifiers should be turned on.";
  } else if (aqi >= 301 && aqi <= 500) {
    aqi_desc= "Hazardous. . . Air quality is deemed toxic and poses serious risk to the heart and lungs. . . Everyone should avoid all outdoor exertion. Recommendations. . . The general public should avoid outdoor exertion. Everyone should take care to wear a quality pollution mask. . . Ventilation is discouraged. . . Homes should be sealed and air purifiers turned on.";
  }
}




/*
 
 //sample data
 
 {
 "data": {
 "country": "USA",
 "current": {
 "weather": {
 "pr": 1011, //atmospheric pressure in hPa
 "ic": "10d", //weather icon code
 "tp": 19, //temperature in Celsius
 "ws": 1.55, //wind speed (m/s)
 "hu": 82, //humidity %
 "wd": 99, //wind direction, as an angle of 360° (N=0, E=90, S=180, W=270)
 "ts": "2019-05-04T19:00:00.000Z" //timestamp
 },
 "pollution": {
 "aqius": 54, //AQI value based on US EPA standard
 "maincn": "p2", //main pollutant for Chinese AQI
 "ts": "2019-05-04T16:00:00.000Z", //timestamp
 "mainus": "p2", //main pollutant for US AQI
 "aqicn": 19 //AQI value based on China MEP standard
 }
 },
 "city": "New York",
 "location": {
 "coordinates": [
 -73.928596,
 40.694401
 ],
 "type": "Point"
 },
 "state": "New York"
 },
 "status": "success"
 }
 */
