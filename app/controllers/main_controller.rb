class MainController < ApplicationController
    include MainConcern

    before_action :set_user, only: %i[ feed other_user ]
    before_action :authentication, only: %i[feed other_user  ]
    before_action :validate_new_post, only: %i[ create_new_post ]
    before_action :has_session, only: %i[ profile main edit_profile edit_profile_post favourite favourite_remove
    rate rate_post comment comment_post add_to_favorite cancelAppointment appointment appointment_post restaurant like
    edit_comment edit_comment_post edit_rate edit_rate_post]
    before_action :set_post, only: %i[  destroy_post ]


  def login
    session.delete(:user_id)
    if(!@user) 
      @user=User.new
    end
  end

  def login_post
    @email= params[:user][:email]
    @password= params[:user][:password]

    @user = User.find_by(email:@email)

    respond_to do |format|
      if @user && @user.authenticate(@password)
        session[:user_id] = @user.id
        format.html { redirect_to main_path, notice: "User was successfully login." }
        format.json { render json: @user }
      else
        session.delete(:user_id)
        format.html { redirect_to login_path,alert: "Your email or password is invalid." }
        format.json { render json: @user.errors,status: :unprocessable_entity}
      end
    end
 
  end

  def logout
    respond_to do |format|
      session[:user_id] = nil
      format.html { redirect_to login_path, notice: "User logout successfully." }
    
    end
  end

  def register
      @user=User.new
  end

  def register_create
      @user = User.new(user_params)    

      respond_to do |format|
        if @user.save
          format.html { redirect_to login_path, notice: "User was successfully created." }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :register , status: :unprocessable_entity  }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end

  def edit_profile

  end

  def edit_profile_post
    @display_name= params[:user][:display_name]

    if @user.display_name ==params[:user][:display_name]
      respond_to do |format|
        format.html { redirect_to main_path, alert: "The new display name can't be the same." }
      end
      return
    end

    if params[:user][:display_name]==''
      respond_to do |format|
        format.html { redirect_to main_path, alert: "The new display name can't be blank." }
      end
      return
    end

    if User.find_by(display_name:params[:user][:display_name])
            respond_to do |format|
        format.html { redirect_to main_path, alert: "The name "+ params[:user][:display_name] +" is already used." }
      end
      return
    end

    respond_to do |format|
      if @user.update(display_name:@display_name)
        format.html { redirect_to main_path, notice: "User was successfully updated name to "+@user.display_name+" ." }
      else
        format.html { redirect_to main_path , alert: "Something Wrong."  }
      end
    end
  end

  def favourite
  end

  def favourite_remove
    @restaurant=Restaurant.find(params[:restaurant_id])
    Favourite.find_by(user_id:@user.id,restaurant_id:params[:restaurant_id]).destroy
    respond_to do |format|
      format.html { redirect_to '/favourite', notice: "Remove "+@restaurant.restaurant_name+" from favourite list successfully." }
      format.json { head :no_content }
    end
  end

  def restaurant_list
    @restaurants=Restaurant.all()

  end

  def main

  end

  def restaurant
    @restaurant=Restaurant.find(params[:restaurant_id])
    @comment=Comment.find_by(user_id:@user.id,restaurant_id:params[:restaurant_id])
    @rate=Rate.find_by(user_id:@user.id,restaurant_id:params[:restaurant_id])
    @favourite=Favourite.find_by(user_id:@user.id,restaurant_id:params[:restaurant_id])
  end    

  def rate
    @rate=Rate.new(user_id:@user.id,restaurant_id:params[:restaurant_id])
  end

  def rate_post
    @rate=Rate.new(user_id:params[:rate][:user_id],restaurant_id:params[:rate][:restaurant_id],rate_score:params[:rate][:rate_score])
    if Integer(params[:rate][:user_id])!=@user.id
      respond_to do |format|
        format.html { redirect_to login_path , alert: "User token wasn't correct."  }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
        return
      end
    end

    respond_to do |format|
      if @rate.save
        format.html { redirect_to '/main', notice: "Rate to "+ @rate.restaurant.restaurant_name+" was successfully created." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { redirect_to '/main', alert: "Something Wrong."   }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_rate
    @rate=Rate.find_by(user_id:@user.id,restaurant_id:params[:restaurant_id])
  end

  def edit_rate_post
    @rate=Rate.find_by(user_id:@user.id,restaurant_id:params[:rate][:restaurant_id])

    respond_to do |format|
      if @rate.update(rate_score:params[:rate][:rate_score])
        format.html { redirect_to '/main', notice: "Rate was successfully updated." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { redirect_to '/main', alert: "Something Wrong."   }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def comment
    @comment=Comment.new(user_id:@user.id,restaurant_id:params[:restaurant_id])
  end

  def comment_post
    @comment=Comment.new(user_id:params[:comment][:user_id],restaurant_id:params[:comment][:restaurant_id],msg:params[:comment][:msg])
    if Integer(params[:comment][:user_id])!=@user.id
      respond_to do |format|
        format.html { redirect_to login_path , alert: "User token wasn't correct."  }
      
        return
      end
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to '/main', notice: "Comment to " + @comment.restaurant.restaurant_name + " was successfully created." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { redirect_to '/main', alert: "Something Wrong."   }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_comment
    @comment=Comment.find_by(user_id:@user.id,restaurant_id:params[:restaurant_id])
  end

  def edit_comment_post
    @comment=Comment.find_by(user_id:@user.id,restaurant_id:params[:comment][:restaurant_id])

      respond_to do |format|
      if @comment.update(msg:params[:comment][:msg])
        format.html { redirect_to '/main', notice: "Comment was successfully edited." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { redirect_to '/main', alert: "Something Wrong."   }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_to_favorite
    @favourite=Favourite.new(user_id:@user.id,restaurant_id:params[:restaurant_id])

    respond_to do |format|

      if @favourite.save
        format.html { redirect_to '/main', notice: "Restaurant was successfully added to favourite." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { redirect_to '/main', alert: "Something Wrong."   }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end

  end

  def cancelAppointment
    @appointment=Appointment.find(params[:appointment_id]).destroy
    @restaurant=@appointment.table.restaurant
    respond_to do |format|
      format.html { redirect_to '/main', notice: "Remove "+@restaurant.restaurant_name+' '+ @appointment.get_time.to_s+" from appointment list successfully." }
      format.json { head :no_content }
    end
  end

  def appointment
    @restaurant=Restaurant.find(params[:restaurant_id])
    @appointment_list=@restaurant.get_all_today_appointment_list()
    @appointment=Appointment.new(user_id:@user.id)
  end

  def appointment_post
    @table= Table.find_by(restaurant_id:params[:restaurant_id],table_number:params[:form][:table_number])
    @appointment=Appointment.new(date:Date.today,user_id:@user.id,table_id:@table.id,people_amount:(params[:appointment][:people_amount]),time_start:(params[:appointment][:time_start]))
    

    if Appointment.find_by(date:Date.today,table_id:@table.id,time_start:params[:appointment][:time_start])
      respond_to do |format|
        format.html { redirect_to '/appointment/'+@appointment.table.restaurant.id.to_s, alert: "The table " + @appointment.table.table_number.to_s+" is already reserved."   }
      end
      return 
    end

    if Integer(@appointment.people_amount) > Integer(@appointment.table.customer_capacity)
      respond_to do |format|
        format.html { redirect_to '/appointment/'+@appointment.table.restaurant.id.to_s, alert: "The capacity of table" + @appointment.table.table_number.to_s+" is not more than "+ @appointment.table.customer_capacity.to_s+""   }
      end
      return
    end

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to '/main', notice: "Appointment at " + @appointment.table.restaurant.restaurant_name + " was successfully created."}
      else
        format.html { redirect_to '/appointment/'+@appointment.table.restaurant.id.to_s, alert: "Something Wrong with appointment."   }
      end
    end
  end

  def like

    @like=Like.new(user_id:@user.id,comment_id:params[:comment_id])

    if params[:commit]=='Like'
      @like.like_type=true
    else
      @like.like_type=false
    end

    if Like.find_by(user_id:@user.id,comment_id:params[:comment_id])
      Like.find_by(user_id:@user.id,comment_id:params[:comment_id]).destroy
    end

    respond_to do |format|
      if @like.save
        if params[:commit]=='Like'
          format.html { redirect_to '/restaurant/'+@like.comment.restaurant.id.to_s, notice: 'Comment was like at was successfully created.' }
        else
          format.html { redirect_to '/restaurant/'+@like.comment.restaurant.id.to_s, notice: 'Comment was dislike at was successfully created.' }
        end
      else
        format.html { redirect_to '/restaurant/'+@like.comment.restaurant.id.to_s, alert: "Something Wrong with appointment."   }
      end
    end

  end



end
