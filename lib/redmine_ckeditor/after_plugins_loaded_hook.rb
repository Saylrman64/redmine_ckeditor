module RedmineCkeditor
  class AfterPluginsLoadedHook < Redmine::Hook::Listener
    def after_plugins_loaded(context = {})
      RedmineCkeditor.apply_patch
    end
  end
end