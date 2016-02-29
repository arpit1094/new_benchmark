require 'net/imap'

  host = "imap.googlemail.com"
  port = '993'
  ssl = true
  folder = 'INBOX'
  username = "your_username"
  password = "your_password"
  @imap = Net::IMAP.new(host, port, ssl)
  @imap.login(username,password)
  @imap.select(folder)

def fetch_imap(ids)
  @imap.select("processing")
  msg = @imap.uid_fetch(ids[0],'RFC822')
  @imap.select("INBOX")
end

def check_imap(count,tot)
  f = Array.new
  c = 0
  @imap.uid_search(['NOT', 'SEEN']).each do |uid|

    @imap.instance_eval{ copy_internal("UID MOVE",uid, "processing") }
    f.push(uid)
    if(f.size == count)
      fetch_imap(f)
      f.clear
    end
    c+=1
    return if(c == tot)
  end

end