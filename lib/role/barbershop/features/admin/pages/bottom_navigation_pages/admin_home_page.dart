import 'package:bar_brons_app/core/theme/app_colors.dart';
import 'package:bar_brons_app/role/barbershop/models/barber_shop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  String selectedCategory = "Barbershoplar";

  ThemeData get theme => Theme.of(context);
  Color? get textColor => theme.appBarTheme.foregroundColor;

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

  Widget _buildCategoryCard(String category, String title, String count) {
    final isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = category),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.yellow : theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: textColor ?? Colors.white, width: 2) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : textColor,
                fontSize: 20,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              count,
              style: TextStyle(
                color: isSelected ? Colors.white : textColor,
                fontSize: 20,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = getFilteredData();
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            "Admin",
            style: TextStyle(
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
                backgroundColor: const WidgetStatePropertyAll(AppColors.yellow),
              ),
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          children: [
            GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 180 / 103,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCategoryCard("Barbershoplar", "Barbershoplar", "234"),
                _buildCategoryCard("foydanaluvchilar", "Foydalanuvchilar", "40"),
                _buildCategoryCard("Statistika", "Statistika", "4.9"),
                _buildCategoryCard("Audit loglar", "Audit loglar", "234"),
              ],
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: filteredData.isEmpty
                    ? Center(
                        key: const ValueKey("Empty"),
                        child: Text(
                          selectedCategory == "Statistika"
                              ? "Statistika ma'lumotlari"
                              : selectedCategory == "Audit loglar"
                              ? "Audit loglar ma'lumotlari"
                              : "Malumotlar topilmadi",
                          style: TextStyle(
                            color: textColor?.withValues(alpha: 0.7),
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
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shop.name,
                                        style: TextStyle(
                                          color: textColor,
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
                                              color: textColor?.withValues(alpha: 0.7),
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          Text(
                                            "  |  ",
                                            style: TextStyle(
                                              color: textColor?.withValues(alpha: 0.7),
                                            ),
                                          ),
                                          Text(
                                            shop.address,
                                            style: TextStyle(
                                              color: textColor?.withValues(alpha: 0.7),
                                            ),
                                          ),
                                          Text(
                                            "  |  ",
                                            style: TextStyle(
                                              color: textColor?.withValues(alpha: 0.7),
                                            ),
                                          ),
                                          Text(
                                            shop.phone,
                                            style: TextStyle(
                                              color: textColor?.withValues(alpha: 0.7),
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
                                    color: theme.cardColor,
                                    surfaceTintColor: Colors.transparent,
                                    shadowColor: Colors.grey,
                                  ),
                                  child: PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: textColor,
                                    ),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: "edit",
                                        child: Text(
                                          "Tahrirlash",
                                          style: TextStyle(color: textColor),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: "blocked",
                                        child: Text(
                                          "Bloklash",
                                          style: TextStyle(color: textColor),
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
