class UsersMailer < ApplicationMailer
    default from: "testponygem@yandex.ru",
            template_path: "mailers"

    def reg_notification(user)
        @user = user
        mail to: @user.email,
             subject: "Congratulations! #{@user.name}'ve been registered recently!"
    end
    
    def upd_notification(user)
        @user = user
        mail to: @user.email,
             subject: "Your registration data was updated"
    end

end
