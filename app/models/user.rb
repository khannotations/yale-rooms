class User < ActiveRecord::Base
  has_and_belongs_to_many :organizations
  has_many :events, :through => :organizations

  validates_presence_of :netid
  validates_uniqueness_of :netid

  def as_json(options={})
    {
      name: name,
      college: college,
      year: year,
      organizations: organizations
    }
  end
  # Fetches user email from Yale directory
  def User.get_user netid
    name_regex = /^\s*Name:\s*$/i
    email_regex = /^\s*Email Address:\s*$/i
    # nick_regex = /^\s*Known As:\s*$/i
    year_regex = /^\s*Class Year:\s*$/i
    college_regex = /^\s*Residential College:\s*$/i

    browser = User.make_cas_browser
    browser.get("http://directory.yale.edu/phonebook/index.htm?searchString=uid%3D#{netid}")
    u = User.new
    u.netid = netid
    browser.page.search('tr').each do |tr|
      field = tr.at('th').text
      value = tr.at('td').text.strip
      case field
      when email_regex
        u.email = value
      when name_regex
        u.name = value
      when year_regex
        u.year = value
      when college_regex
        u.college = value
      end
    end
    u.save
    u
  end

  def User.make_cas_browser
    browser = Mechanize.new
    browser.get( 'https://secure.its.yale.edu/cas/login' )
    form = browser.page.forms.first
    form.username = ENV['CAS_NETID']
    form.password = ENV['CAS_PASS']
    form.submit
    browser
  end

end
