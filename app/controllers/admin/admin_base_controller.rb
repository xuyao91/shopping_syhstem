class Admin::AdminBaseController < ApplicationController
  include AdminAuthenticatedSystem
  before_filter :login_required, :except => [:login, :signup]
  layout 'admin_default', :except => [:login, :signup]
end