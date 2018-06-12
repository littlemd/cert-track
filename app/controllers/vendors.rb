CertTrack::App.controllers :vendors do
  
  get :index do
    @vendors = Vendor.all
    render 'vendors/index'
  end

  get :show, :with => :id do
    @vendor = Vendor.get(params[:id])
    render 'vendors/show'
  end

end
