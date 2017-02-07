@version = "0.2.4"

Pod::Spec.new do |s|
  s.name                  = "Pencil"
  s.version               = @version
  s.summary               = "Super lightweight DB written in Swift."
  s.homepage              = "https://github.com/naru-jpn/pencil"
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { "naru" => "tus.naru@gmail.com" }
  s.source                = { :git => "https://github.com/naru-jpn/pencil.git", :tag => @version }
  s.source_files          = 'Sources/*.swift', 'Sources/Extensions/*.swift', 'Sources/Supports/*.swift'
  s.ios.deployment_target = '8.1'
end
