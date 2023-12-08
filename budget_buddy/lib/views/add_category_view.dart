import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  String dropdownvalue = 'Income';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.lightTheme.colorScheme.background,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Categories'),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                onPressed: () {}, icon: Image.asset('assets/images/check.png'))
          ],
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppTheme.grey400,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(width: 1)),
                          padding: const EdgeInsets.all(10),
                          child: ImageIcon(
                            AssetImage('assets/images/restaurant.png'),
                            color: Colors.black,
                            size: 35,
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              labelText: 'Category name',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 100),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 2),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white
                        ),
                        child: DropdownButton(
                            items:const [
                              DropdownMenuItem(child: Text('Income'), value: 'Income'),
                              DropdownMenuItem(child: Text('Outcome'),value: 'Outcome')
                            ],
                            value: dropdownvalue,
                            onChanged: (value){
                            setState(() {
                              dropdownvalue = value!;
                            });
                            },
                          style: TextStyle(
                            color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Choose an icon for your category', style: TextStyle(
                    fontSize: 20
                  ),),
                ],
              )
            ),
            Container(
                child: Flexible(
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 6,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(18),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 1)),
                              padding: const EdgeInsets.all(7),
                              child: ImageIcon(
                                AssetImage('assets/images/restaurant.png'),
                                color: Colors.black,
                                size: 50,
                              ),
                            ),
                          );
                        }))
            ),
          ],
        )
    );
  }
}
