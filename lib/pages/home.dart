import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/models/slider_model.dart';
import 'package:newsapp/services/data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:newsapp/services/news.dart' show News;
import 'package:newsapp/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:http/http.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
List<CategoryModel> categories = [];
List<SliderModel> sliders=[];
List<ArticleModel> articles = [];
bool _loading= true;

int activeIndex=0;
@override
  void initState() {
    categories = getCategories();
    sliders = getSliders();
    getNews();
    super.initState();
  }
getNews() async{
  News newsclass = News();
  await newsclass.getNews();
  articles = newsclass.news;
  setState(() {
    _loading=false;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text("News",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold
              ),)
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.0),
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index){
                  return catetoryTile(
                    image: categories[index].image,
                    categoryName: categories[index].categoryName,
                  );
                }),
                
            ),
          
          SizedBox(height: 30,),
          Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Breaking News!",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          ),),
        
                          Text("view all",
                          
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          
                          ),),
                      ],
                    ),
                  ),
               SizedBox(
              height: 20.0,
              ),
              CarouselSlider.builder(
              itemCount: sliders.length,
              itemBuilder: (context, index, realindex){
              String? res= sliders[index].image;;
              String? res1 = sliders[index].name;
              return buildImage(res!, index, res1!);
            }, options: CarouselOptions(
              height: 250,
              viewportFraction: 1.0,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason){
                setState(() {
                  activeIndex = index;
                });
                SizedBox(height: 30,);
                buildIndicator();
              }
        
        
            )),
          SizedBox(
            height: 30,
          ),
          Center(child: buildIndicator()),
          SizedBox(height: 30,),
          Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Trending News!",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          ),),
        
                          Text("view all",
                          
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          
                          ),),
                      ],
                    ),
                  ),
                  
                  
                  SizedBox(height: 20.0,),
                  GestureDetector(
                    onTap: (){
                      
                    },
                    
                  child:  Padding(
                    
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                            child:   ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                 imageUrl: 'imageUrl',
                               height: 120,
                               width: 120,
                               fit: BoxFit.cover,
                               ),
                            ),
                            ),
                            SizedBox(width: 5.0,),
                             Column(
                               children: [
                                 Container(
                                  width: MediaQuery.of(context).size.width/1.7,
                                   child: Text("Rui paulinho outsprints breakaway to win stage 15",
                                                         style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17.0,
                                    
                                    ),),
                                 ),
                                 SizedBox(height: 7.0,),
                                    Container(
                                  width: MediaQuery.of(context).size.width/1.6,
                                   child: Text("Then a final kick to beat lennard kamna",
                                                         style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17.0,
                                    
                                    ),),
                                 ),
                               ],
                             ),

                              
                          ],
                        ),
                      ),

                    
                    ),
                    
                  ),


                

            ),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (context, index){
                  return BlogTile(
                    desc: articles[index].description!,
                    imageUrl: articles[index].urlToImage!,
                    title: articles[index].title!,
                  );
                }),
            )
          ],
         )
        ),
      ),
    );
  }
  Widget buildImage(
    String image,
    int index,
    String name)=> Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        children: [

        
    ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
          image,
          fit: BoxFit.cover,
          height: 250,
          width: MediaQuery.of(context).size.width,)
          ),
          Container(
            height: 250,
            padding: EdgeInsets.only(left: 1.0),
            margin: EdgeInsets.only(top: 100.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)
          
            ),
            
              ),
              child: Text(
                name,
                style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
                ),),
          )
        ]
        
      ),
      
    );
    Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: sliders.length,
      effect: SlideEffect(
        dotWidth: 15,
        dotHeight: 15,
        activeDotColor: Colors.blue),
      );
}
class catetoryTile extends StatelessWidget {
  final image, categoryName;
  const catetoryTile({super.key, this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              image,
              width: 120,
              height: 70,
              fit: BoxFit.cover,
              ),
          ),
          Container(
            width: 120,
            height: 70,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.black38,
            ),
            
            child: Center(
              child: Text(categoryName,
              style: TextStyle(
                color: Colors.white,
                 fontSize: 15,
                 fontWeight: FontWeight.bold
                 ),),
            ),
          )
        ],
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
 String imageUrl, title, desc;
 BlogTile({required this.imageUrl, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                    onTap: (){
                      
                    },
                    
                  child:  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Padding(
                      
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                              child:   ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(imageUrl,
                                 height: 150,
                                 width: 150,
                                 fit: BoxFit.cover,),
                              ),
                              ),
                              SizedBox(width: 5.0,),
                               Column(
                                 children: [
                                   Container(
                                    width: MediaQuery.of(context).size.width/1.7,
                                     child: Text(title,
                                      maxLines: 2,
                                      style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.0,
                                      
                                      ),),
                                   ),
                                   SizedBox(height: 7.0,),
                                      Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                     child: Text(desc,
                                                           style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.0,
                                      
                                      ),),
                                   ),
                                 ],
                               ),
                    
                                
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  );
  }
}