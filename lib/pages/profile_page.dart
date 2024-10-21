import 'package:qualia/common/common.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB1ogpLv.img?w=584&h=287&m=6'), // 示例图片
                ),
                SizedBox(height: 10.h),
                const Text(
                  '用户名',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 5),
                const Text('用户信息或简介',),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
