import 'package:bar_brons_app/core/theme/app_colors.dart';
import 'package:bar_brons_app/models/barber_shop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  String selectedCategory = "Barbershoplar";

  final List<BarberShop> allBarberShops = [
    BarberShop(
      name: "BarberShop Premium",
      hours: "09:00-18:00",
      address: "Manzil",
      phone: "+998918687100",
      category: "Barbershoplar",
    ),
    BarberShop(
      name: "BarberShop Premium",
      hours: "09:00-18:00",
      address: "Manzil",
      phone: "+998918687100",
      category: "Barbershoplar",
    ),
    BarberShop(
      name: "BarberShop Premium",
      hours: "09:00-18:00",
      address: "Manzil",
      phone: "+998918687100",
      category: "Barbershoplar",
    ),
    BarberShop(
      name: "BarberShop Premium",
      hours: "09:00-18:00",
      address: "Manzil",
      phone: "+998918687100",
      category: "Barbershoplar",
    ),
    BarberShop(
      name: "Classic Cuts",
      hours: "10:00-20:00",
      address: "Toshkent",
      phone: "+998901234567",
      category: "Barbershoplar",
    ),
    BarberShop(
      name: "Classic Cuts",
      hours: "10:00-20:00",
      address: "Toshkent",
      phone: "+998901234567",
      category: "Barbershoplar",
    ),
    BarberShop(
      name: "Alisher Valiyev",
      hours: "09:00-18:00",
      address: "Samarqand",
      phone: "+998905556677",
      category: "foydanaluvchilar",
    ),
    BarberShop(
      name: "Shaxzod Karimov",
      hours: "11:00-19:00",
      address: "Buxoro",
      phone: "+998907778899",
      category: "foydanaluvchilar",
    ),
    BarberShop(
      name: "Shaxzod Karimov",
      hours: "11:00-19:00",
      address: "Buxoro",
      phone: "+998907778899",
      category: "foydanaluvchilar",
    ),
    BarberShop(
      name: "Shaxzod Karimov",
      hours: "11:00-19:00",
      address: "Buxoro",
      phone: "+998907778899",
      category: "foydanaluvchilar",
    ),
    BarberShop(
      name: "Shaxzod Karimov",
      hours: "11:00-19:00",
      address: "Buxoro",
      phone: "+998907778899",
      category: "foydanaluvchilar",
    ),
    BarberShop(
      name: "Shaxzod Karimov",
      hours: "11:00-19:00",
      address: "Buxoro",
      phone: "+998907778899",
      category: "foydanaluvchilar",
    ),

  ];

  List<BarberShop> getFilteredData() {
    if (selectedCategory == "Statistika" ||
        selectedCategory == "Audit Loglar") {
      return [];
    }
    return allBarberShops
        .where((shop) => shop.category == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = getFilteredData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            "Admin",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: IconButton.outlined(
              color: Colors.white,
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(44.w, 44.h)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(AppColors.yellow),
              ),
              onPressed: () {},
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          children: [
            GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 180 / 103,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = "Barbershoplar";
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: selectedCategory == "Barbershoplar"
                          ? AppColors.yellow
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: selectedCategory == "Barbershoplar"
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Barbershoplar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: selectedCategory == "Barbershoplar"
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        Text(
                          "234",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: selectedCategory == "Barbershoplar"
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = "foydanaluvchilar";
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: selectedCategory == "foydanaluvchilar"
                          ? AppColors.yellow
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: selectedCategory == "foydanaluvchilar"
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Foydalanuvchilar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: selectedCategory == "foydanaluvchilar"
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        Text(
                          "40",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: selectedCategory == "foydanaluvchilar"
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = "Statistika";
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: selectedCategory == "Statistika"
                          ? AppColors.yellow
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: selectedCategory == "Statistika"
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Statistika",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: selectedCategory == "Statistika"
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        Text(
                          "4.9",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: selectedCategory == "Statistika"
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = "Audit loglar";
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: selectedCategory == "Audit loglar"
                          ? AppColors.yellow
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: selectedCategory == "Audit loglar"
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Audit loglar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: selectedCategory == "Audit loglar"
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        Text(
                          "234",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: selectedCategory == "Audit loglar"
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                child: filteredData.isEmpty
                    ? Center(
                        key: ValueKey("Empty"),
                        child: Text(
                          selectedCategory == "Statistika"
                              ? "Statistika ma'lumotlari"
                              : selectedCategory == "Audit loglar"
                              ? "Audit loglar ma'lumotlari"
                              : "Malumotlar topilmadi",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18.sp,
                          ),
                        ),
                      )
                    : ListView.builder(
                        key: ValueKey(selectedCategory),
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final shop = filteredData[index];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shop.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            shop.hours,
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          Text(
                                            "  |  ",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            shop.address,
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            "  |  ",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            shop.phone,
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuTheme(
                                  data: PopupMenuThemeData(
                                    color: AppColors.primary,
                                    surfaceTintColor: Colors.transparent,
                                    shadowColor: Colors.grey,
                                  ),
                                  child: PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: "edit",
                                        child: Text(
                                          "Tahrirlash",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: "blocked",
                                        child: Text(
                                          "bloclash",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                    onSelected: (value) {
                                      if (value == "edit") {
                                      } else if (value == "blocked") {}
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
