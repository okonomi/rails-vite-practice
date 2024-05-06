module ViteHelper
  def vite_client_tag
    return unless Rails.env.development?

    js = javascript_tag <<~JS, type: :module
      import RefreshRuntime from 'http://localhost:5173/@react-refresh'
      RefreshRuntime.injectIntoGlobalHook(window)
      window.$RefreshReg$ = () => {}
      window.$RefreshSig$ = () => (type) => type
      window.__vite_plugin_react_preamble_installed__ = true
    JS
    js += "\n"
    vite_client_url = "http://localhost:5173/@vite/client"
    js += javascript_include_tag(vite_client_url, type: :module)
    js
  end

  def vite_script_tag(entry)
    return unless Rails.env.development?

    vite_url = "http://localhost:5173/src/#{entry}.tsx"
    javascript_include_tag(vite_url, type: :module)
  end
end
