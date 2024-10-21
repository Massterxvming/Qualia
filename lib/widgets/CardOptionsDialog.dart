import 'package:flutter/material.dart';

class CardOptionsDialog extends StatelessWidget {
  const CardOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Dialog的圆角
      elevation: 6,
      child: Container(
        width: 280, // 对话框的最大宽度调整为100
        padding: const EdgeInsets.fromLTRB(10,8,10,8), // 对话框内边距
        child: Column(
          mainAxisSize: MainAxisSize.min, // 对话框内容尽可能小
          crossAxisAlignment: CrossAxisAlignment.start, // 内容左对齐
          children: <Widget>[
            _OptionTile(icon: Icons.thumb_up_alt, text: '点赞'),
            const Divider(height: 1, thickness: 0.2,  indent: 16, endIndent: 16), // 分割线
            _OptionTile(icon: Icons.star, text: '收藏'),
            const Divider(height: 1, thickness: 0.2,  indent: 16, endIndent: 16), // 分割线
            _OptionTile(icon: Icons.share, text: '分享'),
            const Divider(height: 1, thickness: 0.2,  indent: 16, endIndent: 16), // 分割线
            _OptionTile(icon: Icons.visibility_off_outlined, text: '不想看'),
            const Divider(height: 1, thickness: 0.2,  indent: 16, endIndent: 16), // 分割线
            _OptionTile(icon: Icons.flag, text: '举报'),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context); // 点击后的操作
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10000), // InkWell的圆角
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 修改为spaceBetween以支持左对齐和右对齐
          children: <Widget>[
            Text(text,), // 使用主题颜色
            Spacer(), // 添加Spacer组件
            Icon(icon, size: 24, color: Theme.of(context).colorScheme.secondary.withOpacity(1)), // 使用主题颜色
          ],
        ),
      ),
    );
  }
}

