module UsersHelper
  SCHOOLS = {
    /HEC/ => "hec.fr",
    /UPMC/ => "upmc.fr",
    /Centrale Lille/ => "ec-lille.fr",
    /Centrale Paris/ => "ecp.fr",
    /Ecole Polytechnique/ => "polytechnique.edu",
    /ENS Paris/ => "ens.fr",
    /Le Wagon/ => "lewagon.com"
  }
  def school_url(school)
    url = ""
    SCHOOLS.keys.each do |key|
      if key =~ school
        url = SCHOOLS[key]
      end
    end
    return url
  end
end
