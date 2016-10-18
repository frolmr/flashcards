module CreateAction
  def create_new_item(item)
    item.user_id = current_user.id
    if item.save
      flash[:success] = "Новая #{item.class.name} добавлена"
      redirect_to action: "index"
    else
      flash.now[:danger] = "Что-то пошло не так!"
      render 'new'
    end
  end
end
