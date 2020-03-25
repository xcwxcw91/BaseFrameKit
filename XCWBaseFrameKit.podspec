

Pod::Spec.new do |spec|

  spec.name         = "XCWBaseFrameKit"
  spec.version      = "0.0.1"
  spec.summary      = "easy way to deal with TableView/CollectionView"
  spec.description  = "XcwBaseKit"
  spec.homepage     = "https://github.com/xcwxcw91/BaseFrameKit"
  spec.license      = "MIT"
  spec.author       = { "chunwei.xu" => "739558706@qq.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "git@github.com:xcwxcw91/BaseFrameKit.git", :tag => spec.version }
  
  spec.source_files = 'XCWBaseFrameKit/**/*'
  spec.requires_arc = true

  spec.dependency 'Masonry'
  spec.dependency 'MJRefresh'

end
