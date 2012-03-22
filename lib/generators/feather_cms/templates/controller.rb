class FeathersController < ApplicationController
  http_basic_authenticate_with :name => "feather", :password => "password"
  layout 'feather_layout'
  before_filter :find_page

  <% @pages.each do |page| %>
  def <%= page %>
    if request.put? or request.post?
      @feather_page.attributes = params[:feather_page]
      @feather_page.name = "<%= page %>"
      @feather_page.save
    end
  end
  <% end %>

  def find_page
    status = params[:feather_page] ? params[:feather_page][:status] : (params[:status] || 'draft')
    @feather_page = FeatherPage.where(:name => params[:action], :status => status)
    @feather_page = @feather_page.first || @feather_page.new
  end
end
