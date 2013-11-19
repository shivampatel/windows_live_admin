Gem::Specification.new do |s|
  s.name	       = 'windows_live_admin'
  s.version	       = '1.0.0'
  s.date	       = '2013-11-20'
  s.summary	       = "Windows Live Admin API wrapper"
  s.description	       = "Easy ruby wrapper of the Windows Live Admin API to easily manage your domains, users and their services (including outlook email inboxes). Currently only supports create_domain and delete_domain methods. More to come in future releases."
  s.authors	       = ["Shivam Patel"]
  s.email	       = 'shivam@shivampatel.net'
  s.files	       = ["lib/windows_live_admin.rb", "lib/windows_live_admin/templates.rb"]
  s.homepage	       = 'http://msdn.microsoft.com/en-us/library/bb259710.aspx'
  s.licence	       = 'MIT'
end
