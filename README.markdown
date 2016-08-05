#### 使用方法

1、添加gem 

```
  gem 'wechat_kit'
```

2、在initializers目录中创建wechat_kit.rb

```
WechatKit.setup(app_id, app_secret)
```

3、在视图中直接调用

```
wx.config(#{WechatKit.signature(request.original_url, ['onMenuShareTimeline', 'onMenuShareAppMessage'])});
  var shareJson = {
    title: '#{@title}', // 分享标题
    link: '#{request.original_url}', // 分享链接
    imgUrl: '#{@cover_url}', // 分享图标
    success: function () { 
      console.log('success')
    },
    cancel: function () { 
      console.log('cancel')
    }
  }
  wx.onMenuShareTimeline(shareJson);
  wx.onMenuShareAppMessage(shareJson);
```
