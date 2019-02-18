#
# Be sure to run `pod lib lint NetworkService.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NetworkService'
  s.version          = '0.1.0'
  s.summary          = 'A short description of NetworkService.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/himanshuingole/NetworkService'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  #s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Himanshu Ingole' => 'srithimanshu@gmail.com' }
  s.source           = { :git => 'https://github.com/Himanshu Ingole/NetworkService.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.3'

  s.source_files = "**/*.{swift}"
  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON', '~> 4.0'
  s.dependency 'CommonModule'
#   s.resource_bundles = {
#     'NetworkService' => ['NetworkService/Classes/*.xib']
#   }


s.resources = "**/*.{xib,png,json,xcassets}"
s.resource_bundles = {
    'NetworkService' => [
    'Pod/**/*.xib'
    ]
}

end
