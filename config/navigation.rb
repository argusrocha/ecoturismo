# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Use Bootstrap renderer provided by the
  # simple-navigation-bootstrap gem
  #navigation.renderer = SimpleNavigation::Renderer::Bootstrap

  # Specify the class that will be applied to active navigation items.
  # Defaults to 'selected' navigation.selected_class = 'your_selected_class'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  # navigation.active_leaf_class = 'your_active_leaf_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that
  # will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name, item| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # If this option is set to true, all item names will be considered as safe (passed through html_safe). Defaults to false.
  # navigation.consider_item_names_as_safe = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>if: -> { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>unless: -> { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI.  You may also use a proc, or the symbol <tt>:subpath</tt>.
    #

    # Account menu
    primary.item :account, 'Conta', icon: 'glyphicon glyphicon-user' do |sub|
      sub.item :login, 'Login', new_user_session_path, icon: 'glyphicon glyphicon-log-in', :unless => lambda { user_signed_in? }
      sub.item :logout, 'Logout', destroy_user_session_path, icon: 'glyphicon glyphicon-log-out', :if => lambda { user_signed_in? }
      sub.item :my_data, 'Meus dados', edit_user_registration_path, icon: 'fa fa-suitcase', :if => lambda { user_signed_in? }
    end

    # User menu
    primary.item :users, 'Usuarios', icon: 'fa fa-users', :if => lambda { user_signed_in? } do |sub|
      sub.item :index, 'Listar', admin_users_path, icon: 'glyphicon glyphicon-th-list'
      sub.item :create, 'Cadastrar', new_admin_user_path, icon: 'fa fa-user-plus', :if => lambda { can? :create, User }
    end

    # Transactions menu
    primary.item :transactions, 'Transações', icon: 'fa fa-cc-visa', :if => lambda { user_signed_in? && current_user.admin? } do |sub|
      sub.item :index, 'Listar', admin_transactions_path, icon: 'glyphicon glyphicon-th-list'
      sub.item :creare, 'Cadastrar', new_admin_transaction_path, icon: 'fa fa-credit-card'
    end

    # Trips menu
    primary.item :trips, 'Viagens', icon: 'fa fa-bus', :if => lambda { user_signed_in? && current_user.admin? } do |sub|
      sub.item :index, 'Listar', admin_trips_path, icon: 'glyphicon glyphicon-th-list'
      sub.item :create, 'Cadastrar', new_admin_trip_path, icon: 'fa fa-road'
    end

    # Reports menu
    primary.item :reports, 'Relatórios', :if => lambda { user_signed_in? && current_user.admin? } do |sub|
      sub.item :index, 'Viagens', admin_reports_trips_report_path
    end

    primary.dom_id = 'menu-root'
    primary.dom_class = 'nav navbar-nav'
  end
end
