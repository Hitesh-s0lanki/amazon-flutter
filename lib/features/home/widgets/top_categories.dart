import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  void navigateToCategoryPage(BuildContext context,String category){
    Navigator.pushNamed(context, CategoryDealsScreen.routeName , arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 80,
          itemCount: GlobalVariable.categoryImages.length,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: () => navigateToCategoryPage(context, GlobalVariable.categoryImages[index]['title']!),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariable.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Text(
                    GlobalVariable.categoryImages[index]['title']!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
