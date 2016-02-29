require 'google/apis/gmail_v1'
load 'quickstart.rb'
# Initialize the API
  @service = Google::Apis::GmailV1::GmailService.new
  @service.client_options.application_name = APPLICATION_NAME
  @service.authorization = authorize
  # Show the user's labels
  @user_id = 'me'
  
def fetch_rest(ids)
  msg = @service.get_user_message(@user_id,ids[0])
end

def check_rest(count,tot)
  r = @service.list_user_messages(@user_id,:label_ids => ["INBOX","UNREAD"])
  while(r.messages.size < tot)
    temp = @service.list_user_messages(@user_id,:label_ids => ["INBOX","UNREAD"],:page_token => r.next_page_token)
    r.messages.push(*temp.messages)
  end
  if(r.messages)
    f = Array.new
    c = 0
    req = Google::Apis::GmailV1::ModifyMessageRequest.new
    req.add_label_ids = ["Label_3"]
    req.remove_label_ids = ["INBOX"]
    r.messages.each do |i|
        @service.modify_message(@user_id,i.id,req)
        f.push(i.id)
        if(f.size == count)
          fetch_rest(f)
          f.clear
        end
        c+=1
        return if(c == tot)
    end
  end
end
#check_rest(50,250)
