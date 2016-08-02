$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "wechat_kit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "wechat_kit"
  s.version     = WechatKit::VERSION
  s.authors     = ["sharp"]
  s.email       = ["liuqiang_0701@163.com"]
  s.homepage    = "https://github.com/sharp/wechat_kit"
  s.summary     = "微信js_ssdk签名"
  s.description = "微信js_ssdk签名"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

end
