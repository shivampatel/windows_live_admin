# This module contains various template methods which return the XML request
# that needs to be sent to the server to perform corresponding tasks. 
# This module is mixed into the WindowsLiveAdmin class. Hence all the methods
# defined here can be invoked directly on the objects of WindowsLiveAdmin class
#
module Templates
  # Generates the XML required by the get_login_url method.
  # @return [String] Complete XML with username filled in
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

  # Generates the XML required by the get_login_data_template method.
  # @return [String] XML required to be sent to the server
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

  # Generates the XML required by the verify_auth_data method.
  # @return [String] Complete XML with auth_data filled in
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

  # Generates the XML required by the create_member method.
  # This is a helper function.
  # @param member_name [String] member's complete email id
  # @param password [String] member's desired password
  # @param reset_password [Boolean] a true/false value whether we want member to be forced to change her
  #  password on first login.
  # @param first_name [String] first name of member
  # @param last_name [String] last name of member
  # @param lcid [Sting] member's locale ID. Can be blank or nil 
  # @return [String] Complete XML with member details filled in
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

  # Generates the XML required by the delete_member method.
  # This is a helper function.
  # @param member_name [String] email id of the member who is to be deleted
  # @return [String] Complete XML with auth_data and member details filled in
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