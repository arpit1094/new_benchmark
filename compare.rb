load 'imap.rb'
load 'rest.rb'

[100,250].each do |i|
  [10,50].each do |j|
    i_s = Time.now
    check_imap(j,i)
    i_t = (Time.now - i_s)
    puts "for #{i} total mails & processing #{j} mails at a time by IMAP time=#{i_t}"

    r_s = Time.now
    check_rest(j,i)
    r_t = (Time.now - r_s)
    puts "for #{i} total mails & processing #{j} mails at a time by REST time=#{r_t}"
  end
end