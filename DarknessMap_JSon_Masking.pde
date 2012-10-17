import org.json.*;

ArrayList darknessLines;
ArrayList values;
PGraphics pg;
String baseURL="http://178.79.145.84:8080/api/darkness";


void setup() {
  size(1200, 800, P2D);
  //present mode - set background color to black
  frame.setBackground(new java.awt.Color(0, 0, 0));
  background(0);
  int pgW = int(400);
  int pgH = int(600);

  pg = createGraphics(pgW, pgH, P2D);

  darknessLines = new ArrayList();
  values = new ArrayList();
  //String data[] = loadStrings(filename);
  //darknessVals = new float [data.length-1];

  //getJsonData(); 
  getData(); 
  smooth();


  for (int i = values.size()-1 ; i > 0; i--) {
    float strkd = (Float)(values.get(i));
    darknessLines.add(new DataLine(strkd, i, pg));
    println(i);
  }

//  pg.beginDraw();
  for (int i = darknessLines.size()-1; i > 0; i--) {
    DataLine d = (DataLine) darknessLines.get(i);
    //d.render();
  }
//  pg.endDraw();
//  imageMode(CENTER);
//  image(pg, width, height);
}

void draw() {
  //getData();
  /*
  for(int i = 0; i < values.size(); i++) {
   float strkd = (Float)(values.get(i));
   darknessLines.add(new DataLine(strkd, width));
   }
   */
  translate(400,100); 
  pg.beginDraw();
  for (int i = darknessLines.size()-1; i > 0; i--) {
    DataLine d = (DataLine) darknessLines.get(i);
    d.render();
    d.update();  

    //    if (d.x1 <= 0) {
    //      darknessLines.remove(0);
    //    }
    if (darknessLines.size() > pg.width) {
      darknessLines.remove(0);
    }
    println("DarknessLines Size: " + darknessLines.size());
  }
  pg.endDraw();
  //imageMode(CENTER);
  //image(pg, width, height);
  image(pg, 0,0);
}

void getJsonData() {
  String request = baseURL + "?query=payload";
  println("Sending query to Darkness Map API");
  String result = join(loadStrings(request), "");
  println( result );

  try {
    JSONObject payload = new JSONObject(result);
    JSONArray responses = payload.getJSONArray("payload");
    println(responses);
    for (int i = 0; i < responses.length(); i++) {
      JSONObject obj = (JSONObject) responses.get(i);
    }
  } 
  catch(JSONException e) {
    println("There was an error parsing the JSON Object.");
  }
}

void getData() {
  String request = baseURL + "?query=payload";
  String result = join(loadStrings(request), "");
  //println(result);

  try {
    JSONArray darknessAPI = new JSONArray(join(loadStrings(request), ""));
    for (int i = 0; i < darknessAPI.length(); i++) {
      JSONObject obj = (JSONObject) darknessAPI.get(i);
      int tempPayload = (int)(obj.getLong("payload"));
      //println(obj.getString("payload"));
      println(tempPayload);
      //values.add(new PVector(tempPayload, 0 , 0));
      values.add(new Float(tempPayload));
    }
    println("Values Size: "+ values.size());
  }
  catch(JSONException e) {
    println(e);
  }
}
