## Windows Live Admin API

This is a ruby interface to the Windows Live Admin API.
You can manage your domains, users and their services (eg. outlook email inboxes)
using this pure ruby API. Currently this only supports create_domain and delete_domain methods.
More methods will be added in future releases.

The knowledge of the Microsoft API is not required for using this ruby gem.
However, for those interested the Microsoft documentation of Windows Live Admin API is at [http://msdn.microsoft.com/en-us/library/bb259710.aspx](http://msdn.microsoft.com/en-us/library/bb259710.aspx).

Examples of the actual SOAP API calls are documented at the
[ManageDomain2 webpage](https://domains.live.com/service/managedomain2.asmx).

### Usage
The usage of this API is very straightforward. Usage examples are shown below.
Please refer the documemtation for detailed usage.

#### Get API code
Install the gem (**preferred way**)
```shell
gem install windows_live_admin
```
of clone the code from github
```shell
git clone https://github.com/shivampatel/windows_live_admin.git
```

#### Require the gem

```shell
require 'windows_live_admin' 
```

#### Instantiate a account object
```shell
account = WindowsLiveAdmin.new("your_account@live.com", "your_password")
```

#### Create new member
```shell
# Note that the domain mydomain.com in the example below 
# should be already added to the admin center via
# the web interface at https://domains.live.com
account.create_member("newuser@mydomain.com", "user_password", true, "Shivam", "Patel")
```

#### Delete existing member
```shell
account.delete_member("newuser@mydomain.com")
```

##### More methods will be included in future versions of this gem.