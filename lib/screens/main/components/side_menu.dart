import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        border: const Border(
          right: BorderSide(
            color: Colors.white24,
            width: 1.5,
          ),
        ),
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset("assets/images/logo.png"),
            ),
            const Divider(color: Colors.white24),
            _buildMenuItem(context, "Dashboard", "assets/icons/menu_dashboard.svg", 'Dashboard'),
            _buildMenuItem(context, "Category", "assets/icons/menu_tran.svg", 'Category'),
            _buildMenuItem(context, "Sub Category", "assets/icons/menu_task.svg", 'SubCategory'),
            _buildMenuItem(context, "Brands", "assets/icons/menu_doc.svg", 'Brands'),
            _buildMenuItem(context, "Variant Type", "assets/icons/menu_store.svg", 'VariantType'),
            _buildMenuItem(context, "Variants", "assets/icons/menu_notification.svg", 'Variants'),
            _buildMenuItem(context, "Orders", "assets/icons/menu_profile.svg", 'Order'),
            _buildMenuItem(context, "Coupons", "assets/icons/menu_setting.svg", 'Coupon'),
            _buildMenuItem(context, "Posters", "assets/icons/menu_doc.svg", 'Poster'),
            _buildMenuItem(context, "Notifications", "assets/icons/menu_notification.svg", 'Notifications'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String iconPath, String screenKey) {
    return DrawerListTile(
      title: title,
      svgSrc: iconPath,
      press: () {
        context.mainScreenProvider.navigateToScreen(screenKey);
      },
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        height: 20,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      hoverColor: Colors.blue.shade600,
    );
  }
}
