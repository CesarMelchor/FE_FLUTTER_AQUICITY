import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomCategorysHome extends StatefulWidget {
  const CustomCategorysHome({super.key});
  @override
  State<CustomCategorysHome> createState() => _CustomCategorysHomeState();
}

class _CustomCategorysHomeState extends State<CustomCategorysHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool responsive = false;
    if (size.width <= 844) {
      responsive = true;
    } else {
      responsive = false;
    }

    return responsive == true
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: Adaptive.w(5),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(Adaptive.w(0.5)),
                      decoration: Styles.categorysHome,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.room_service,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: Adaptive.w(0.5),
                          ),
                          Text(
                            "Restaurantes",
                            style: TextStyle(color: Variables.principal),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(Adaptive.w(0.5)),
                      decoration: Styles.categorysHome,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.restaurant_menu,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: Adaptive.w(0.5),
                          ),
                          Text(
                            "Comida",
                            style: TextStyle(color: Variables.principal),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(Adaptive.w(0.5)),
                      decoration: Styles.categorysHome,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_grocery_store,
                            color: Colors.pink,
                          ),
                          SizedBox(
                            width: Adaptive.w(0.5),
                          ),
                          Text(
                            "Compras",
                            style: TextStyle(color: Variables.principal),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Adaptive.w(10),
                  ),
                ],
              ),
              SizedBox(
                height: Adaptive.h(4),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: Adaptive.w(10),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(Adaptive.w(0.5)),
                      decoration: Styles.categorysHome,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_mall,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: Adaptive.w(0.5),
                          ),
                          Text(
                            "Belleza",
                            style: TextStyle(color: Variables.principal),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(Adaptive.w(0.5)),
                      decoration: Styles.categorysHome,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.king_bed,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: Adaptive.w(0.5),
                          ),
                          Text(
                            "Hoteles",
                            style: TextStyle(color: Variables.principal),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(Adaptive.w(0.5)),
                      decoration: Styles.categorysHome,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_bar,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: Adaptive.w(0.5),
                          ),
                          Text(
                            "Bebidas",
                            style: TextStyle(color: Variables.principal),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Adaptive.w(10),
                  ),
                ],
              )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: Adaptive.w(10),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(Adaptive.w(0.5)),
                  decoration: Styles.categorysHome,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.room_service,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: Adaptive.w(0.5),
                      ),
                      Text(
                        "Restaurantes",
                        style: TextStyle(color: Variables.principal),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(Adaptive.w(0.5)),
                  decoration: Styles.categorysHome,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.restaurant_menu,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: Adaptive.w(0.5),
                      ),
                      Text(
                        "Comida",
                        style: TextStyle(color: Variables.principal),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(Adaptive.w(0.5)),
                  decoration: Styles.categorysHome,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_grocery_store,
                        color: Colors.pink,
                      ),
                      SizedBox(
                        width: Adaptive.w(0.5),
                      ),
                      Text(
                        "Compras",
                        style: TextStyle(color: Variables.principal),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(Adaptive.w(0.5)),
                  decoration: Styles.categorysHome,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_mall,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: Adaptive.w(0.5),
                      ),
                      Text(
                        "Belleza",
                        style: TextStyle(color: Variables.principal),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(Adaptive.w(0.5)),
                  decoration: Styles.categorysHome,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.king_bed,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: Adaptive.w(0.5),
                      ),
                      Text(
                        "Hoteles",
                        style: TextStyle(color: Variables.principal),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(Adaptive.w(0.5)),
                  decoration: Styles.categorysHome,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_bar,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: Adaptive.w(0.5),
                      ),
                      Text(
                        "Bebidas",
                        style: TextStyle(color: Variables.principal),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Adaptive.w(10),
              ),
            ],
          );
  }
}
