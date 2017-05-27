platform :ios, '9.0'
use_frameworks!

def install_pods
  pod ’STV-Extensions’, ‘0.1.9’
  pod ‘RealmSwift’, '2.7.0' , :inhibit_warnings => true
  pod 'R.swift', '3.2.0'
end

target 'skillup_test_6' do
  install_pods

  target 'skillup_test_6Tests' do
    install_pods
    inherit! :search_paths
  end

end
