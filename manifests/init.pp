# Define: wkhtmltopdf
# 
# This modules installs wkhtmltopdf to the system
# 
# Parameters:
#   version: version string
#   arch: architecture, 'i386' or 'amd64', defaults to 'amd64'
#   target_dir: the directory to install to, defaults to '/usr/local/bin'
#
# Actions
#   downloads wkhtmltopdf to the desired location
#   renames it to 'wkhtmltopdf'
#
# Example use:
#   wkhtmltopdf { }
#
class wkhtmltopdf {
  if $operatingsystem != 'Ubuntu' {
	  fail("wkhtmltopdf only supports ubuntu!")
  }

  $version = '0.12.2.1'
  $arch = 'amd64'
  $series = $::lsbdistcodename
  
  $filename = "wkhtmltox-${version}_linux-${series}-${arch}.deb"
  $source = "http://download.gna.org/wkhtmltopdf/0.12/${version}/${filename}"
  $deb_file = "/var/cache/${filename}"
  
  exec { "$deb_file":
    command => "wget --timestamping $source --output-document=$deb_file",
    require => [Package['wget'] ],
    path    => '/usr/bin:/bin',
    timeout => 600, # allow maximal 10 minutes for download
    creates => "$deb_file";
  }
  
  package { ["xfonts-75dpi", "xfonts-base", "xfonts-utils"]: }
  package {"wkhtmltox":
    ensure => latest,
    source => $deb_file,
    provider => dpkg,
    require  => [Exec["$deb_file"], Package["xfonts-75dpi"], Package["xfonts-base"], Package["xfonts-utils"]],
  }
}
