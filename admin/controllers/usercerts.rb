CertTrack::Admin.controllers :usercerts do
  get :index do
    @title = "Usercerts"
    @usercerts = Usercert.all
    render 'usercerts/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'usercert')
    @usercert = Usercert.new
    render 'usercerts/new'
  end

  post :create do
    @usercert = Usercert.new(params[:usercert])
    if @usercert.save
      @title = pat(:create_title, :model => "usercert #{@usercert.id}")
      flash[:success] = pat(:create_success, :model => 'Usercert')
      params[:save_and_continue] ? redirect(url(:usercerts, :index)) : redirect(url(:usercerts, :edit, :id => @usercert.id))
    else
      @title = pat(:create_title, :model => 'usercert')
      flash.now[:error] = pat(:create_error, :model => 'usercert')
      render 'usercerts/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "usercert #{params[:id]}")
    @usercert = Usercert.get(params[:id])
    if @usercert
      render 'usercerts/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'usercert', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "usercert #{params[:id]}")
    @usercert = Usercert.get(params[:id])
    if @usercert
      if @usercert.update(params[:usercert])
        flash[:success] = pat(:update_success, :model => 'Usercert', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:usercerts, :index)) :
          redirect(url(:usercerts, :edit, :id => @usercert.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'usercert')
        render 'usercerts/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'usercert', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Usercerts"
    usercert = Usercert.get(params[:id])
    if usercert
      if usercert.destroy
        flash[:success] = pat(:delete_success, :model => 'Usercert', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'usercert')
      end
      redirect url(:usercerts, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'usercert', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Usercerts"
    unless params[:usercert_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'usercert')
      redirect(url(:usercerts, :index))
    end
    ids = params[:usercert_ids].split(',').map(&:strip)
    usercerts = Usercert.all(:id => ids)
    
    if usercerts.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Usercerts', :ids => "#{ids.join(', ')}")
    end
    redirect url(:usercerts, :index)
  end
end
