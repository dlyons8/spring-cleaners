class MessagesController < ApplicationController
    before_action :require_login
    before_action :find_conversation

    def index
        @messages = @conversation.messages
        if @messages.length > 10
            @over_ten = true
            @messages = @messages[-10..-1]
        end
        if params[:m]
            @over_ten = false
            @messages = @conversation.messages
        end
        if @messages.last
            if @messages.last.user_id != current_user.id
                @messages.last.read = true
                @messages.last.save
            end
        end
        @message = @conversation.messages.new
    end

    def new
        @message = @conversation.messages.new
    end
    
    def create
        @message = @conversation.messages.new(message_params)
        if @message.save
            redirect_to conversation_messages_path(@conversation)
        else
            @messages = @conversation.messages.select{|msg| Message.exists?(msg.id)}
            render :index
        end
    end
    
    private
    
    def message_params
        params.require(:message).permit(:body, :user_id)
    end

    def find_conversation
        @conversation = Conversation.find(params[:conversation_id])
    end
    
end
