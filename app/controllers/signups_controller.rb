class SignupsController < ApplicationController
  before_filter :require_magic_key, :except => [ :show, :new, :create ]
  before_filter :require_magic_key_or_auth_token, :only => [ :show ]
  before_filter :require_noauth, :only => [ :new, :create ]

  # GET /signups
  # GET /signups.xml
  def index
    @signups = Signup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @signups }
      format.csv do
        fields = Signup.new.attributes.keys.sort - ["auth_token"]
        
        csv_string = FasterCSV.generate do |csv|
          # header row
          csv << fields

          # data rows
          @signups.each do |signup|
            z = []
            fields.each do |attr|
              val = eval "signup.#{attr}"
              z << val
            end
            csv << z
          end
        end
        #logger.info "CSV string = #{csv_string}"

        send_data csv_string,
            :type => 'text/csv; charset=iso-8859-1; header=present',
            :disposition => "attachment; filename=signups.csv"
      end
    end
  end

  # GET /signups/1
  # GET /signups/1.xml
  def show
    @signup = Signup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @signup }
    end
  end

  # GET /signups/new
  # GET /signups/new.xml
  def new
    @signup = Signup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @signup }
    end
  end

  # GET /signups/1/edit
  def edit
    @signup = Signup.find(params[:id])
  end

  # POST /signups
  # POST /signups.xml
  def create
    @signup = Signup.new(params[:signup])

    respond_to do |format|
      if @signup.save
        flash[:notice] = 'Signup was successfully created.'
        format.html { redirect_to("/signups/#{@signup.id}?auth_token=#{@signup.auth_token}") }
        format.xml  { render :xml => @signup, :status => :created, :location => @signup }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @signup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /signups/1
  # PUT /signups/1.xml
  def update
    @signup = Signup.find(params[:id])

    respond_to do |format|
      if @signup.update_attributes(params[:signup])
        flash[:notice] = 'Signup was successfully updated.'
        format.html { redirect_to(@signup) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @signup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /signups/1
  # DELETE /signups/1.xml
  def destroy
    @signup = Signup.find(params[:id])
    @signup.destroy

    respond_to do |format|
      format.html { redirect_to(signups_url) }
      format.xml  { head :ok }
    end
  end
  
private
  
end
