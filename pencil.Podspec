@version = "0.0.6"

Pod::Spec.new do |s|
  s.name                  = "Pencil"
  s.version               = @version
  s.summary               = "Write value to file and read it more easily."
  s.homepage              = "https://github.com/naru-jpn/pencil"
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { "naru" => "tus.naru@gmail.com" }
  s.source                = { :git => "https://github.com/naru-jpn/pencil.git", :tag => @version }
  s.source_files          = 'Sources/*.swift'
  s.ios.deployment_target = '10.0'
end
