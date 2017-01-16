@version = "0.2.1"

Pod::Spec.new do |s|
  s.name                  = "pencil"
  s.version               = @version
  s.summary               = "Write value to file and read it more easily."
  s.homepage              = "https://github.com/naru-jpn/pencil"
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { "naru" => "tus.naru@gmail.com" }
  s.source                = { :git => "https://github.com/naru-jpn/pencil.git", :tag => @version }
  s.source_files          = 'Sources/*.swift', 'Sources/Extensions/*.swift', 'Sources/Supports/*.swift'
  s.ios.deployment_target = '10.0'
end
