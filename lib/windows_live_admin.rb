require 'net/http'
require 'rexml/document'
require 'windows_live_admin/templates.rb'

# This creates an windows admin live account instance.
# The object instantiated will have various member/user/email manipulation methods.
#
# @author Shivam Patel 
class WindowsLiveAdmin
  include Templates # include the XML templates that various calls require

  def initialize(username, password)
    @username = username
    @password = password

    begin
    login_url = get_login_url
    login_template = get_login_data_template
    @auth_data = get_auth_data(login_url, login_template)
    rescue
      @auth_data = nil
    end
  end

  def get_login_url
    http, request = get_request_headers('http://domains.live.com/Service/ManageDomain/V1.0/GetLoginUrl')
    request.body = get_login_url_xml
    #puts @request.body
    response = http.request(request)
    login_url =  REXML::XPath.first(REXML::Document.new(response.body), "//GetLoginUrlResult").text

  end

  def get_login_data_template
    http, request = get_request_headers("http://domains.live.com/Service/ManageDomain/V1.0/GetLoginDataTemplate")
    request.body = get_login_data_template_xml
     #puts @request.inspect
    response = http.request(request)
    # puts response.body
    template =  REXML::XPath.first(REXML::Document.new(response.body), "//GetLoginDataTemplateResult").text
    template.gsub!(/%NAME%/, @username)
    template.gsub!(/%PASSWORD%/, @password)
  end

  def get_auth_data(login_url, login_template)
    uri = URI.parse(login_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(login_url)

    request.body = login_template
    response = http.request(request)
    @auth_data =  REXML::XPath.first(REXML::Document.new(response.body), "//Redirect").text
    @auth_data.gsub!(/&/, "&amp;") # rexml converts &amp; to &. Convert them back to &amp;
  end

  def verify_auth_data
    http, request = get_request_headers("http://domains.live.com/Service/ManageDomain/V1.0/VerifyAuthData")
    request.body = verify_auth_data_xml

    # puts request.body
    response = http.request(request)
    # puts response.body
    begin
      authorized = REXML::XPath.first(REXML::Document.new(response.body), "//VerifyAuthDataResult").text
    end
    return authorized
  end

  # This method will add a user to the specified domain and provision an email account for her
  # The member name is a email id of the member.
  # Note that the corresponding domain should be already manually added and configured in the
  # windows admin live center by logging on to the web interface.
  #
  # @param member_name [String] the complete email id of the member. eg. someone@example.com
  #   Note that this domain should be already added and activated via the web interface at http://domains.live.com
  # @param password [String] the desired password for the user/member.
  # @param reset_password [Boolean] a true/false value whether we want member to be forced to change her
  #  password on first login.
  # @param first_name [String] first name of member
  # @param last_name [String] last name of member
  # @param lcid [Sting] member's locale ID. Can be blank or nil
  # @return [Array] An [status, message] array where status is a true/false boolean indicating if create_member was
  #   successful or not. message contains relevant error message if the status is false.
  #
  def create_member(member_name, password, reset_password, first_name, last_name, lcid=nil)
    http, request = get_request_headers("http://domains.live.com/Service/ManageDomain/V1.0/CreateMember")

    request.body = create_member_xml(member_name, password, reset_password, first_name, last_name, lcid)
    #puts request.body
    response = http.request(request)
    # puts response.body

    error = is_error?(response.body) # if response is an error xml, error string describes the error

    if error # Response XML had in error node called ErrorDescription
      return ["false", error]
    else                 # Absence of ErrorDescription node is taken as success
      return ["true", "Member #{first_name} #{last_name} (#{member_name}) successfully created."]
    end

  end # end method create_member

  def delete_member(member_name)
    http, request = get_request_headers("http://domains.live.com/Service/ManageDomain/V1.0/DeleteMember")

    request.body = delete_member_xml(member_name)
    #puts request.body
    response = http.request(request)
    # puts response.body

    error = is_error?(response.body) # if response is an error, error is a string describing the error

    if error # Response XML had in error node called ErrorDescription
      return ["false", error]
    else                 # Absence of ErrorDescription node is taken as success
      return ["true", "Member #{member_name} successfully deleted."]
    end

  end # end method create_member

  private
  def is_error?(response_xml)
    is_error_response =  REXML::XPath.first(REXML::Document.new(response_xml), "//faultstring")
    if response_xml.nil?
      return "Response is nil"
    elsif is_error_response # Response XML has a error node called ErrorDescription
      error = is_error_response.text
      # check if there is an ErrorCode node
      errorcode_node =  REXML::XPath.first(REXML::Document.new(response_xml), "//ErrorCode")
      error = (errorcode_node.text + ": " + error) if errorcode_node # if there exists a errorcode node, append error code in error message
      return error
    else
      return false # the response xml is not a error response
    end
  end # end is_error? method

  def get_request_headers(action_url)
    uri = URI.parse("https://domains.live.com")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new("/service/managedomain2.asmx")
    request.add_field('Content-Type', 'text/xml; charset=utf-8')
    request.add_field('SOAPAction', action_url)
    return http, request
  end

end# end of class