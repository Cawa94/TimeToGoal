# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

target 'YourGoal' do

  # Pods for YourGoal
  pod 'DeviceKit'
  pod 'Firebase/Analytics'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
    end
  end
end
