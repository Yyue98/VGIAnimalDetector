# VGIAnimalDetector
安装流程：

1. 首先安装源代码依赖管理工具CocoaPods
    安装
    1:更新ruby环境 $ gem update rails ＝＝＝＝＝＝＝＝＝ Mac OS X 10.5以上
    2:更新gem环境 ： gem update –system
    3:安装cocoapods：sudo gem install cocoapods
    4:pod setup

2. 配置项目依赖 （podfile文件中）
    platform :ios , "12.0"

    target 'VGIAnimalDetector' do
    pod 'Reachability'
    pod 'AFNetworking', '~> 4.0.1'
    pod 'FontAwesomeKit'
    pod 'Masonry'
    pod 'ChameleonFramework'
    pod 'YYKit'
    pod 'WCDB'
    pod 'ReactiveObjC'
    pod 'QMUIKit', '~> 4.2.0'
    pod 'CYLTabBarController'
    pod 'DZNEmptyDataSet'
    pod 'OHHTTPStubs'
    pod 'WeChatSDK-iOS'
    pod 'AlipaySDK-iOS'
    pod 'IGListKit'
    pod 'LBXScan'
    pod 'CRBoxInputView'
    pod 'LEEAlert', '~> 1.4.2'
    pod 'LEETheme'
    pod 'ACStatusHUD'
    pod 'XMLReader'

    use_frameworks!
    pod 'Mapbox-iOS-SDK'
    pod 'MapboxChinaPlugin'

    end
    
3:pod install 安装
4:后续打开项目文件 （.workspace后缀的文件）
    在该项目中连接手机进行进行编译即可安装，因为APP还是测试阶段，没办法实现实时发布，故只有这个安装办法。
    
    如有其他问题，请联系我：yangy9803@163.com

