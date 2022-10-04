import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/utils/upload.dart';
import 'package:flutter_app/widgets/my_quill_editor.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPage extends StatefulWidget {
  final int articleId;
  final String title;
  final String coverUrl;
  final String content;
  EditPage({Key key, this.articleId, this.title, this.coverUrl, this.content})
      : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _titleController;
  QuillController _contentController;
  String _coverUrl;

  /// 内容编辑框的FocusNode
  final FocusNode _focusNode = FocusNode();

  /// true-新建 false-编辑
  bool isNew = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _coverUrl = widget.coverUrl;
    _contentController = QuillController.basic();
    if (widget.articleId == null) isNew = true;
    if (!isNew) {
      _requestDetail();
    }
  }

  /// 获取初始的文章详情
  Future<void> _requestDetail() async {
    final Map<String, dynamic> result =
        await HttpRequest.post('/getArticle', data: {'id': widget.articleId});
    if (result['code'] == 200) {
      setState(() {
        _titleController.text = result['data']['title'];
        _coverUrl = result['data']['coverPic'];
      });
      _loadContent(result['data']['content']);
    } else {
      print('load article detail error. msg:' + result['message'] ?? '');
    }
  }

  /// 将初始文本载入到编辑框中
  Future<void> _loadContent(String content) async {
    try {
      final doc = Document.fromJson(jsonDecode(content));
      setState(() {
        _contentController = QuillController(
            document: doc, selection: TextSelection.collapsed(offset: 0));
      });
    } catch (error) {
      print('load content error.');
    }
  }

  /// 提交
  void _onSubmit() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id') ?? '';
    final title = _titleController.text;
    final content = jsonEncode(_contentController.document.toDelta());
    if (title == null || title == '' || _coverUrl == null) {
      return;
    }

    Map<String, dynamic> data = {
      'id': widget.articleId,
      'title': title,
      'coverPic': _coverUrl,
      'content': content,
      'userId': userId,
    };
    Map<String, dynamic> result =
        await HttpRequest.post("/saveOrUpdateArticle", data: data);
    // if (result['code'] == 399) {
    //   // 验证token失败，重新登录
    //   MyNavigator.toLoginPage(context);
    // } else
    if (result['code'] == 200) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: Text(isNew ? '发布作品' : '编辑作品'),
        actions: [
          TextButton(
            onPressed: _onSubmit,
            child: Text('完成', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLines: 1,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              enabledBorder: null,
              disabledBorder: null,
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 8),
              hintText: "请输入标题",
              border: InputBorder.none,
            ),
          ),
          Divider(height: 1),
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('成品图片：'),
                Container(
                  width: 50,
                  height: 50,
                  child: InkWell(
                    child: _coverUrl == null
                        ? Icon(Icons.add_a_photo_outlined)
                        : Image.network(_coverUrl, fit: BoxFit.cover),
                    onTap: () async {
                      String url = await pickImage(ImageSource.gallery,
                          context: context);
                      if (url != null) {
                        setState(() {
                          _coverUrl = url;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          Expanded(
            child: MyQuillEditor(
              _contentController,
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              placeholder: '请输入内容',
              focusNode: _focusNode,
              scrollController: ScrollController(),
            ),
          ),
          QuillToolbar.basic(
            controller: _contentController,
            onImagePickCallback: uploadImageCallBack,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _contentController.dispose();
    _titleController.dispose();
  }
}
