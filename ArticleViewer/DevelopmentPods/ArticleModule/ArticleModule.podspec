#
# Be sure to run `pod lib lint ArticleModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'ArticleModule'
    s.version          = '0.1.0'
    s.summary          = 'A short description of ArticleModule.'

    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC

    s.homepage         = 'https://github.com/himanshuingole/ArticleModule'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    #s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Himanshu Ingole' => 'srithimanshu@gmail.com' }
    s.source           = { :git => 'https://github.com/Himanshu Ingole/ArticleModule.git', :tag => s.version.to_s }

    s.ios.deployment_target = '10.3'

    s.source_files = "**/*.{swift}"
    s.dependency 'CommonModule'
    s.dependency 'ArticleModuleService'
    s.dependency 'Kingfisher', '~> 5.0'
    s.dependency 'IHProgressHUD'
    s.resources = "**/*.{xib,png,json,xcassets,storyboard}"
    s.resource_bundles = {
        'ArticleModule' => [
        'Pod/**/*.xib'
        ]
    }

end
