module Templates

  def get_login_url_xml
    str = <<-eos
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetLoginUrl xmlns="http://domains.live.com/Service/ManageDomain/V1.0">
      <memberNameIn>#{@username}</memberNameIn>
    </GetLoginUrl>
  </soap:Body>
</soap:Envelope>
    eos
  end

  def get_login_data_template_xml
    str = <<-eos
<?xml version="1.0" encoding="utf-8"?>
  <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Body>
      <GetLoginDataTemplate xmlns="http://domains.live.com/Service/ManageDomain/V1.0" />
    </soap:Body>
</soap:Envelope>
    eos
  end

  def verify_auth_data_xml
    str = <<-eos
<?xml version="1.0" encoding="utf-8"?>
  <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Body>
      <VerifyAuthData xmlns="http://domains.live.com/Service/ManageDomain/V1.0">
        <authData>#{@auth_data}</authData>
      </VerifyAuthData>
    </soap:Body>
</soap:Envelope>
    eos
  end

  def create_member_xml(member_name, password, reset_password, first_name, last_name, lcid)
    str = <<-eos
<?xml version="1.0" encoding="utf-8"?>
  <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
      <ManageDomain2Authorization xmlns="http://domains.live.com/Service/ManageDomain/V1.0">
        <authorizationType>PassportTicket</authorizationType>
        <authorizationData>#{@auth_data}</authorizationData>
      </ManageDomain2Authorization>
    </soap:Header>
    <soap:Body>
      <CreateMember xmlns="http://domains.live.com/Service/ManageDomain/V1.0">
        <memberNameIn>#{member_name}</memberNameIn>
        <password>#{password}</password>
        <resetPassword>#{reset_password}</resetPassword>
        <firstName>#{first_name}</firstName>
        <lastName>#{last_name}</lastName>
        <lcid>#{lcid}</lcid>
      </CreateMember>
    </soap:Body>
</soap:Envelope>
    eos
  end

  def delete_member_xml(member_name)
    str = <<-eos
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <ManageDomain2Authorization xmlns="http://domains.live.com/Service/ManageDomain/V1.0">
      <authorizationType>PassportTicket</authorizationType>
      <authorizationData>#{@auth_data}</authorizationData>
    </ManageDomain2Authorization>
  </soap:Header>
  <soap:Body>
    <DeleteMember xmlns="http://domains.live.com/Service/ManageDomain/V1.0">
      <memberNameIn>#{member_name}</memberNameIn>
    </DeleteMember>
  </soap:Body>
</soap:Envelope>
    eos
  end

end # end of module Templates