platform :ios, '12'
inhibit_all_warnings!

$firebase_version = '~> 10.22.0'
#$baseURL = 'https://bitbucket.getnet.com.br/scm/sgm'

#$module_dskit = 'irineu/development'
#$module_dskit_path = ''
#
$module_core = ''
$module_core_path = '../github-core'
#
#$module_extract = '1.2.0'
#$module_extract_path = ''
#
#$module_flutter = '1.2.9'
#$module_flutter_path = ''

# ------------------------------------------------------
# Configuração dos Scripts Build Phase
# ------------------------------------------------------

def add_script_phase(name, script)
  script_phase :name => name, :script => script
end

# ------------------------------------------------------
# Definição de Função para Pods Comuns
# ------------------------------------------------------

def public_pods
  use_frameworks!

  pod 'Firebase/Analytics', $firebase_version
  pod 'Firebase/RemoteConfig', $firebase_version
  pod 'Firebase/Crashlytics', $firebase_version
  pod 'Firebase/Messaging', $firebase_version
  pod 'Firebase/Performance', $firebase_version

  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'RxGesture', '4.0.4'
  pod 'SwiftGen', '6.6.2'
  pod 'lottie-ios', '4.3.0'

  add_script_phase('SwiftGen', '"$PODS_ROOT/SwiftGen/bin/swiftgen"')
end

# ------------------------------------------------------
# Definição de Função para Pods Privados
# ------------------------------------------------------

def private_pods
  core_pods
end

def core_pods
  pod 'github-core', $module_core_path.empty? ? { :git => $baseURL+'/github-core.git', :branch => $module_core } : { :path => $module_core_path }
end

# ------------------------------------------------------
# Configuração dos Pods para o Target Principal
# ------------------------------------------------------

target 'GithubProjectiOS' do
  public_pods
  private_pods
  
  target 'GithubProjectiOSUITests' do
    inherit! :search_paths
  end
end

# ------------------------------------------------------
# Configuração Pós-Instalação
# ------------------------------------------------------

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

