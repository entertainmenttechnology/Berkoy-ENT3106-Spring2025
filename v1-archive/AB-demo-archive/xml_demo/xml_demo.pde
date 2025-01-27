/*
//////////////////////////////////////////////////
XML Feed Example

Click mouse to print NYTimes story description to console.
//////////////////////////////////////////////////
*/

XML news;
XML[] descriptions;
int descriptionsIndex; 
String descNews; 


void setup() {
  news= loadXML("http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml");
  descriptions = news.getChildren("channel/item/description");
}


void draw() {
}


void mousePressed() {
  descNews= descriptions[descriptionsIndex].getContent();
  println(descNews);
  
  //advance array
  descriptionsIndex++;
  if (descriptionsIndex >= (descriptions.length-1)) {
    descriptionsIndex = 0;
  }
}
