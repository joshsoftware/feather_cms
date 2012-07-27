module FeatherCms
  class PagesController < ApplicationController

    if FeatherCms::Config.authentication.kind_of?(Hash)
      http_basic_authenticate_with FeatherCms::Config.authentication.merge(:except => :published)
    else
      before_filter FeatherCms::Config.authentication.to_sym, :except => :published
    end

    before_filter :find_page, :only => [:edit, :update, :destroy, :preview]
    before_filter :all_page, :except =>  [:preview, :published]

    layout 'feather_layout', :except => [:preview, :published]

    def index
    end

    def new
      @page = Page.new
      @page.status = 'draft'
    end

    def edit
      @draft_page = Page.where(:name => @page.name, :status => 'draft').first
      @published_page = Page.where(:name => @page.name, :status => 'published').first
    end

    def create
      @page = Page.new(params[:page])
      @page.name = @page.name.parameterize

      @page.status = 'draft'
      @page.template_type = 'html'

      if @page.save
        redirect_to pages_path
      else
        render :new
      end
    end

    def update
      status = params[:page].delete(:status)

      @page.attributes = params[:page]
      @page.name = @page.name.parameterize
      @page.status = status
      @page.template_type = 'html'

      if @page.save
        redirect_to pages_path
      else
        render :new
      end
    end

    def destroy
      @page.destroy
      redirect_to pages_path
    end

    def preview
      render :inline => @page.content.html_safe, :type => @page.template_type, :layout => @page.layout
    end

    def published
      @page = Page.where(:name => params[:name], :status => 'published').first 
      if @page
        render :inline => @page.content, :type => @page.template_type, :layout => @page.layout
      else
        redirect_to '/404.html'
      end
    end

    def find_page
      @page = Page.find(params[:id])
    end

    def all_page
      @pages = Page.order(:name)
    end

  end
end
