CertTrack::Admin.controllers :certs do
  get :index do
    @title = "Certs"
    @certs = Cert.all
    render 'certs/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'cert')
    @cert = Cert.new
    render 'certs/new'
  end

  post :create do
    @cert = Cert.new(params[:cert])
    if @cert.save
      @title = pat(:create_title, :model => "cert #{@cert.id}")
      flash[:success] = pat(:create_success, :model => 'Cert')
      params[:save_and_continue] ? redirect(url(:certs, :index)) : redirect(url(:certs, :edit, :id => @cert.id))
    else
      @title = pat(:create_title, :model => 'cert')
      flash.now[:error] = pat(:create_error, :model => 'cert')
      render 'certs/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "cert #{params[:id]}")
    @cert = Cert.get(params[:id])
    if @cert
      render 'certs/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'cert', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "cert #{params[:id]}")
    @cert = Cert.get(params[:id])
    if @cert
      if @cert.update(params[:cert])
        flash[:success] = pat(:update_success, :model => 'Cert', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:certs, :index)) :
          redirect(url(:certs, :edit, :id => @cert.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'cert')
        render 'certs/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'cert', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Certs"
    cert = Cert.get(params[:id])
    if cert
      if cert.destroy
        flash[:success] = pat(:delete_success, :model => 'Cert', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'cert')
      end
      redirect url(:certs, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'cert', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Certs"
    unless params[:cert_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'cert')
      redirect(url(:certs, :index))
    end
    ids = params[:cert_ids].split(',').map(&:strip)
    certs = Cert.all(:id => ids)
    
    if certs.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Certs', :ids => "#{ids.join(', ')}")
    end
    redirect url(:certs, :index)
  end
end
