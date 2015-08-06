module Depp
  class ContactsController < ApplicationController
    before_action :init_epp_contact

    def index
      limit, offset = pagination_details

      res = depp_current_user.repp_request('contacts', { details: true, limit: limit, offset: offset })
      flash.now[:epp_results] = [{ 'code' => res.code, 'msg' => res.message }]
      @response = res.parsed_body.with_indifferent_access if res.code == '200'
      @contacts    = @response ? @response[:contacts] : []

      @paginatable_array = Kaminari.paginate_array(
        [], total_count: @response[:total_number_of_records]
      ).page(params[:page]).per(limit)
    end

    def new
      @contact = Depp::Contact.new
    end

    def show
      @contact = Depp::Contact.find_by_id(params[:id])
      if params[:com] == 'update' && @contact.complete_info?
        return redirect_to edit_contact_path(params[:id])
      end
    end

    def fullshow
      @contact = Depp::Contact.find_by_id(params[:id], params[:password])
      render 'show'
    end

    def edit
      @contact = Depp::Contact.find_by_id(params[:id])
    end

    def fulledit
      @contact = Depp::Contact.find_by_id(params[:id], params[:password])
      if @contact.persisted? && @contact.complete_info?
        render 'edit'
      else
        redirect_to :back, notice: I18n.t(:wrong_password)
      end
    end

    def create
      @contact = Depp::Contact.new(params[:depp_contact])

      if @contact.save
        redirect_to contact_url(@contact.id)
      else
        render 'new'
      end
    end

    def update
      @contact = Depp::Contact.new(params[:contact])

      if @contact.update_attributes(params[:contact])
        redirect_to contact_url(@contact.id)
      else
        render 'edit'
      end
    end

    def delete
      @contact = Depp::Contact.find_by_id(params[:id])
    end

    def destroy
      @contact = Depp::Contact.new(params[:contact])

      if @contact.delete
        redirect_to contacts_url, notice: t(:destroyed)
      else
        render 'delete'
      end
    end

    def info
      if params[:contact_id]
        if params[:com] == 'delete'
          redirect_to delete_contact_path(params[:contact_id], com: params[:com])
        else
          redirect_to contact_path(params[:contact_id], com: params[:com])
        end
      else
        render 'info_index'
      end
    end

    def check
      if params[:contacts].present?
        @ids = params[:contacts]
        # if @ids
          # @contacts = []
          # @ids.split(',').each do |id|
            # @contacts << id.strip
          # end
        # end
        return unless @ids

        @data = Depp::Contact.check(@ids)
        @contacts = Depp::Contact.construct_check_hash_from_data(@data)
      else
      end
    end

    private

    def init_epp_contact
      Depp::Contact.user = depp_current_user
    end
  end
end
