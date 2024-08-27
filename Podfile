platform :ios, '12'
inhibit_all_warnings!

$baseURL = 'https://github.com/dev-uthman'

$module_core = '0.1.0'
$module_core_path = ''

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

  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'RxGesture', '4.0.4'
  pod 'SwiftGen', '6.6.2'

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

