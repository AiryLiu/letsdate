# Uncomment this line to define a global platform for your project
# platform :ios, '6.0'

inhibit_all_warnings!

pod 'AFNetworking', '~> 2.5.3'
pod 'MBProgressHUD', '~> 0.9.1'
pod 'UMengSocial', '~> 4.2.2'
pod 'UMengAnalytics', '~> 3.4.6'
pod 'SDWebImage', '~> 3.7.2'
pod 'UIViewController+KeyboardAnimation', '~> 1.2'

post_install do |installer|
    installer.project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ARCHS'] = "$(ARCHS_STANDARD_INCLUDING_64_BIT)"
        end
    end
end
